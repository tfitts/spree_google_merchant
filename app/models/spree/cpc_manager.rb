module Spree
  class CpcManager < Preferences::Configuration
    preference :target_spend_percent, :integer
    preference :max_cpc_minimum, :decimal
    preference :max_cpc_ceiling, :decimal
    preference :min_session_count, :integer
    preference :max_session_count, :integer
    preference :limit_sample_session_count, :boolean
    preference :sample_days_limit, :integer

    def set_variant_cpc(variant)
      variant = variant.master if variant.respond_to?(:master)
      history = Spree::PageTrafficSnapshot.where(:page => "/products/#{variant.product.slug}").order("id DESC").limit(preferred_sample_days_limit)
      session_sum = 0
      index = 0
      limit_sample_size = preferred_limit_sample_session_count
      while ((limit_sample_size && session_sum < preferred_max_session_count) || !limit_sample_size) && index < history.length
        session_sum += history[index].sessions
        index += 1
      end
      if session_sum >= preferred_min_session_count
        sample = history[0..index]
        revenue = sample.sum{|s|s.revenue}.to_f
        sessions = sample.sum{|s|s.sessions}.to_f
        per_session_value = revenue / sessions
        max_cpc = per_session_value * (preferred_target_spend_percent * 0.01)
        max_cpc = [max_cpc, preferred_max_cpc_ceiling].min
        max_cpc = [max_cpc, preferred_max_cpc_minimum].max
        variant.max_cpc = (max_cpc * 100).round * 0.01
        variant.save
      end
    end

    def update_ad_cpc(variant)
      variant.product_ads.each do |ad|
        next if ad.state == 'manual'
        if variant.max_cpc
          ad.max_cpc = variant.max_cpc
          ad.state = 'auto:variant'
        elsif ad.channel.default_max_cpc
          ad.max_cpc = ad.channel.default_max_cpc
          ad.state = 'auto:channel_default'
        end
        if ad.max_cpc < ad.channel.min_cpc
          ad.state = 'disabled'
        elsif ad.state == 'disabled'
          ad.state = 'auto:variant'
        end
        ad.save
      end
    end

    def set_variant_cpc_and_update_ads(variant)
      set_variant_cpc(variant)
      update_ad_cpc(variant)
    end

    def is_setup?
      preferred_target_spend_percent && preferred_max_cpc_minimum && preferred_max_cpc_ceiling && preferred_min_session_count && !limit_sample_session_count.nil? && preferred_sample_days_limit
    end
  end
end
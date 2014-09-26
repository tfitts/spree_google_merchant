module Spree
  class CpcManager < Preferences::Configuration
    preference :target_spend_percent, :integer
    preference :max_cpc_ceiling, :decimal
    preference :min_session_count, :integer

    def set_variant_cpc(variant)
      verify_settings
      variant = variant.master if variant.respond_to?(:master)
      history = Spree::PageTrafficSnapshot.where(:page => "/products/#{variant.permalink}").order(id: :desc).limit(200)
      session_sum = 0
      index = 0
      while session_sum < preferred_min_session_count && index < history.length
        session_sum += history[index].sessions
        index += 1
      end
      if session_sum >= preferred_min_session_count
        sample = history[0..index]
        revenue = sample.sum{|s|s.revenue}.to_f
        sessions = sample.sum{|s|s.sessions}.to_f
        per_session_value = revenue / sessions
        new_cpc = per_session_value * (preferred_target_spend_percent * 0.01)
        max_cpc = [new_cpc, preferred_max_cpc_ceiling].min
        variant.max_cpc = (new_cpc * 100).round * 0.01
        variant.save
      end
    end

    def update_ad_cpc(variant)
      variant.product_ads.each do |ad|
        ad.max_cpc = variant.max_cpc || ad.channel.default_max_cpc
        ad.state = 'disabled' if ad.max_cpc < ad.channel.min_cpc
        ad.save
      end
    end

    def set_variant_cpc_and_update_ads(variant)
      set_variant_cpc(variant)
      update_ad_cpc(variant)
    end

    def is_setup?
      preferred_target_spend_percent && preferred_max_cpc_ceiling && preferred_min_session_count
    end
  end
end
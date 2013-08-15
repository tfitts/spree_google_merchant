module Spree
  module Admin
    module GoogleMerchantHelper
      def setting_presentation_row(setting, hide_value = false)
        value = hide_value ? Spree.t(:not_shown) : Spree::GoogleMerchant::Config[setting].to_s
        value = "&mdash;" if value.blank?
        %(
        <tr>
          <th scope="row">#{I18n.t(setting, :scope => :google_merchant)}:</th>
          <td>#{value}</td>
        </tr>).html_safe
      end

      def setting_field(setting)
        type = Spree::GoogleMerchant::Config.preference_type(setting)
        res = ''
        res += label_tag(setting, Spree.t(setting) + ': ') + tag(:br) if type != :boolean
        res += preference_field_tag(setting, Spree::GoogleMerchant::Config[setting], :type => type)
        res += label_tag(setting, Spree.t(setting)) + tag(:br) if type == :boolean
        res.html_safe
      end
    end
  end
end

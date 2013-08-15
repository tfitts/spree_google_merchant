Spree::Core::Engine.routes.append do
  namespace :admin do
    resource :google_merchant_settings
  end
end

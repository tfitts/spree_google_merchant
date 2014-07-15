Spree::Core::Engine.routes.append do
  namespace :admin do
    resource :google_merchant_settings
  end

  namespace :api do
    resources :advertiser_product_types
  end
end

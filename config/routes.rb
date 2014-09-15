Spree::Core::Engine.routes.append do
  namespace :admin do
    resource :google_merchant_settings
    resources :product_ad_channels do
      resources :product_ads
    end
    resources :product_ads

    get '/products/:product_id/product_ads', :to => 'product_ads#index'
  end
end

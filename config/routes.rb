Rails.application.routes.draw do
  root to: 'dashboard#index'

  get "*any", via: :all, to: "errors#not_found"
end

YumixoLandingEn::Application.routes.draw do
  get "landing/index"

  get "welcome/index"
 
  root :to => 'landing#index'
  # match ':controller(/:action(/:id))(.:format)'
end

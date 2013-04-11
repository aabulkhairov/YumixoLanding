YumixoLandingEn::Application.routes.draw do
  get "landing/index"

  get "landing/index"
  get "landing/download"
  
  get "landing/completed"
  post "landing/save_email"
  match 'subscribe' => 'landing#subscribe'
  # Legal Stuff
  match 'terms-of-service' => "landing#terms"
  match 'privacy-policy' => "landing#policy"
  # end of legal stuff
  root :to => 'landing#landy'
  # match ':controller(/:action(/:id))(.:format)'
end

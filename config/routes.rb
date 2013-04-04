YumixoLandingEn::Application.routes.draw do
  get "landing/index"

  get "welcome/index"
  # Legal Stuff
  match 'terms-of-service' => "landing#terms"
  match 'privacy-policy' => "landing#policy"
  # end of legal stuff
  root :to => 'landing#candy'
  # match ':controller(/:action(/:id))(.:format)'
end

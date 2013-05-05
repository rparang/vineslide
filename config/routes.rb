Vine::Application.routes.draw do
  scope "api" do
    resources :videos
  end

  root :to => "main#index"
  match '*path', :to => "main#index"

end

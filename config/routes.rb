Grasshopper::Application.routes.draw do
  root 'site#index'

  scope :api do
    root to: "api#index", as: :api, defaults: {format: :json}

    resources :users, except: [ :edit, :new ], defaults: {format: :json} do
      get ':id' => "users#show", on: :collection
    end
  end

end

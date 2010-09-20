Refinery::Application.routes.draw do
  resources :galleries, :only => [:index, :show] do
    resources :gallery_entries, :only => [:index, :show]
  end

  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
    resources :galleries do
      collection do
        post :update_positions
      end
      resources :gallery_entries do
        collection do
          post :update_positions
        end
      end
    end
  end
end

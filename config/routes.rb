Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
	get 'info', to: 'static_pages#info'
	get 'test-page', to: 'static_pages#test-page'
	get 'options', to: 'static_pages#options'
	get '/our-process', to: 'static_pages#our_process', as: 'our_process'
	get 'testing', to: 'static_pages#testing'
	get 'thanks', to: 'static_pages#thanks'

	resources :charges, only: [:new, :create]
	resources :states
	resources :towns do
		collection do
			post :import
		end
	end

	resources :clinics do
		collection do
			post :import
		end
	end

	resources :locations, except: [:show] do
		collection do
			post :import
		end
	end

  mount ActionCable.server => '/cable'
  get '/chat', to: 'chatrooms#show'

	resources :messages, only: [:create]
end

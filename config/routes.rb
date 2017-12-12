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
	get 'chats', to: 'static_pages#chats'

	resources :charges, only: [:new, :create]
	resources :states
	resources :towns do
		collection do
			post :import
		end
	end

	resources :locations, except: [:show] do
		collection do
			post :import
		end
	end

	resources :users, only: [:index]
	resources :personal_messages, only: [:new, :create]
	resources :conversations, only: [:index, :show]


	resources :chatrooms, only: [:create] do
    member do
      post :close
    end

    resources :notes, only: [:create]
  end

  mount ActionCable.server => '/cable'
end

Rails.application.routes.draw do
  # ユーザー用
  # URL /customers/sign_in ...
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  #ユーザー側
  scope module: :public do
    root to: "homes#top"
    
    resources :notes
    resources :users, only: [:index,:show, :edit, :update]
  end

  #管理者側
  namespace :admin do
    root to: "homes#top"

    resources :users, only: [:index, :show, :edit, :update]
    resources :notes, only: [:index, :show]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

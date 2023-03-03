Rails.application.routes.draw do
  # ユーザー用devise
  # URL /customers/sign_in~
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'#ゲストログイン用
  end

  # 管理者用devise
  # URL /admin/sign_in~
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

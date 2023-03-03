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
  end
  
  namespace :public do
    get 'notes/new'
    get 'notes/index'
    get 'notes/show'
    get 'notes/edit'
  end
  namespace :public do
    get 'users/index'
    get 'users/show'
    get 'users/edit'
    get 'users/update'
  end
  
  #管理者側
  namespace :admin do
    get 'users/index'
    get 'users/show'
    get 'users/edit'
  end
  namespace :admin do
    get 'notes/index'
    get 'notes/show'
  end
  namespace :admin do
    get 'homes/top'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

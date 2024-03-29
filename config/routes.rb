Rails.application.routes.draw do
  namespace :admin do
    get 'tags/index'
    get 'tags/create'
    get 'tags/edit'
  end
  # ユーザー用devise
  # URL /customers/sign_in~
  devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions",
    passwords: "public/passwords"
  }
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"#ゲストログイン用
  end

  # 管理者用devise
  # URL /admin/sign_in~
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }


  #ユーザー側
  scope module: :public do
    root to: "homes#top"
    get "/about"=>"homes#about"

    resources :notes do
      resources :note_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
      collection do
        get "search"
        get "tos"
        get "manual"
        get "privacy_policy"
      end
    end

    resources :tags, only: [:index, :show ] do
      collection do
        get "search"
      end
    end

    resources :users, only: [:index,:show, :edit, :update] do
      member do
        get :favorites
      end
      collection do
        get "search"
      end
    end
    get "/users/:id/unsubscribe" => "users#unsubscribe", as: "unsubscribe"#退会確認画面
    patch "/users/:id/withdrawal" => "users#withdrawal", as: "withdrawal"#ｱｶｳﾝﾄの論理削除用
  end

  #管理者側
  namespace :admin do
    root to: "homes#top"

    resources :users, only: [:index, :show] do
      collection do
        get "search"
        get "deleted"
        get "total"
      end
    get "/users/:id/unsubscribe" => "users#unsubscribe", as: "unsubscribe"#退会確認画面
    patch "/users/:id/withdrawal" => "users#withdrawal", as: "withdrawal"#ｱｶｳﾝﾄの論理削除用
    end

    resources :notes, only: [:index, :show, :destroy] do
      collection do
        get "search"
      end
      resources :note_comments, only: [:destroy, :index] do#notesにネスト
        collection do
          get "search"
        end
      end
   end

    resources :tags, only: [:index, :show, :create, :edit, :update, :destroy] do
      collection do
        get "search"
      end
    end

  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

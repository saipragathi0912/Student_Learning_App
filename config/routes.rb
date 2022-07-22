Rails.application.routes.draw do
  
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
  	namespace :v1 do
      namespace :user_management do
        namespace :user do
          post 'auth/signup'
          delete 'auth/logout'
          post 'auth/login'
          post 'otp/otp_login'
          post 'otp/otp_signup'
          put  'auth/changemobile'
        end
      end
      namespace :student_management do
        namespace :student do
          post 'detail/enter'
          post 'print/details'
        end
        namespace :subject do
          post 'print/all'
          post 'chapter/all'
        end
        namespace :chapter do
          post 'print/all'
        end
        namespace :content do
          put 'option/change'
          put 'option/click'
        end
        namespace :question do
          post 'select/option'
          post 'select/review'
          post 'review/all'
          post 'print/all'
        end
      end
    end
  end
  
end

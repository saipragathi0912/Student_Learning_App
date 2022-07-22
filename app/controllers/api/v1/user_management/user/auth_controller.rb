require 'authy'
class Api::V1::UserManagement::User::AuthController < Api::V1::BaseController
	before_action :doorkeeper_authorize!, only: [:logout,:login,:view, :changemobile]
	before_action :validate_user!, only: [:logout,:view]
	
	def logout
		doorkeeper_token.destroy
	end

	def view
		render json: current_user, status: :ok
	end

    def signup
        ActiveRecord::Base.transaction do

			#throw_error("Email or Password is missing.", :unprocessable_entity) if signup_params[:email].blank? or signup_params[:password].blank?

			user = User.find_by(email: user_params[:email])
			if user.present?
				throw_error('A User with the given email id already exists', :unprocessable_entity) 
			else
			#or Rails.env.development?
            	user = User.new(signup_params)
            	user.save!
				unless Rails.env.test?
					@client = Twilio::REST::Client.new('AC4a9737f66dc2484501dec5f72b618949', '12728c36d7589c5ed9c8df0f625d4e8a')
					@client.verify.v2.services('VAf979b31f78ac39b851c40b5796788c63').verifications.create(:to=> signup_params[:mobilenumber], :channel => 'sms')
				end				
				otp=Faker::Number.number(digits: 4)
				otp=Otp.new(user_id:user.id,otp:1729)
				otp.save!
            	render json: { user: user} , status: :ok
			end
		end
	end
    
	def login
		@user = User.find_by(id: doorkeeper_token.resource_owner_id)
		@client = Twilio::REST::Client.new('AC4a9737f66dc2484501dec5f72b618949', '12728c36d7589c5ed9c8df0f625d4e8a')
		@client.verify.v2.services('VAf979b31f78ac39b851c40b5796788c63').verifications.create(:to=> signup_params[:mobilenumber], :channel => 'sms')				
		otp=Faker::Number.number(digits: 4)
		otp=Otp.new(user_id:user.id,otp:1729)
		otp.save!
		user = UserSerializer.new(@user).as_json
		render json: { user: user, token: token } , status: :created
	end
	def changemobile
        current_user=User.find_by(id: doorkeeper_token.resource_owner_id)
        current_user.mobilenumber = change_params[:mobilenumber]
        current_user.save
    end
	private
    def user_params
		params.permit(:email, :password, :refresh_token,:access_token,:mobilenumber,:dob,:name)
	end
    def signup_params
		params.permit(:email, :password,:mobilenumber,:dob,:name)
	end
	def change_params
        params.permit(:mobilenumber)
    end

end
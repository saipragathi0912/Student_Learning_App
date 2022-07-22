class Api::V1::UserManagement::User::OtpController < Api::V1::BaseController
    def otp_login
        #user=User.find_by(id:doorkeeper_token.resource_owner_id)
        if otplogin_params[:grant_type]=="access_token"
            access_token=Doorkeeper::AccessToken.find_by(token: otplogin_params[:token])
            if access_token.present?

                user=User.find_by(id:access_token.resource_owner_id)
                refresh_token=Doorkeeper::AccessToken.find_by(resource_owner_id:user.id).refresh_token
                otp = Otp.find_by(user_id: user.id)
                otp_code=otp.otp
                access_token.destroy
                #unless Rails.env.test?
                #    @client = Twilio::REST::Client.new('AC4a9737f66dc2484501dec5f72b618949', '12728c36d7589c5ed9c8df0f625d4e8a')
                #    verification_check = @client.verify.v2.services('VAf979b31f78ac39b851c40b5796788c63').verification_checks.create(to: user.mobilenumber, code: otplogin_params[:otp])
                #    otp_code=verification_check.status
                #end
                if(otp_code=="approved" or otp_code == otplogin_params[:otp].to_i)
                    new_token=Doorkeeper::AccessToken.create(
                        resource_owner_id: user.id,
                        refresh_token: refresh_token,
                        expires_in: Doorkeeper.configuration.access_token_expires_in.to_i,
                        scopes: 'user'
                    )
                    token =  {
                        access_token: new_token.token,
                        token_type: 'bearer',
                        expires_in: new_token.expires_in,
                        refresh_token: new_token.refresh_token,
                        created_at: new_token.created_at
                    }
                    render json: {message: "User Login Successfull",otp: otp,token: token},status: :ok
                else
                    render json: {message: "Incorrect OTP, please try again"},status: :ok
                end
            else
                throw_error("Access Token not found, try using refresh token", :unprocessable_entity)
            end
        else
            access_token=Doorkeeper::AccessToken.find_by(refresh_token: otplogin_params[:token])
            user=User.find_by(id:access_token.resource_owner_id)
            refresh_token=Doorkeeper::AccessToken.find_by(resource_owner_id:user.id).refresh_token
            access_token.destroy
            otp = Otp.find_by(user_id: user.id)
            otp_code=otp.otp
            #unless Rails.env.test?
            #    @client = Twilio::REST::Client.new('AC4a9737f66dc2484501dec5f72b618949', '12728c36d7589c5ed9c8df0f625d4e8a')
            #    verification_check = @client.verify.v2.services('VAf979b31f78ac39b851c40b5796788c63').verification_checks.create(to: user.mobilenumber, code: otplogin_params[:otp])
            #    otp_code=verification_check.status
            #end
            if(otp_code=="approved" or otp_code==otplogin_params[:otp].to_i)
                new_token=Doorkeeper::AccessToken.create(
                    resource_owner_id: user.id,
                    refresh_token: refresh_token,
                    expires_in: Doorkeeper.configuration.access_token_expires_in.to_i,
                    scopes: 'user'
                )
                token =  {
                    access_token: new_token.token,
                    token_type: 'bearer',
                    expires_in: new_token.expires_in,
                    refresh_token: new_token.refresh_token,
                    created_at: new_token.created_at
                }
                render json: {message: "User Login Successfull",otp: otplogin_params[:otp],token: token},status: :ok
            else
                render json: {message: "Incorrect OTP, please try again"},status: :ok
            end
        end
    end
    def otp_signup
        if(otpsignup_params[:email].blank? and otpsignup_params[:mobilenumber].blank?)
            throw_error("Email and Mobilenumber are missing", :unprocessable_entity)
        elsif otpsignup_params[:email].blank? 
            throw_error("Email is missing", :unprocessable_entity)
        elsif otpsignup_params[:mobilenumber].blank?
            throw_error("Mobile number is missing", :unprocessable_entity)
        else
            user=User.find_by(email:otpsignup_params[:email],mobilenumber:otpsignup_params[:mobilenumber])
            if user.present?
                otp=Otp.find_by(user_id:user.id)
                otp_code=otp.otp
                unless Rails.env.test?
                    @client = Twilio::REST::Client.new('AC4a9737f66dc2484501dec5f72b618949', '12728c36d7589c5ed9c8df0f625d4e8a')
                    verification_check = @client.verify.v2.services('VAf979b31f78ac39b851c40b5796788c63').verification_checks.create(to: user.mobilenumber, code: otplogin_params[:otp])
                    otp_code=verification_check.status
                end
                if(otp_code=="approved" or otp_code == otpsignup_params[:otp].to_i)
                    new_token = Doorkeeper::AccessToken.create(
		            resource_owner_id: user.id,
		            refresh_token: generate_refresh_token,
		            expires_in: Doorkeeper.configuration.access_token_expires_in.to_i,
		            scopes: 'user'
		            )
		            token =  {
			            access_token: new_token.token,
			            token_type: 'bearer',
			            expires_in: new_token.expires_in,
			            refresh_token: new_token.refresh_token,
			            created_at: new_token.created_at
		            }
                    render json: {message:"Signup Successfull",otp: otpsignup_params[:otp],token:token} , status: :ok
                else
                    render json: {message:"Incorrect OTP, please try again"},status: :ok
                end
            else
                throw_error("Invalid request headers",:unprocessable_entity)
            end
        end
    end
    private

    def otpsignup_params
        params.permit(:email,:mobilenumber,:otp)
    end
    def otplogin_params
        params.permit(:otp,:grant_type,:token)
    end
end
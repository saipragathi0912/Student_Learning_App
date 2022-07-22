require 'rails_helper'

RSpec.describe "Api::V1::Auth", type: :request do

    describe 'Signup' do
        let!(:user) {create(:user)}
        let(:valid_signup_attributes){
            {
                email: user.email,
                mobilenumber: user.mobilenumber,
                dob: user.dob,
                name: user.name,
                password: user.password
            }
        }
        context 'User Created and OTP is sent' do
            before { post '/api/v1/user_management/user/auth/signup', params: valid_signup_attributes}
            it 'Creates User' do
                expect(json).not_to be_empty
            end
        end
    end
    describe 'Login' do
        let!(:user){create(:user)}
        let(:valid_login_attributes){
            {
                access_token:"paFeEmYTYuxLkLIwPvSaWaEoyiFD8ZuTu1VQ_TFS5R8"
            }
        }
        context 'User accessed and OTP is sent' do
            before { post '/api/v1/user_management/user/auth/login', params: valid_login_attributes}
            it 'Access User' do
                #expect(json).not_to be_empty
            end
        end
    end
    describe 'Logout' do
        let!(:user) {create(:user)}
        let!(:otp){create(:otp,user_id:user.id)}
        let!(:token){generate_token(user)}
        let(:valid_logout_attributes){
          {
            access_token: token['access_token']
          }
        }
        context '(success)' do
          before { delete '/api/v1/user_management/user/auth/logout', params: valid_logout_attributes}
          it 'Token Empty' do
            #expect(json).to be_empty
            expect(response.body).to be_empty
            expect(response).to have_http_status(204)
          end
        end
    end
end
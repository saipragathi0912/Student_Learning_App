require 'rails_helper'

RSpec.describe "/api/v1/user_management/user/otp", type: :request do
  describe 'POST /api/v1/user_management/user/otp/otp_signup' do
    let!(:user) {create(:user)}
    let!(:otp)   {create(:otp, user_id:user.id)}
    let(:signup_headers) {
      {
        email: user.email,
        mobilenumber: user.mobilenumber,
        otp: "1729"
      }
    }
    let(:invalidotp_headers) {
      {
        email: user.email,
        mobilenumber: user.mobilenumber,
        otp: Faker::Number.number(digits: 4)
      }
    }
    let(:invalid_headers){
      {
        email: Faker::Internet.email,
        mobilenumber: Faker::PhoneNumber.phone_number,
        otp: Faker::Number.number(digits: 4)
      }
    }
    let(:empty_headers){
      {
          email: nil,
          mobilenumber: nil
      }
    }
    let(:email_empty){
      {
          mobilenumber: user.mobilenumber
        }
      }
    let(:mobile_empty){
      {
          email: user.email
        }
    }
    context '(Valid request headers)' do
      before { post '/api/v1/user_management/user/otp/otp_signup',params:signup_headers}
      it 'Returns valid user credentials' do
        expect(json['token']['access_token']).not_to be_nil
        expect(json['message']).to match(/Signup Successfull/)
      end
    end
    context '(Invalid OTP)' do
      before { post '/api/v1/user_management/user/otp/otp_signup',params:invalidotp_headers}
      it 'Returns error message' do
        expect(json['message']).to match(/Incorrect OTP, please try again/)
      end
    end
    context '(Invalid request headers)' do
      before { post '/api/v1/user_management/user/otp/otp_signup', params: invalid_headers}
      it 'Returns error message' do
        expect(json['message']).to match(/Invalid request headers/)
      end
    end
    context '(Email and Mobilenumber is empty)' do
      before { post '/api/v1/user_management/user/otp/otp_signup', params: empty_headers}
      it 'Returns failure message' do
        expect(json['message']).to match(/Email and Mobilenumber are missing/)
      end
    end
    context '(Email is Empty)' do
      before { post '/api/v1/user_management/user/otp/otp_signup', params: email_empty}
      it 'Returns failure message' do
        expect(json['message']).to match(/Email is missing/)
      end
    end
    context '(Mobile number is empty)' do
      before { post '/api/v1/user_management/user/otp/otp_signup', params: mobile_empty}
      it 'Returns failure message' do
        expect(json['message']).to match(/Mobile number is missing/)
      end
    end
  end

  describe 'Login' do
    let!(:user) {create(:user)}
    let!(:otp) {create(:otp,user_id:user.id)}
    let!(:token){generate_token(user)}
    let(:valid_access_headers){
      {
        grant_type: "access_token",
        token: token['access_token'],
        otp: otp.otp
      }
    }
    let(:invalid_access_headers){
      {
        grant_type: "access_token",
        token: "hOWd9LZ0ZeHal5RaRyuz50ebZASut2tI1GGsQ_IyUbA",
        otp: 2390
      }
    }
    context '(Valid access token)' do
      before { post '/api/v1/user_management/user/otp/otp_login', params: valid_access_headers}
      it 'Token generated' do
        expect(json).not_to be_empty
        #expect(json["user"]).not_to be_empty
        #raise response.body
        expect(json["token"]).not_to be_empty
        token['access_token']=json["token"]
        expect(response).to have_http_status(200)
      end
    end
    context '(Invalid access token)' do
      before { post '/api/v1/user_management/user/otp/otp_login', params: invalid_access_headers}
      it 'Token generated' do
        expect(json['message']).to match(/Access Token not found, try using refresh token/)
      end
    end
    let(:valid_refresh_headers){
      {
        grant_type: "refresh_token",
        token: token['refresh_token'],
        otp: otp.otp
      }
    }
    context '(Login by Refresh Token)' do
      before { post '/api/v1/user_management/user/otp/otp_login', params: valid_refresh_headers}
      it 'Token generated' do
        expect(json).not_to be_empty
        #expect(json["user"]).not_to be_empty
        token['access_token']=json['token']
        expect(json["token"]).not_to be_empty
        expect(response).to have_http_status(200)
      end
    end
  end
end

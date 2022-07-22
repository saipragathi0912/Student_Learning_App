module RequestSpecHelper
    def json
      JSON.parse(response.body)
    end
    def valid_signup_headers(user)
      {
        "email" => user.email,
        "mobilenumber" => user.mobilenumber
    }.to_json
    end
    def generate_token(user)
      #post '/api/v1/user_management/user/auth/signup',params: { email: user.email, password: user.password, mobilenumber: user.mobilenumber, dob: user.dob, name: user.name }
      #puts response
      #if(JSON.parse(response.body).length!=0)
      post '/api/v1/user_management/user/otp/otp_signup', params:{ email:user.email,mobilenumber: user.mobilenumber,otp: Otp.find_by(user_id:user.id).otp}
      #end
      #puts response
      return JSON.parse(response.body)['token']
    end
  end
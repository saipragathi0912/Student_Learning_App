class Api::V1::StudentManagement::Student::PrintController < Api::V1::BaseController
    before_action :doorkeeper_authorize!
    before_action :validate_user!
    def details
	    user = User.find_by(id: doorkeeper_token.resource_owner_id)
        output=UserSerializer.new(user).as_json
        render json: {user: output},status: :ok
    end 

end
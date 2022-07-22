class Api::V1::StudentManagement::Student::DetailController < Api::V1::BaseController
    before_action :doorkeeper_authorize!
    before_action :validate_user!
    def enter
		user = User.find_by(id: doorkeeper_token.resource_owner_id)
        if(detail_params[:type].blank? or detail_params[:id].blank?)
            throw_error("Type or id is blank",:unprocessible_identity)
        else
            if(detail_params[:type]=="Board")
                user.board_id=detail_params[:id]
                user.save!
            else 
                user.class_id=detail_params[:id]
                user.save!
            end
            render json: {user: user}, status: :ok
        end
    end


    private

    def detail_params
        params.permit(:type,:id)
    end
end
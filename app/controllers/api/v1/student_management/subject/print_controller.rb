class Api::V1::StudentManagement::Subject::PrintController < Api::V1::BaseController
    before_action :doorkeeper_authorize!
    before_action :validate_user!
    def all
	    user = User.find_by(id: doorkeeper_token.resource_owner_id)
        subjects=Subject.where(user_id: user.id)
        output=Array.new
        for subject in subjects
            output<< SubjectSerializer.new(subject).as_json
        end
        render json:{subjects: output}, status: :ok
    end
end

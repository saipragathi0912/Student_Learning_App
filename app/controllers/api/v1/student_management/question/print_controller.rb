class Api::V1::StudentManagement::Question::PrintController < Api::V1::BaseController
    #before_action :doorkeeper_authorize!
    def all
        if question_params[:exercise_id].blank?
            throw_error("exercise_id is empty",:unprocessable_entity)
        else
	        #user = User.find_by(id: doorkeeper_token.resource_owner_id)
            questions=Question.where(exercise_id: question_params[:exercise_id])
            render json: {questions: questions}, status: :ok
        end
    end

    private

    def question_params
        params.permit(:exercise_id)
    end
end
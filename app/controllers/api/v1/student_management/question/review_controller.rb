class Api::V1::StudentManagement::Question::ReviewController < Api::V1::BaseController
    before_action :doorkeeper_authorize!
    before_action :validate_user!
    def all
        if review_params[:exercise_id].blank? or review_params[:number].blank?
            throw_error("Exercise_id or number is blank",:unprocessible_entity)
        else
            user = User.find_by(id: doorkeeper_token.resource_owner_id)
            questions=Question.where(exercise_id: review_params[:exercise_id])
            options=Array.new
            for question in questions
                attempt=Attempt.find_by(number: review_params[:number],user_id: user.id)
                response=Answer.find_by(attempt_id:attempt.id)
                options<< response.chosen_option
            end
            output=Array.new
            [questions, options].each do |question,option|
                temp=Array.new
                temp<<question
                temp<<option
                output<<temp
            end
            render json:{questions: output}, status: :ok
        end
    end
    private
    def review_params
        params.permit(:exercise_id,:number)
    end
end
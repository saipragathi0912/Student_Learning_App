class Api::V1::StudentManagement::Question::SelectController < Api::V1::BaseController
    before_action :doorkeeper_authorize!
    before_action :validate_user!
    def option
        if select_params[:question_id].blank? or select_params[:option].blank?
            throw_error("Question_id or option is blank",:unprocessible_entity)
        else
	        user = User.find_by(id: doorkeeper_token.resource_owner_id)
            attempt=Attempt.new
            answer=Answer.new
            answer.chosen_option=select_params[:option]
            #attempt.question_id=select_params[:question_id]
            #attempt.option=select_params[:option]
            attempt.user_id=user.id
            question=Question.find_by(id: select_params[:question_id])
            if(user.present?)
                attempt.number=1
            else
                attempt.number+=1
            end
            answer.review=false
            attempt.exercise_id=question.exercise_id
            attempt.save!
            answer.attempt_id=attempt.id
            answer.question_id=question.id
            answer.save!
            render json: {message: "Answer saved successfull"}, status: :ok
        end
    end
    def review
        if review_params[:number].blank? or review_params[:question_id].blank?
            throw_error("Number or question_id is blank",:unprocessible_entity)
        else
	        user = User.find_by(id: doorkeeper_token.resource_owner_id)
            attempt=Attempt.find_by(number: review_params[:number])
            answer=Answer.find_by(question_id: review_params[:question_id],attempt_id:attempt.id)
            if answer.present?
                answer.review=true
                answer.save!
                render json: {message: "Review marked successfully"}, status: :ok
            else
                render json: {message: "Answer not found"},status: :ok
            end
        end
    end
    private 
    def select_params
        params.permit(:question_id,:option)
    end

    def review_params 
        params.permit(:number,:question_id)
    end
end 
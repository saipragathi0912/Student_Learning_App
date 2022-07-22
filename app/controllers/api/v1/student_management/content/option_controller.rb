class Api::V1::StudentManagement::Content::OptionController < Api::V1::BaseController
    def change
        if option_params[:type].blank? or option_params[:value].blank? or option_params[:content_id].blank?
            throw_error("Type or Value or Content_id is blank",:unprocessable_entity)
        else
            content=Content.find_by(id: option_params[:content_id])
            if(params[:type]=="upvote")
                content.upvote=params[:value]
            elsif(params[:type]=="downvote")
                content.downvote=params[:value]
            else
                content.notes=params[:value]
            end
            render json: {message:"Update successfull"}, status: :ok
        end
    end
    def click
        if option_params[:content_id].blank?
            throw_error("Content_id is blank",:unprocessable_entity)
        else
            content=Content.find_by(id: params[:content_id])
            content.watched=true
            render json:{message: "Update successfull"},status: :ok
        end
    end
    private

    def option_params
        params.permit(:type,:value,:content_id)
    end
end
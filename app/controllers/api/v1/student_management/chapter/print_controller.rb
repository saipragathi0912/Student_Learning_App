class Api::V1::StudentManagement::Chapter::PrintController < Api::V1::BaseController
    before_action :doorkeeper_authorize!
    before_action :validate_user!
    def all
	    user = User.find_by(id: doorkeeper_token.resource_owner_id)
        subject=Subject.find_by(user_id: user.id,id:subject_params[:subject_id])
        if(subject.present?)
            chapters=Chapter.where(subject_id:subject.id)
            if(chapters.present?)
                output=Array.new
                for chapter in chapters
                    output<< ChapterSerializer.new(chapter).as_json
                end
                if(output.present?)
                        render json:{chapters:output}, status: :ok
                else
                    throw_error("No content found", :unprocessable_entity)
                end
            else
                throw_error("Chapters not found",:unprocessable_entity)
            end
        else
            throw_error("Subject not found", :unprocessable_entity)
        end
    end
    private 

    def subject_params
        params.permit(:subject_id)
    end
end

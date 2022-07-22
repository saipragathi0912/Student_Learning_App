class Api::V1::StudentManagement::Subject::ChapterController < Api::V1::BaseController
    before_action :doorkeeper_authorize!
    before_action :validate_user!
    def all
        if chapter_params[:subject_id].blank?
            throw_error("Subject id is empty")
        else 
            chapters=Chapter.where(subject_id: chapter_params[:subject_id])
            numOfExercises=Array.new
            exerciseList=Array.new
            names=Array.new
            progress=Array.new
            for chapter in chapters
                names<< chapter.name
                exercises=Exercise.where(chapter_id: chapter.id)
                numOfExercises<< exercises.length()
                completed=Array.new
	            user = User.find_by(id: doorkeeper_token.resource_owner_id)
                attempt=Attempt.find_by(user_id: user.id)
                exercises=Question.where(id:attempt.exercise_id)
                for exercise in exercises
                    completed<< exercise.id
                end
                completed=completed.uniq
                progress<< (completed.length()/exercises.length())
                summary=Chaptersummary.new
                summary.name=chapter.name
                summary.numofexercises=exercises.length()
                summary.progress=(completed.length()/exercises.length())
                summary.save!
            end
            output=Chaptersummary.all
            render json:{chapter: output}, option: :ok
        end

    end

    private

    def chapter_params
        params.permit(:subject_id)
    end
end
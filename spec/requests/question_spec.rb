require 'rails_helper'

RSpec.describe "/api/v1/student_management/question", type: :request do
    let!(:user){create(:user)}
    let!(:otp){create(:otp,user_id:user.id)}
    let!(:token){generate_token(:user)}
    let!(:subjects){create_list(:subject,5,user_id:user.id)}
    let!(:chapters){create_list(:chapter,5,subject_id:subjects.first.id)}
    let!(:exercises){create_list(:exercise,10,chapter_id:chapters.first.id)}
    let!(:questions){create_list(:question,10,question_id:exercises.first.id)}
    describe 'All' do
        context 'valid attributes' do
            let(:valid_attributes){
                {
                    exercise_id: exercises.first.id
                }
            }
            before { post '/api/v1/student_management/question/print/all', params: valid_attributes}
            it 'returns questions' do
                expect(json).not_to be_empty
                expect(response).to have_http_status(200)
            end
        end
        context 'invalid attributes' do
            let(:invalid_attributes){
                {
                    exercise_id: nil
                }
            }
            before { post '/api/v1/student_management/question/print/all',params: invalid_attributes}
            it 'returns error messages' do
                expect(json['message']).to match(/exercise_id is empty/)
                expect(response).to have_http_status(200)
            end
        end
    end
    let!(:user){create(:user)}
    let!(:otp){create(:otp,user_id:user.id)}
    let!(:token){generate_token(user)}
    let!(:subject){create(:subject,user_id:user.id)}
    let!(:chapter){create(:chapter,subject_id:subject.id)}
    let!(:exercise){create(:exercise,chapter_id:chapter.id)}
    let!(:questions){create_list(:question,10,exercise_id: exercise.id)}
    let!(:attempt){create(:attempt,user_id:user.id,exercise_id:exercise.id)}
    let!(:answer){create(:answer,attempt_id:attempt.id,question_id:questions.first.id)}
    describe 'Review Questions' do
        let(:valid_attributes){
            {
                exercise_id: exercise.id,
                number: attempt.number,
                access_token: token['access_token']
            }
        }
        let(:invalid_attributes){
            {
                exercise_id: nil,
                number: nil,
                access_token: token['access_token']
            }
        }
        context 'valid attributes' do
            before { post '/api/v1/student_management/question/review/all',params: valid_attributes}
            it 'displays review questions' do
                #puts response
                expect(json['questions']).not_to be_empty
                expect(response).to have_http_status(200)
            end
        end
        context 'invalid attributes' do
            before { post '/api/v1/student_management/question/review/all',params: invalid_attributes}
            it 'returns error message' do
                expect(json['message']).to match(/Exercise_id or number is blank/)
            end
        end
    end

    describe 'Select option' do
        let(:valid_attributes){
            {
                question_id: questions.first.id,
                option: answer.chosen_option,
                access_token: token['access_token']
            }
        }
        let(:invalid_attributes){
            {
                question_id: nil,
                option: nil,
                access_token: token['access_token']
            }
        }
        context 'valid attributes' do
            before { post '/api/v1/student_management/question/select/option',params: valid_attributes}
            it 'returns success message' do
                expect(json['message']).to match(/Answer saved successfull/)
                expect(response).to have_http_status(200)
            end
        end
        context 'invalid attributes' do
            before { post '/api/v1/student_management/question/select/option',params: invalid_attributes}
            it 'returns error message' do
                expect(json['message']).to match(/Question_id or option is blank/)
                expect(response).to have_http_status(200)
            end
        end
    end

    describe 'Select Review' do
        let!(:user){create(:user)}
        let!(:otp){create(:otp,user_id:user.id)}
        let!(:token){generate_token(user)}
        let!(:subject){create(:subject,user_id:user.id)}
        let!(:chapter){create(:chapter,subject_id:subject.id)}
        let!(:exercise){create(:exercise,chapter_id:chapter.id)}
        let!(:questions){create_list(:question,10,exercise_id: exercise.id)}
        let!(:attempt){create(:attempt,user_id:user.id,exercise_id:exercise.id)}
        let!(:answer){create(:answer,attempt_id:attempt.id,question_id:questions.first.id)}
        let!(:valid_attributes){
            {
                question_id: questions.first.id,
                number: attempt.number,
                access_token: token['access_token']
            }
        }

        let(:invalid_attributes){
            {
                question_id: nil,
                option: nil,
                access_token: token['access_token']
            }
        }
        context 'valid attributes' do
            before { post '/api/v1/student_management/question/select/review', params: valid_attributes}
            it 'returns success message' do
                puts attempt.number
                puts answer.question_id
                puts questions.first.id
                puts answer.attempt_id
                puts attempt.id
                expect(json['message']).to match(/Review marked successfully/)
                expect(response).to have_http_status(200)
            end 
        end
        context 'invalid attributes' do
            before { post '/api/v1/student_management/question/select/review', params: invalid_attributes}
            it 'returns error message' do
                expect(json['message']).to match(/Number or question_id is blank/)
                expect(response).to have_http_status(200)
            end
        end
    end
end
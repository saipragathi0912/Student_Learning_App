require 'rails_helper'

RSpec.describe "/api/v1/student_management/content", type: :request do
    describe 'Change' do
        let!(:user){create(:user)}
        let!(:subject){create(:subject,user_id:user.id)}
        let!(:chapter){create(:chapter,subject_id:subject.id)}
        let!(:content){create(:content,chapter_id:chapter.id)}
        context 'valid attributes' do
            let(:valid_parameters){
                {
                    content_id:content.id,
                    type:"upvote",
                    value:true                                                             
                }
            }
            before { put '/api/v1/student_management/content/option/change', params: valid_parameters}
            it 'updates attribute value' do
                expect(json['message']).to match(/Update successfull/)
                expect(response).to have_http_status(200)
            end
        end
        context 'invalid attributes' do
            let(:invalid_parameters){
                {
                    content_id: nil,
                    type: nil,
                    value: false
                }
            }
            before { put '/api/v1/student_management/content/option/change', params: invalid_parameters}
            it 'returns error message' do
                expect(json['message']).to match(/Type or Value or Content_id is blank/)
                expect(response).to have_http_status(200)
            end
        end
    end

    describe 'Click' do
        let!(:user){create(:user)}
        let!(:subject){create(:subject,user_id:user.id)}
        let!(:chapter){create(:chapter,subject_id:subject.id)}
        let!(:content){create(:content,chapter_id:chapter.id)}
        context 'valid attributes' do
            let(:valid_parameters){
                {
                    content_id:content.id
                }
            }
            before { put '/api/v1/student_management/content/option/click', params: valid_parameters}
            it 'returns success message' do
                expect(json['message']).to match(/Update successfull/)
                expect(response).to have_http_status(200)
            end
        end
        context 'invalid attributes' do
            let(:invalid_parameters){
                {
                    content_id: nil
                }
            }
            before { put '/api/v1/student_management/content/option/click', params: invalid_parameters}
            it 'returns error message' do
                expect(json['message']).to match(/Content_id is blank/)
                expect(response).to have_http_status(200)
            end
        end
    end
end
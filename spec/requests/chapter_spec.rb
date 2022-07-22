require 'rails_helper'

RSpec.describe "/api/v1/student_management/chapter/print/all", type: :request do
    let!(:user){create(:user)}
    let!(:subject){create(:subject,user_id:user.id)}
    let!(:chapters){create_list(:chapter,10,subject_id:subject.id)}
    let!(:contents){create_list(:content,10,chapter_id:chapters.first.id)}
    #let!(:token){create(:token,resource_owner_id: user.id)}
    let!(:otp){create(:otp,user_id:user.id)}
    #let!(:token){create(:token,resource_owner_id:user.id)}
    let!(:user_no_chapter){create(:user)}
    let!(:otp_no_chapter){create(:otp,user_id:user_no_chapter.id)}
    let!(:token){generate_token(user)}
    let!(:token_no_chapter){generate_token(user_no_chapter)}
    let!(:subject_nochapter){create(:subject,user_id:user_no_chapter.id)}
    describe 'All' do
        let(:valid_parameters){
            { 
                "subject_id": subject.id,
                "access_token": token['access_token']
            }   
        }
        let(:valid_nochapter_parameters){
            {
                "subject_id":subject_nochapter.id,
                "access_token": token_no_chapter['access_token']
            }
        }
        context 'User found' do
            before { post '/api/v1/student_management/chapter/print/all',params: valid_parameters}
            it 'Displays all chapters' do
                puts message
                expect(json).not_to be_empty
                #expect(response).not_to be_empty
                expect(response).to have_http_status(200)
            end
        end
        context 'No chapters present' do
            before { post '/api/v1/student_management/chapter/print/all',params: valid_nochapter_parameters}
            it 'Has no chapter' do
                expect(json["message"]).to match(/Chapters not found/)
                expect(response).to have_http_status(200)
            end
        end
    end
end

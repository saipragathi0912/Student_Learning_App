require 'rails_helper'

RSpec.describe "/api/v1/student_management/subject", type: :request do
    let!(:user){create(:user)}
    let!(:otp){create(:otp,user_id:user.id)}
    let!(:subject){create(:subject,user_id:user.id)}
    let!(:token){generate_token(user)}
    describe 'Prints Subject Stats' do
        let(:valid_attributes){
            {access_token: token['access_token']}
        }
        context 'valid attributes' do
            before{ post '/api/v1/student_management/subject/print/all', params: valid_attributes}
            it 'returns user subject details' do
                expect(json).not_to be_empty
                expect(response).to have_http_status(200)
            end    
        end
        context 'invalid attributes' do
            before{ post '/api/v1/student_management/subject/print/all'}
            it 'does not display error message' do
                expect(response).to have_http_status(401)
            end
        end
    end
    describe 'Prints chapter stats' do
        let(:user){create(:user)}
        let(:otp){create(:otp,user_id:user.id)}
        let(:subject){create(:subject,user_id: user.id)}
        let(:token){generate_token(user)}
        let(:valid_attributes){
            {
                subject_id:subject.id,
                access_token: token['access_token']
            }
        }
        let(:invalid_attributes){
            {
                subject: nil,
                access_token: token['access_token']
            }
        }
        context 'valid attributes' do
            before{ post '/api/v1/student_management/subject/chapter/all', params: valid_attributes}
            it 'returns chapter statistics' do
                expect(json).not_to be_empty
                expect(response).to have_http_status(200)
            end
        end
        context 'invalid attributes' do
            before{ post '/api/v1/student_management/subject/chapter/all',params: invalid_attributes}
            it 'returns error message' do
                expect(json['message']).to match(/Subject id is empty/)
                expect(response).to have_http_status(200)
            end
        end
    end
end
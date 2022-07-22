require 'rails_helper'

RSpec.describe "/api/v1/student_management/student", type: :request do
    let!(:user){create(:user)}
    let!(:otp){create(:otp,user_id:user.id)}
    let!(:token){generate_token(user)}
    let(:valid_parameters){
        {
            type:"Board",
            id: 4,
            access_token: token['access_token']
        }
    }
    let(:invalid_parameters){
        {
            type: nil,
            id: nil,
            access_token: token['access_token']
        }
    }
    describe 'Enter details' do
        context 'valid_attributes' do
            before { post '/api/v1/student_management/student/detail/enter', params: valid_parameters}
            it 'updates details' do
                expect(json).not_to be_empty
                expect(response).to have_http_status(200)
            end
        end
        context 'invalid_attributes' do
            before { post '/api/v1/student_management/student/detail/enter', params: invalid_parameters}
            it 'displays error message' do
                expect(json['message']).to match(/Type or id is blank/)
                expect(response).to have_http_status(200)
            end
        end
    end
    describe 'Print User Details' do
        let(:valid_attributes){
            {
                access_token: token['access_token']
            }
        }
        before { post '/api/v1/student_management/student/print/details',params: valid_attributes}
        it 'returns user details' do
            #puts user.name
            expect(json['user']).not_to be_empty
            expect(response).to have_http_status(200)
        end
    end
end
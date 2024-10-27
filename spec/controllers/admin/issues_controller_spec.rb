# frozen_string_literal: true

# spec/controllers/admin/issues_controller_spec.rb

require 'rails_helper'

RSpec.describe Admin::IssuesController, type: :controller do
  let(:issue) { create(:issue) }
  let(:user) { create(:user, admin: true) }

  before do
    sign_in user
  end

  describe 'GET #new' do
    it 'assigns a new issue as @issue' do
      get :new
      expect(assigns(:issue)).to be_a_new(Issue)
    end
  end

  describe 'DELETE #destroy' do
    # it 'destroys the requested issue' do
    #   issue
    #   expect {
    #     delete :destroy, params: { id: issue.to_param }
    #   }.to change(Issue, :count).by(-1)

    # end

    # it 'redirects to the issues list with HTML format' do
    #   delete :destroy, params: { id: issue.to_param }
    #   binding.pry
    #   expect(response).to have_http_status(:no_content)
    # end

    # it 'responds with no content for turbo stream format' do
    #   delete :destroy, params: { id: issue.to_param }, format: :turbo_stream
    #   expect(response).to have_http_status(:no_content)
    # end
  end
end
# frozen_string_literal: true

# spec/controllers/subjects_controller_spec.rb

require 'rails_helper'

RSpec.describe SubjectsController, type: :controller do
  let(:user) { create(:user, admin: true) }
  let(:grow) { create(:grow) }
  let(:subject_instance) { create(:subject, grow:) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'assigns all subjects as @subjects' do
      subject_instance
      get :index, params: { grow_id: grow.id }
      expect(assigns(:subjects)).to eq([subject_instance])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested subject as @subject' do
      get :show, params: { id: subject_instance.to_param, grow_id: grow.id }
      expect(assigns(:subject)).to eq(subject_instance)
    end
  end

  describe 'GET #new' do
    it 'assigns a new subject as @subject' do
      get :new, params: { grow_id: grow.id }
      expect(assigns(:subject)).to be_a_new(Subject)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested subject as @subject' do
      get :edit, params: { id: subject_instance.to_param, grow_id: grow.id }
      expect(assigns(:subject)).to eq(subject_instance)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_attributes) { attributes_for(:subject, grow_id: grow.id) }

      it 'creates a new Subject' do
        expect {
          post :create, params: { subject: valid_attributes, grow_id: grow.id }
        }.to change(Subject, :count).by(1)
      end

      it 'redirects to the created subject' do
        post :create, params: { subject: valid_attributes, grow_id: grow.id }
        expect(response).to redirect_to(admin_grow_subject_path(grow, Subject.last))
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) { attributes_for(:subject, name: nil, grow_id: grow.id) }

      it 'does not create a new Subject' do
        expect {
          post :create, params: { subject: invalid_attributes, grow_id: grow.id }
        }.not_to change(Subject, :count)
      end

      it 'renders the new template' do
        post :create, params: { subject: invalid_attributes, grow_id: grow.id }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      let(:new_attributes) { { name: 'Updated Name' } }

      it 'updates the requested subject' do
        patch :update, params: { id: subject_instance.to_param, subject: new_attributes, grow_id: grow.id }
        subject_instance.reload
        expect(subject_instance.name).to eq('Updated Name')
      end

      it 'redirects to the subject' do
        patch :update, params: { id: subject_instance.to_param, subject: new_attributes, grow_id: grow.id }
        expect(response).to redirect_to(admin_grow_subject_path(grow, subject_instance))
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) { { name: nil } }

      it 'does not update the subject' do
        patch :update, params: { id: subject_instance.to_param, subject: invalid_attributes, grow_id: grow.id }
        subject_instance.reload
        expect(subject_instance.name).not_to be_nil
      end

      it 'renders the edit template' do
        patch :update, params: { id: subject_instance.to_param, subject: invalid_attributes, grow_id: grow.id }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested subject' do
      subject_instance
      expect {
        delete :destroy, params: { id: subject_instance.to_param, grow_id: grow.id }
      }.to change(Subject, :count).by(-1)
    end

    it 'redirects to the subjects list' do
      delete :destroy, params: { id: subject_instance.to_param, grow_id: grow.id }
      expect(response).to redirect_to(admin_subjects_url)
    end
  end
end
# frozen_string_literal: true

# spec/controllers/todos_controller_spec.rb

require 'rails_helper'

RSpec.describe TodosController, type: :controller do
  let(:user) { create(:user, admin: true) }
  let(:todo) { create(:todo, user: user) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'assigns @todos and @dones' do
      get :index
      expect(assigns(:todos)).to eq(user.todos.where(todo_status: :todo).limit(20))
      expect(assigns(:dones)).to eq(user.todos.where(todo_status: :done).limit(20))
    end
  end

  describe 'GET #show' do
    it 'renders the show template' do
      get :show, params: { id: todo.id }
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #new' do
    it 'assigns a new Todo to @todo' do
      get :new
      expect(assigns(:todo)).to be_a_new(Todo)
    end
  end

  describe 'GET #edit' do
    it 'renders the edit template' do
      get :edit, params: { id: todo.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new todo' do
        expect {
          post :create, params: { todo: attributes_for(:todo, user_id: user.id) }
        }.to change(Todo, :count).by(1)
      end

      it 'redirects to todos_path' do
        post :create, params: { todo: attributes_for(:todo, user_id: user.id) }
        expect(response).to redirect_to(todos_path)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new todo' do
        expect {
          post :create, params: { todo: attributes_for(:todo, body: nil) }
        }.not_to change(Todo, :count)
      end

      it 're-renders the new template' do
        post :create, params: { todo: attributes_for(:todo, body: nil) }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH/PUT #update' do
    context 'with valid attributes' do
      it 'updates the todo' do
        patch :update, params: { id: todo.id, todo: { body: 'Updated Body' } }
        todo.reload
        expect(todo.body).to eq('Updated Body')
      end

      it 'redirects to todos_url' do
        patch :update, params: { id: todo.id, todo: { body: 'Updated Body' } }
        expect(response).to redirect_to(todos_url)
      end
    end

    context 'with invalid attributes' do
      it 'does not update the todo' do
        patch :update, params: { id: todo.id, todo: { body: nil } }
        todo.reload
        expect(todo.body).not_to be_nil
      end

      it 're-renders the edit template' do
        patch :update, params: { id: todo.id, todo: { body: nil } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the todo' do
      delete_todo = create(:todo, user: user)
      expect {
        delete :destroy, params: { id: delete_todo.id }
      }.to change(Todo, :count).by(-1)
    end

    it 'redirects to todos_url' do
      delete :destroy, params: { id: todo.id }
      expect(response).to redirect_to(todos_url)
    end
  end

  describe 'PATCH #done' do
    it 'marks the todo as done' do
      patch :done, params: { id: todo.id }
      todo.reload
      expect(todo.todo_status).to eq('done')
    end

    it 'redirects to todos_url with notice' do
      patch :done, params: { id: todo.id }
      expect(response).to redirect_to(todos_url)
      expect(flash[:notice]).to eq("Todo #{todo.body} marked as done.")
    end
  end

  describe 'PATCH #undone' do
    it 'marks the todo as undone' do
      todo.update(todo_status: :done)
      patch :undone, params: { id: todo.id }
      todo.reload
      expect(todo.todo_status).to eq('todo')
    end

    it 'redirects to todos_url with notice' do
      patch :undone, params: { id: todo.id }
      expect(response).to redirect_to(todos_url)
      expect(flash[:notice]).to eq("Todo #{todo.body} marked as undone.")
    end
  end
end
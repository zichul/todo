require 'rails_helper'

RSpec.describe TodosController, type: :controller do

  describe "POST #create" do #################################################

    context "with valid params" do
      before :each do
        @user = create :user
        login_user(@user)
      end

      it "creates a new Todo" do
        post :create, :todo => attributes_for(:todo)
        expect(Todo.count).to eql(1)
      end

      it "assigns a newly created todo as @todo" do
        post :create, :todo => attributes_for(:todo)
        expect(assigns(:todo)).to be_a(Todo)
        expect(assigns(:todo)).to be_persisted
      end

      it "redirects to the created todo" do
        post :create, :todo => attributes_for(:todo)
        expect(response).to redirect_to(Todo.last.list)
      end
    end
    
    context "logged out" do
      it "redirects to login path" do
        post :create, :todo => attributes_for(:todo)
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      before :each do
        @user = create :user
        login_user(@user)
      end
      

      it "updates the requested todo" do
        todo = create :todo
        new_name = "Updated name"
        put :update, {:id => todo.id, :todo => { :name => new_name }}
        todo.reload
        expect(todo.name).to eql(new_name)
      end

      it "assigns the requested todo as @todo" do
        todo = create :todo
        new_name = "Updated name"
        put :update, {:id => todo.id, :todo => { :name => new_name }}
        expect(assigns(:todo)).to eq(todo)
      end

      it "redirects to the todo" do
        todo = create :todo
        new_name = "Updated name"
        put :update, {:id => todo.id, :todo => { :name => new_name }}
        expect(response).to redirect_to(todo.list)
      end
    end

    context "with invalid params" do
      before :each do
        @user = create :user
        login_user(@user)
      end

      it "redirects to list path" do
        todo = create :todo
        new_name = ""
        put :update, {:id => todo.id, :todo => { :name => new_name }}
        expect(response).to redirect_to(todo.list)
      end
    end

    context "logged out" do
      it "redirects to login page" do
        todo = create :todo
        new_name = ""
        put :update, {:id => todo.id, :todo => { :name => new_name }}
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "DELETE #destroy" do
    context "logged in" do
      before :each do
        @user = create :user
        login_user(@user)
      end

      it "destroys the requested todo" do
        todo = create :todo
        expect {
          delete :destroy, :id => todo.id
        }.to change(Todo, :count).by(-1)
      end

      it "redirects to the todo todo" do
        todo = create :todo
        delete :destroy, :id => todo.id
        expect(response).to redirect_to(todo.list)
      end
    end
    context "logged out" do
      it "redirects to the todo todo" do
        todo = create :todo
        delete :destroy, :id => todo.id
        expect(response).to redirect_to login_path
      end
    end
  end

end

require 'rails_helper'

RSpec.describe ListsController, type: :controller do


  describe "GET #index" do ####################################################
    context "logged in" do
      before :each do
        @user = create :user
        login_user(@user)
      end

      it "assigns all lists as @lists" do
        list = create_list :list, 5
        get :index
        expect(assigns(:lists)).to eq(list)
      end
    end

    context "logged in" do
      it "redirects to login path" do
        list = create_list :list, 5
        get :index
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "GET #show" do ####################################################
    context "logged in" do
      before :each do
        @user = create :user
        login_user(@user)
      end

      it "assigns the requested list as @list" do
        list = create :list
        get :show, :id => list.id
        expect(assigns(:list)).to eq(list)
      end
    end

    context "logged out" do
      it "assigns the requested list as @list" do
        list = create :list
        get :show, :id => list.id
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "GET #shared" do ####################################################
    context "logged in" do
      before :each do
        @user = create :user
        login_user(@user)
      end

      it "assigns the requested list as @list" do
        list = create :list
        get :shared, :token => list.token
        expect(assigns(:list)).to eq(list)
      end
    end

    context "logged in" do
      it "assigns the requested list as @list" do
        list = create :list
        get :shared, :token => list.token
        expect(assigns(:list)).to eq(list)
      end
    end
  end

  describe "GET #new" do ####################################################
    context "logged in" do
      before :each do
        @user = create :user
        login_user(@user)
      end

      it "assigns a new list as @list" do
        get :new
        expect(assigns(:list)).to be_a_new(List)
      end
    end

    context "logged out" do
      it "assigns the requested list as @list" do
        list = create :list
        get :new
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "GET #edit" do ####################################################
    context "logged in" do
      before :each do
        @user = create :user
        login_user(@user)
      end

      it "assigns the requested list as @list" do
        list = create :list
        get :edit, :id => list.id
        expect(assigns(:list)).to eq(list)
      end

    end

    context "logged out" do
      it "assigns the requested list as @list" do
        list = create :list
        get :edit, :id => list.id
        expect(response).to redirect_to login_path
      end

    end
  end

  describe "POST #create" do #################################################

    context "with valid params" do
      before :each do
        @user = create :user
        login_user(@user)
      end

      it "creates a new List" do
        post :create, :list => attributes_for(:list)
        expect(assigns(:current_user).lists.count).to eql(1)
      end

      it "assigns a newly created list as @list" do
        post :create, :list => attributes_for(:list)
        expect(assigns(:list)).to be_a(List)
        expect(assigns(:list)).to be_persisted
      end

      it "redirects to the created list" do
        post :create, :list => attributes_for(:list)
        expect(response).to redirect_to(List.last)
      end
    end

    context "with invalid params" do
      before :each do
        @user = create :user
        login_user(@user)
      end

      it "assigns a newly created but unsaved list as @list" do
        post :create, :list => attributes_for(:list, :title => '')
        expect(assigns(:list)).to be_a_new(List)
      end

      it "re-renders the 'new' template" do
        post :create, :list => attributes_for(:list, :title => '')
        expect(response).to render_template("new")
      end
    end
    
    context "logged out" do
      it "redirects to login path" do
        post :create, :list => attributes_for(:list)
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
      

      it "updates the requested list" do
        list = create :list
        new_title = "Updated title"
        put :update, {:id => list.id, :list => { :title => new_title }}
        list.reload
        expect(list.title).to eql(new_title)
      end

      it "assigns the requested list as @list" do
        list = create :list
        new_title = "Updated title"
        put :update, {:id => list.id, :list => { :title => new_title }}
        expect(assigns(:list)).to eq(list)
      end

      it "redirects to the list" do
        list = create :list
        new_title = "Updated title"
        put :update, {:id => list.id, :list => { :title => new_title }}
        expect(response).to redirect_to(list)
      end
    end

    context "with invalid params" do
      before :each do
        @user = create :user
        login_user(@user)
      end

      it "assigns the list as @list" do
        list = create :list
        new_title = ""
        put :update, {:id => list.id, :list => { :title => new_title }}
        expect(assigns(:list)).to eq(list)
      end

      it "re-renders the 'edit' template" do
        list = create :list
        new_title = ""
        put :update, {:id => list.id, :list => { :title => new_title }}
        expect(response).to render_template("edit")
      end
    end

    context "logged out" do
      it "redirects to login page" do
        list = create :list
        new_title = ""
        put :update, {:id => list.id, :list => { :title => new_title }}
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

      it "destroys the requested list" do
        list = create :list
        expect {
          delete :destroy, :id => list.id
        }.to change(List, :count).by(-1)
      end

      it "redirects to the lists list" do
        list = create :list
        delete :destroy, :id => list.id
        expect(response).to redirect_to(lists_url)
      end
    end
    context "logged out" do
      it "redirects to the lists list" do
        list = create :list
        delete :destroy, :id => list.id
        expect(response).to redirect_to login_path
      end
    end
  end

end

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

  describe "POST #create" do

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

  # describe "PUT #update" do
    # context "with valid params" do
      # let(:new_attributes) {
        # skip("Add a hash of attributes valid for your model")
      # }

      # it "updates the requested list" do
        # list = List.create! valid_attributes
        # put :update, {:id => list.to_param, :list => new_attributes}, valid_session
        # list.reload
        # skip("Add assertions for updated state")
      # end

      # it "assigns the requested list as @list" do
        # list = List.create! valid_attributes
        # put :update, {:id => list.to_param, :list => valid_attributes}, valid_session
        # expect(assigns(:list)).to eq(list)
      # end

      # it "redirects to the list" do
        # list = List.create! valid_attributes
        # put :update, {:id => list.to_param, :list => valid_attributes}, valid_session
        # expect(response).to redirect_to(list)
      # end
    # end

    # context "with invalid params" do
      # it "assigns the list as @list" do
        # list = List.create! valid_attributes
        # put :update, {:id => list.to_param, :list => invalid_attributes}, valid_session
        # expect(assigns(:list)).to eq(list)
      # end

      # it "re-renders the 'edit' template" do
        # list = List.create! valid_attributes
        # put :update, {:id => list.to_param, :list => invalid_attributes}, valid_session
        # expect(response).to render_template("edit")
      # end
    # end
  # end

  # describe "DELETE #destroy" do
    # it "destroys the requested list" do
      # list = List.create! valid_attributes
      # expect {
        # delete :destroy, {:id => list.to_param}, valid_session
      # }.to change(List, :count).by(-1)
    # end

    # it "redirects to the lists list" do
      # list = List.create! valid_attributes
      # delete :destroy, {:id => list.to_param}, valid_session
      # expect(response).to redirect_to(lists_url)
    # end
  # end

end

require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #show" do

    context "logged in" do

      before :each do
        @user = create :user, :static
        login_user(@user)
        get :show
      end

      it "renders the show template" do
        expect(response).to render_template(:show)
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "has current_user assigned" do
        expect(assigns(:current_user)).to be_present
      end

    end

    context "logged out" do

      before :each do
        @user = create :user, :static
        get :show
      end

      it "redirects to login page" do
        expect(response).to redirect_to login_path
      end

      it "returns http success" do
        expect(response).to have_http_status(:redirect)
      end

    end
  end

  describe "GET #new" do

    context "logged in" do

      before :each do
        @user = create :user, :static
        login_user(@user)
        get :new
      end

      it "returns redirect status" do
        expect(response).to have_http_status(:redirect)
      end

      it "redirects to root" do
        expect(response).to redirect_to root_path
      end
      
    end

    context "logged out" do
      before :each do
        get :new
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
      
      it "renders new template" do
        expect(response).to render_template(:new)
      end

    end
  end

  describe "GET #create" do

    context "logged in" do

      before :each do
        @user = create :user, :static
        login_user(@user)
        post :create, :user => attributes_for(:user)
      end

      it "returns http redirect status" do
        expect(response).to have_http_status(:redirect)
      end

      it "redirects to #show" do
        expect(response).to redirect_to root_path
      end

    end

    context "logged out" do
      before :each do
        @user_attributes = attributes_for(:user)
        post :create, :user => @user_attributes
      end

      it "returns http success status" do
        expect(response).to have_http_status(:redirect)
      end

      it "redirects to login path" do
        expect(response).to redirect_to login_path
      end

      it "saves new object in database" do
        expect(User.last).to satisfy do |user|
          user.email == @user_attributes[:email]
        end
      end

    end
  end

  describe "GET #edit" do

    context "logged in" do

      before :each do
        @user = create(:user)
        login_user(@user)
        get :edit
      end

      it "renders the edit template" do
        expect(response).to render_template(:edit)
      end
      
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "has an user assigned" do
        expect(assigns(:user)).to eq(@user)
      end

      it "changes user parameters" do
        expect(assigns[:user]).to eq(@user)
      end

    end
    
    context "logged out" do
      before :each do
        @user = create(:user)
        get :edit
      end

      it "redirects to login path" do
        expect(response).to redirect_to login_path
      end
      
      it "returns http redirect" do
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe "GET #update" do

    context "logged in" do

      before :each do
        @user = create(:user)
        login_user(@user)
        @new_email = 'test@test.pl'
        @password = 'testpassword'
        post :update, :user => {:email => @new_email, :password => @password}
      end

      it "returns http found status" do
        expect(response).to have_http_status(:redirect)
      end

      it "redirects to #show" do
        expect(response).to redirect_to root_path
      end

      it "updates object in database" do
        expect(User.find(@user.id)).to satisfy do |user|
          user.id == @user.id
          user.email == @new_email
        end
      end
    end
    context "logged out" do
      before :each do

        @user = create(:user)
        post :update, :user => {:email => @new_email, :password => @password}
      end

      it "returns http found status" do
        expect(response).to have_http_status(:redirect)
      end

      it "redirects to #show" do
        expect(response).to redirect_to login_path
      end

    end
  end

  describe "GET #destroy" do

    context "logged in" do

      before :each do
        @user = create(:user)
        login_user(@user)
        delete :destroy
      end

      it "returns http success" do
        expect(response).to have_http_status(:redirect)
      end

      it "removes object from database" do
        expect(response).to redirect_to root_path
      end

      it "removes object from database" do
        expect(User.count).to eq(0)
      end

    end

    context "logged out" do

      before :each do
        @user = create(:user)
        delete :destroy
      end

      it "returns redirect status" do
        expect(response).to have_http_status(:redirect)
      end

      it "redirects to root path" do
        expect(response).to redirect_to login_path
      end

      it "didn't remove object from database" do
        expect(User.count).to eq(1)
      end

    end

  end
end

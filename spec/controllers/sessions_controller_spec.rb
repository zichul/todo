require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #new" do
    context "without users in database" do
      it "returns redirect status " do
        get :new
        expect(response).to have_http_status(:redirect)
      end

      it "redirects to registration page " do
        get :new
        expect(response).to redirect_to registration_path
      end
    end

    context "with users in database" do
      before :each do
        create :user
      end

      it "returns success status" do
        get :new
        expect(response).to have_http_status(:success)
      end

      it "renders new template" do
        get :new
        expect(response).to render_template(:new)
      end
    end
  end

  describe "POST #create" do

    context "correct attributes" do

      before :each do
        @user = create :user, :static
        attributes = attributes_for :user, :static
        @email = attributes[:email]
        @password = attributes[:password]
        @remember_me = true
        post :create,
          :email => @email,
          :password => @password,
          :remember_me => @remember_me

      end

      it "have current_user assigned" do
        expect(assigns(:current_user).email).to eql(@user.email)
      end

      it "returns success status" do
        expect(response).to have_http_status(:redirect)
      end

      it "returns success status" do
        expect(response).to have_http_status(:redirect)
      end
    end

    context "wrong attributes" do

      before :each do
        create :user, :static
        post :create
      end

      it "doesn't have current_user assigned" do
        expect(assigns(:current_user)).to be_nil
      end

      it "returns ok status" do
        expect(response).to have_http_status(:ok)
      end

      it "redirects to login path" do
        expect(response).to render_template :new
      end
    end
  end

  describe "GET #destroy" do

    before :each do
      @user = create :user, :static
      attributes = attributes_for :user, :static
      @email = attributes[:email]
      @password = attributes[:password]
      @remember_me = true
      post :create,
        :email => @email,
        :password => @password,
        :remember_me => @remember_me

    end

    it "returns http success" do
      expect(assigns(:current_user)).to be
      delete :destroy
      expect(assigns(:current_user)).to be_nil
    end
  end
end

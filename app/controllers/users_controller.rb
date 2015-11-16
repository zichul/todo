class UsersController < ApplicationController
  before_filter :logged_out, only: [:new, :create]
  before_filter :require_login, except: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def logged_out
    if current_user
      redirect_to root_path
      return false
    end
  end

  # GET /account
  def show
  end

  # GET /register
  def new
    @user = User.new
  end

  # GET /account/edit
  def edit
  end

  # POST /account
  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to login_path, notice: I18n.t(:user_created), scope: [:notice]
    else
      render :new
    end
  end

  # PATCH/PUT /account
  def update
    if @user.update(user_params)
      redirect_to root_path, notice: I18n.t(:user_updated)
    else
      render :edit
    end
  end

  # DELETE /account
  def destroy
    @user.destroy
    redirect_to root_path, notice: I18n.t(:user_destroyed)
  end

  private
    def set_user
      @user = current_user
    end

    def user_params
      params[:user].permit(:email, :password, :password_confirmation)
    end
end

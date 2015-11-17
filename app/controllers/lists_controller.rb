require 'socky/client'

class ListsController < ApplicationController
  before_filter :require_login, except: [:shared]
  before_action :set_list, only: [:show, :reset_token, :edit, :update, :destroy]
  after_action :update_socky, only: [:reset_token, :update, :destroy]

  # GET /lists
  # GET /lists.json
  def index
    @lists = current_user.lists.all
  end

  # GET /lists/1
  # GET /lists/1.json
  def show
    @todo = Todo.new()
    @todo.list = @list
  end

  # GET /shared_list/:token
  def shared
    @list = List.find_by_token(params[:token])
    @shared = true
    if @list.present?
      render :show
    else
      redirect_to root_path, notice: "List not found"
    end
  end

  def reset_token
    @list.regenerate_token
    respond_to do |format|
      if @list.save
        format.html { redirect_to shared_path(@list.token), notice: 'Shared link has been regenerated' }
        format.json { render :show, status: :ok, location: @list }
      else
        format.html { render :edit }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /lists/new
  def new
    @list = List.new
  end

  # GET /lists/1/edit
  def edit
  end

  # POST /lists
  # POST /lists.json
  def create
    @list = List.new(list_params)
    @list.user = current_user

    respond_to do |format|
      if @list.save
        format.html { redirect_to @list, notice: 'List was successfully created.' }
        format.json { render :show, status: :created, location: @list }
      else
        format.html { render :new }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lists/1
  # PATCH/PUT /lists/1.json
  def update
    respond_to do |format|
      if @list.update(list_params)
        format.html { redirect_to @list, notice: 'List was successfully updated.' }
        format.json { render :show, status: :ok, location: @list }
      else
        format.html { render :edit }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/1
  # DELETE /lists/1.json
  def destroy
    @list.destroy
    respond_to do |format|
      format.html { redirect_to lists_url, notice: 'List was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = current_user.lists.find(params[:id])
    end

    def update_socky
      $socky_client = Socky::Client.new('http://pacific-mesa-9385.herokuapp.com:80/http/todo', 'randomstring')
      channel = 'presence-' + @list.token[0..5]
      $socky_client.trigger!("reload", :channel => channel, :data => '')
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def list_params
      params.require(:list).permit(:title)
    end
end

class TodosController < ApplicationController
  before_filter :require_login
  before_action :set_todo, only: [:toggle, :edit, :update, :destroy]

  def toggle
    @todo.toggle_check
    respond_to do |format|
      if @todo.save
        format.html { redirect_to @todo.list, notice: 'Todo was successfully updated.' }
        format.json { render :show, status: :ok, location: @todo }
      else
        format.html { redirect_to @todo.list }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end

  end
  # POST /todos
  # POST /todos.json
  def create
    @todo = Todo.new(todo_params)
    @todo.list = List.find(params[:todo][:list_id])

    respond_to do |format|
      if @todo.save
        format.html { redirect_to @todo.list, notice: 'Todo was successfully created.' }
        format.json { render :show, status: :created, location: @todo }
      else
        format.html { redirect_to @todo.list }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /todos/1
  # PATCH/PUT /todos/1.json
  def update
    respond_to do |format|
      if @todo.update(todo_params)
        format.html { redirect_to @todo.list, notice: 'Todo was successfully updated.' }
        format.json { render :show, status: :ok, location: @todo }
      else
        format.html { redirect_to @todo.list }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todos/1
  # DELETE /todos/1.json
  def destroy
    @todo.destroy
    respond_to do |format|
      format.html { redirect_to @todo.list, notice: 'Todo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo
      @todo = Todo.find(params[:id])
      redirect_to login_path unless @todo.list.user == current_user
    end

    # Never trust parameters from the scary internet, only allow the white todo through.
    def todo_params
      params.require(:todo).permit(:name, :check)
    end
end

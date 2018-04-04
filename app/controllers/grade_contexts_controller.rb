class GradeContextsController < ApplicationController
  before_action :set_grade_context, only: [:show, :edit, :update, :destroy]
  def index
    @grid = GradeContextsGrid.new(grid_params) do |scope|
      scope.page(params[:page])
    end
  end

  def grid_params
    params.fetch(:grade_contexts_grid, {}).permit!
  end
  # GET /grade_contexts
  # GET /grade_contexts.json
  # def index
  #     @grade_contexts = GradeContext.all
  # end

  # GET /grade_contexts/1
  # GET /grade_contexts/1.json
  def show
  end

  # GET /grade_contexts/new
  def new
    @grade_context = GradeContext.new
  end

  # GET /grade_contexts/1/edit
  def edit
  end

  # POST /grade_contexts
  # POST /grade_contexts.json
  def create
    @grade_context = GradeContext.new(grade_context_params)

    respond_to do |format|
      if @grade_context.save
        format.html { redirect_to @grade_context, notice: 'Grade context was successfully created.' }
        format.json { render :show, status: :created, location: @grade_context }
      else
        format.html { render :new }
        format.json { render json: @grade_context.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /grade_contexts/1
  # PATCH/PUT /grade_contexts/1.json
  def update
    respond_to do |format|
      if @grade_context.update(grade_context_params)
        format.html { redirect_to @grade_context, notice: 'Grade context was successfully updated.' }
        format.json { render :show, status: :ok, location: @grade_context }
      else
        format.html { render :edit }
        format.json { render json: @grade_context.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /grade_contexts/1
  # DELETE /grade_contexts/1.json
  def destroy
    @grade_context.destroy
    respond_to do |format|
      format.html { redirect_to grade_contexts_url, notice: 'Grade context was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_grade_context
    @grade_context = GradeContext.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def grade_context_params
    params.require(:grade_context).permit(:name, :goal, :min_value, :max_value, :description, :custo)
  end
end

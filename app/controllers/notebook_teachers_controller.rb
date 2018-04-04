class NotebookTeachersController < ApplicationController
  before_action :set_notebook_teacher, only: [:show, :edit, :update, :destroy]

  # GET /notebook_teachers
  # GET /notebook_teachers.json
  def index
    @notebook_teachers = NotebookTeacher.all
  end

  # GET /notebook_teachers/1
  # GET /notebook_teachers/1.json
  def show
  end

  # GET /notebook_teachers/new
  def new
    @notebook_teacher = NotebookTeacher.new
  end

  # GET /notebook_teachers/1/edit
  def edit
  end

  # POST /notebook_teachers
  # POST /notebook_teachers.json
  def create
    @notebook_teacher = NotebookTeacher.new(notebook_teacher_params)

    respond_to do |format|
      if @notebook_teacher.save
        format.html { redirect_to @notebook_teacher, notice: 'Notebook teacher was successfully created.' }
        format.json { render :show, status: :created, location: @notebook_teacher }
      else
        format.html { render :new }
        format.json { render json: @notebook_teacher.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notebook_teachers/1
  # PATCH/PUT /notebook_teachers/1.json
  def update
    respond_to do |format|
      if @notebook_teacher.update(notebook_teacher_params)
        format.html { redirect_to @notebook_teacher, notice: 'Notebook teacher was successfully updated.' }
        format.json { render :show, status: :ok, location: @notebook_teacher }
      else
        format.html { render :edit }
        format.json { render json: @notebook_teacher.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notebook_teachers/1
  # DELETE /notebook_teachers/1.json
  def destroy
    @notebook_teacher.destroy
    respond_to do |format|
      format.html { redirect_to notebook_teachers_url, notice: 'Notebook teacher was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notebook_teacher
      @notebook_teacher = NotebookTeacher.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def notebook_teacher_params
      params.require(:notebook_teacher).permit(:notebook_id, :teacher_id, :custo)
    end
end

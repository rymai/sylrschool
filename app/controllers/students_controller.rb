class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  def index
    fname = "#{self.class.name}.#{__method__}"
    @grid = StudentsGrid.new(grid_params) do |scope|
      scope.page(params[:page])
    end
  end

  def grid_params
    params.fetch(:students_grid, {}).permit!
  end
  # GET /students
  # GET /students.json
  #def index
  ##  @students = Student.all
  #end

  # GET /students/1
  # GET /students/1.json
  def show
    @schedules=[]
    @student.student_class_school.teachings.to_a.each do |teaching|
      teaching.schedules.each do |schedule|
        @schedules << schedule
      end
    end
  end

  # GET /students/new
  def new
    fname = "#{self.class.name}.#{__method__}"
    @student = Student.new
    LOG.debug(fname){"@student=#{@student.inspect}"}
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students
  # POST /students.json
  def create
    fname = "#{self.class.name}.#{__method__}"
    @student = Student.new(student_params)
    LOG.debug(fname){"@student=#{@student.inspect}"}
    respond_to do |format|
      if @student.save
        format.html { redirect_to @student, notice: 'Student was successfully created.' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to @student, notice: 'Student was successfully updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    if @student.destroy
      respond_to do |format|
        format.html { redirect_to students_url, notice: 'Student was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to students_url, notice: 'Student was not destroyed (references ?).' }
        format.json { head :no_content }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_student
    @student = Student.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def student_params
    params.require(:student).permit(:name,:email, :phone1, :phone2,:person_status,:firstname ,
    :lastname, :adress, :postalcode, :town, :birthday, :description, :custo,
    {:responsible_ids=>[]}, :student_class_school_id)
  end
end

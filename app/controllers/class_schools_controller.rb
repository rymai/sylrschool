class ClassSchoolsController < ApplicationController
  before_action :set_class_school, only: [:show, :edit, :update, :destroy]
  def index
    @grid = ClassSchoolsGrid.new(grid_params) do |scope|
      scope.page(params[:page])
    end
  end

  def grid_params
    params.fetch(:class_schools_grid, {}).permit!
  end

  # GET /class_schools
  # GET /class_schools.json
  #def index
  #  @class_schools = ClassSchool.all
  #end

  # GET /class_schools/1
  # GET /class_schools/1.json
  def show
  end

  # GET /class_schools/new
  def new
    @class_school = ClassSchool.new
  end

  # GET /class_schools/1/edit
  def edit
  end

  # POST /class_schools
  # POST /class_schools.json
  def create
    @class_school = ClassSchool.new(class_school_params)

    respond_to do |format|
      if @class_school.save
        format.html { redirect_to @class_school, notice: 'Class school was successfully created.' }
        format.json { render :show, status: :created, location: @class_school }
      else
        format.html { render :new }
        format.json { render json: @class_school.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /class_schools/1
  # PATCH/PUT /class_schools/1.json
  def update
    respond_to do |format|
      if @class_school.update(class_school_params)
        format.html { redirect_to @class_school, notice: 'Class school was successfully updated.' }
        format.json { render :show, status: :ok, location: @class_school }
      else
        format.html { render :edit }
        format.json { render json: @class_school.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /class_schools/1
  # DELETE /class_schools/1.json
  def destroy
    if @class_school.destroy
      respond_to do |format|
        format.html { redirect_to class_schools_url, notice: 'Class school was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to class_schools_url, notice: 'Class school was not destroyed (references ?).' }
        format.json { head :no_content }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_class_school
    @class_school = ClassSchool.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def class_school_params
    params.require(:class_school).permit(:name, :nb_max_student, :default_location_id, :description, :custo)
  end
end

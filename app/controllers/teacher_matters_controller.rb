class TeacherMattersController < ApplicationController
  before_action :set_teacher_matter, only: [:show, :edit, :update, :destroy]

  # GET /teacher_matters
  # GET /teacher_matters.json
  def index
    @teacher_matters = TeacherMatter.all
  end

  # GET /teacher_matters/1
  # GET /teacher_matters/1.json
  def show
  end

  # GET /teacher_matters/new
  def new
    @teacher_matter = TeacherMatter.new
  end

  # GET /teacher_matters/1/edit
  def edit
  end

  # POST /teacher_matters
  # POST /teacher_matters.json
  def create
    @teacher_matter = TeacherMatter.new(teacher_matter_params)

    respond_to do |format|
      if @teacher_matter.save
        format.html { redirect_to @teacher_matter, notice: 'Teacher matter was successfully created.' }
        format.json { render :show, status: :created, location: @teacher_matter }
      else
        format.html { render :new }
        format.json { render json: @teacher_matter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teacher_matters/1
  # PATCH/PUT /teacher_matters/1.json
  def update
    respond_to do |format|
      if @teacher_matter.update(teacher_matter_params)
        format.html { redirect_to @teacher_matter, notice: 'Teacher matter was successfully updated.' }
        format.json { render :show, status: :ok, location: @teacher_matter }
      else
        format.html { render :edit }
        format.json { render json: @teacher_matter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teacher_matters/1
  # DELETE /teacher_matters/1.json
  def destroy
    @teacher_matter.destroy
    respond_to do |format|
      format.html { redirect_to teacher_matters_url, notice: 'Teacher matter was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_teacher_matter
      @teacher_matter = TeacherMatter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def teacher_matter_params
      params.require(:teacher_matter).permit(:teacher_id, :matter_id, :custo)
    end
end

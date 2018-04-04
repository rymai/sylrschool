class StudentResponsiblesController < ApplicationController
  before_action :set_student_responsible, only: [:show, :edit, :update, :destroy]

  # GET /student_responsibles
  # GET /student_responsibles.json
  def index
    @student_responsibles = StudentResponsible.all
  end

  # GET /student_responsibles/1
  # GET /student_responsibles/1.json
  def show
  end

  # GET /student_responsibles/new
  def new
    @student_responsible = StudentResponsible.new
  end

  # GET /student_responsibles/1/edit
  def edit
  end

  # POST /student_responsibles
  # POST /student_responsibles.json
  def create
    @student_responsible = StudentResponsible.new(student_responsible_params)

    respond_to do |format|
      if @student_responsible.save
        format.html { redirect_to @student_responsible, notice: 'Student responsible was successfully created.' }
        format.json { render :show, status: :created, location: @student_responsible }
      else
        format.html { render :new }
        format.json { render json: @student_responsible.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /student_responsibles/1
  # PATCH/PUT /student_responsibles/1.json
  def update
    respond_to do |format|
      if @student_responsible.update(student_responsible_params)
        format.html { redirect_to @student_responsible, notice: 'Student responsible was successfully updated.' }
        format.json { render :show, status: :ok, location: @student_responsible }
      else
        format.html { render :edit }
        format.json { render json: @student_responsible.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /student_responsibles/1
  # DELETE /student_responsibles/1.json
  def destroy
    @student_responsible.destroy
    respond_to do |format|
      format.html { redirect_to student_responsibles_url, notice: 'Student responsible was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student_responsible
      @student_responsible = StudentResponsible.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_responsible_params
      params.require(:student_responsible).permit(:student_id, :responsible_id, :custo)
    end
end

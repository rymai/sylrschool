class TeachingsController < ApplicationController
  before_action :set_teaching, only: [:show, :edit, :update, :destroy]
  def index
    @grid = TeachingsGrid.new(grid_params) do |scope|
      scope.page(params[:page])
    end
  end

  def grid_params
    params.fetch(:teachings_grid, {}).permit!
  end

  # GET /teachings
  # GET /teachings.json
  #def index
  #  @teachings = Teaching.all
  #end

  # GET /teachings/1
  # GET /teachings/1.json
  def show
    @schedules=@teaching.get_schedules
  end

  # GET /teachings/new
  def new
    @teaching = Teaching.new
  end

  # GET /teachings/1/edit
  def edit
  end

  # POST /teachings
  # POST /teachings.json
  def create
    @teaching = Teaching.new(teaching_params)
    respond_to do |format|
      if @teaching.save
        # creation des schedules correspondants
        if @teaching.create_schedules(teaching_params)
          format.html { redirect_to @teaching, notice: 'Teaching was successfully created.' }
          format.json { render :show, status: :created, location: @teaching }
        else
          @teaching.destroy
          format.html { render :new , notice: 'Teaching was not created.'}
          format.json { render json: @teaching.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :new , notice: 'Teaching was not created.'}
        format.json { render json: @teaching.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teachings/1
  # PATCH/PUT /teachings/1.json
  def update

    respond_to do |format|
      if @teaching.update(teaching_params)
        #si repetition ou repet number change, detruire les scedules et les refaire
        if @teaching.update_schedules(teaching_params)
          format.html { redirect_to @teaching, notice: 'Teaching was successfully updated.' }
          format.json { render :show, status: :ok, location: @teaching }
        else
          format.html { render :edit }
          format.json { render json: @teaching.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :edit }
        format.json { render json: @teaching.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teachings/1
  # DELETE /teachings/1.json
  def destroy
    respond_to do |format|
      if @teaching.destroy
        format.html { redirect_to teachings_url, notice: "Teaching was successfully destroyed: " }
        format.json { head :no_content }
      else
        format.html { redirect_to teachings_url, notice: "Teaching was not destroyed: #{@teaching.errors.full_messages}" }
        format.json { render json: @teaching.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_teaching
    @teaching = Teaching.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def teaching_params
    params.require(:teaching).permit(:name, :teaching_class_school_id, :teaching_teacher_id,
    :teaching_matter_id, :teaching_domain_id, :teaching_location_id, :teaching_start_time, :teaching_duration, :teaching_repetition, :teaching_repetition_number, :description, :custo)
  end
end

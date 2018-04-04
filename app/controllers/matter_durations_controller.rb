class MatterDurationsController < ApplicationController
  before_action :set_matter_duration, only: [:show, :edit, :update, :destroy]
  def index
    @grid = MatterDurationsGrid.new(grid_params) do |scope|
      scope.page(params[:page])
    end
  end

  def grid_params
    params.fetch(:matter_durations_grid, {}).permit!
  end

  # GET /matter_durations
  # GET /matter_durations.json
  #def index
  #  @matter_durations = MatterDuration.all
  #end

  # GET /matter_durations/1
  # GET /matter_durations/1.json
  def show
  end

  # GET /matter_durations/new
  def new
    @matter_duration = MatterDuration.new
  end

  # GET /matter_durations/1/edit
  def edit
  end

  # POST /matter_durations
  # POST /matter_durations.json
  def create
    @matter_duration = MatterDuration.new(matter_duration_params)

    respond_to do |format|
      if @matter_duration.save
        format.html { redirect_to @matter_duration, notice: 'Matter duration was successfully created.' }
        format.json { render :show, status: :created, location: @matter_duration }
      else
        format.html { render :new }
        format.json { render json: @matter_duration.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /matter_durations/1
  # PATCH/PUT /matter_durations/1.json
  def update
    respond_to do |format|
      if @matter_duration.update(matter_duration_params)
        format.html { redirect_to @matter_duration, notice: 'Matter duration was successfully updated.' }
        format.json { render :show, status: :ok, location: @matter_duration }
      else
        format.html { render :edit }
        format.json { render json: @matter_duration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /matter_durations/1
  # DELETE /matter_durations/1.json
  def destroy
    @matter_duration.destroy
    respond_to do |format|
      format.html { redirect_to matter_durations_url, notice: 'Matter duration was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_matter_duration
    @matter_duration = MatterDuration.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def matter_duration_params
    params.require(:matter_duration).permit(:name, :matter_duration_level_id, :value, :description, :custo)
  end
end

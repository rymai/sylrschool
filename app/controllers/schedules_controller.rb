class SchedulesController < ApplicationController
  before_action :set_schedule, only: [:show, :edit, :update, :destroy]
  def index
    @grid = SchedulesGrid.new(grid_params) do |scope|
      scope.page(params[:page])
    end
    # seulement les horaires jour entier (pas référencé par un enseignement)
    @schedules=Schedule.get_only_all_day
  end

  def grid_params
    params.fetch(:schedules_grid, {}).permit!
  end

  # GET /schedules
  # GET /schedules.json
  #def index
  #  @schedules = Schedule.all
  #end

  # GET /schedules/1
  # GET /schedules/1.json
  def show
  end

  # GET /schedules/new
  def new
    @schedule = Schedule.new
  end

  # GET /schedules/1/edit
  def edit
  end

  # POST /schedules
  # POST /schedules.json
  def create
    @schedule = Schedule.new(schedule_params)

    respond_to do |format|
      if @schedule.create_calendar(schedule_params)
        format.html { redirect_to @schedule, notice: 'Schedule was successfully created.' }
        format.json { render :show, status: :created, location: @schedule }
      else
        format.html { render :new }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /schedules/1
  # PATCH/PUT /schedules/1.json
  def update
    respond_to do |format|
      if @schedule.update(schedule_params)
        format.html { redirect_to @schedule, notice: 'Schedule was successfully updated.' }
        format.json { render :show, status: :ok, location: @schedule }
      else
        format.html { render :edit }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schedules/1
  # DELETE /schedules/1.json
  def destroy
    if @schedule.destroy_schedule
      respond_to do |format|
        format.html { redirect_to schedules_url, notice: 'Schedule was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to schedules_url, notice: 'Schedule was not destroyed (references it).' }
        format.json { head :no_content }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_schedule
    @schedule = Schedule.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def schedule_params
    params.require(:schedule).permit(:schedule_type, :start_time, :all_of_day, :duration, 
    :schedule_father_id, :schedule_teaching_id, :custo, :nb_repetition)
  end
end

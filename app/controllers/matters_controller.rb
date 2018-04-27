class MattersController < ApplicationController
  before_action :set_matter, only: [:show, :edit, :update, :destroy]
  def index
    @grid = MattersGrid.new(grid_params) do |scope|
      scope.page(params[:page])
    end
  end

  def grid_params
    params.fetch(:matters_grid, {}).permit!
  end
  # GET /matters
  # GET /matters.json
  #def index
  #    @matters = Matter.all
  #end

  # GET /matters/1
  # GET /matters/1.json
  def show
  end

  # GET /matters/new
  def new
    @matter = Matter.new
  end

  # GET /matters/1/edit
  def edit
  end

  # POST /matters
  # POST /matters.json
  def create
    @matter = Matter.new(matter_params)

    respond_to do |format|
      if @matter.save
        @student.update_custo_in_teacher_matter(matter_params[:teacher_ids])
        format.html { redirect_to @matter, notice: 'Matter was successfully created.' }
        format.json { render :show, status: :created, location: @matter }
      else
        format.html { render :new }
        format.json { render json: @matter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /matters/1
  # PATCH/PUT /matters/1.json
  def update
    respond_to do |format|
      if @matter.update(matter_params)
        @matter.update_custo_in_teacher_matter(matter_params[:teacher_ids])
        format.html { redirect_to @matter, notice: 'Matter was successfully updated.' }
        format.json { render :show, status: :ok, location: @matter }
      else
        format.html { render :edit }
        format.json { render json: @matter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /matters/1
  # DELETE /matters/1.json
  def destroy
    if @matter.destroy
      respond_to do |format|
        format.html { redirect_to matters_url, notice: 'Matter was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to matters_url, notice: 'Matter was not destroyed (references ?).' }
        format.json { head :no_content }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_matter
    @matter = Matter.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def matter_params
    params.require(:matter).permit(:name, :matter_type_id, :matter_duration, :matter_nb_max_student, {:teacher_ids=>[]}, :description, :custo)
  end
end

class SkillsController < ApplicationController

  def index
    @grid = SkillsGrid.new(grid_params) do |scope|
      scope.page(params[:page])
    end
  end

  protected

  def grid_params
    params.fetch(:skills_grid, {}).permit!
  end

end


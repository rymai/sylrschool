class GradeContextsGrid < BaseGrid

  scope do
    GradeContext
  end

  eval=eval(File.read("#{include_grids()}/top_grid.rb"))

  filter(:goal, :string, :header => I18n.t(:label_goal))
  column(:goal, :mandatory => true, :header => I18n.t(:label_goal))

  filter(:min_value, :string, :header => I18n.t(:label_min_value))
  column(:min_value, :mandatory => true, :header => I18n.t(:label_min_value))

  filter(:max_value, :string, :header => I18n.t(:label_max_value))
  column(:max_value, :mandatory => true, :header => I18n.t(:label_max_value))

  eval=eval(File.read("#{include_grids()}/bottom_grid.rb"))

  column(:actions, :html => true, :mandatory => true) do |asset|
    render :partial => "shared/assets_actions", :locals=>{:controller=>:grade_contexts,:object => asset}
  end
end

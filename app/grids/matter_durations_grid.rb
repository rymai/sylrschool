class MatterDurationsGrid < BaseGrid

  scope do
    MatterDuration
  end

  eval=eval(File.read("#{include_grids()}/top_grid.rb"))

  filter(:matter_duration_level, :integer, :header => I18n.t(:label_matter_duration_level))
  #column(:matter_duration_level, :html => true, :mandatory => true, :header => I18n.t(:label_matter_duration_level))do |asset|
  #  link_to asset.matter_duration_level.ident, asset.matter_duration_level
  #end

  filter(:value, :integer, :header => I18n.t(:label_matter_duration_value))
  column(:value, :mandatory => true, :header => I18n.t(:label_matter_duration_value))

  eval=eval(File.read("#{include_grids()}/bottom_grid.rb"))

  column(:actions, :html => true, :mandatory => true) do |asset|
    render :partial => "shared/assets_actions", :locals=>{:controller=>:matter_durations,:object => asset}
  end
end

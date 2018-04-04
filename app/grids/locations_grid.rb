class LocationsGrid < BaseGrid

  scope do
    Location
  end

 eval=eval(File.read("#{include_grids()}/top_grid.rb"))

  filter(:usage, :integer, :header => I18n.t(:label_usage))
  column(:usage, :html => true, :mandatory => true, :header => I18n.t(:label_usage))do |asset|
    link_to asset.usage.ident, asset.usage
  end

  eval=eval(File.read("#{include_grids()}/bottom_grid.rb"))

  column(:actions, :html => true, :mandatory => true) do |asset|
    render :partial => "shared/assets_actions", :locals=>{:controller=>:locations,:object => asset}
  end
end

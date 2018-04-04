class ResponsiblesGrid < BaseGrid

  scope do
    Responsible
  end

  eval=eval(File.read("#{include_grids()}/top_grid.rb"))

  filter(:type, :integer, :header => I18n.t(:label_responsible_type))
  column(:type, :html => true, :mandatory => true, :header => I18n.t(:label_responsible_type))do |asset|
    link_to asset.type.ident, asset.type
  end

  eval=eval(File.read("#{include_grids()}/person_grid.rb"))
  
  eval=eval(File.read("#{include_grids()}/bottom_grid.rb"))

  column(:actions, :html => true, :mandatory => true) do |asset|
    render :partial => "shared/assets_actions", :locals=>{:controller=>:responsibles,:object => asset}
  end
end

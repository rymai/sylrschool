class ClassSchoolsGrid < BaseGrid

  scope do
    ClassSchool
  end
  eval=eval(File.read("#{include_grids()}/top_grid.rb"))

  filter(:nb_max_student, :string, :header => I18n.t(:label_nb_max_student))
  column(:nb_max_student, :mandatory => true, :header => I18n.t(:label_nb_max_student))
  
  filter(:default_location, :integer, :header => I18n.t(:label_default_location))
  column(:default_location, :html => true, :mandatory => true, :header => I18n.t(:label_default_location))do |asset|
    link_to asset.default_location.ident, asset.default_location
  end
 
  eval=eval(File.read("#{include_grids()}/bottom_grid.rb"))

  column(:actions, :html => true, :mandatory => true) do |asset|
    render :partial => "shared/assets_actions", :locals=>{:controller=>:class_schools,:object => asset}
  end
end

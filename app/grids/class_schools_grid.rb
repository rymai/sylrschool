class ClassSchoolsGrid < BaseGrid

  scope do
    ClassSchool
  end
  eval=eval(File.read("#{include_grids()}/top_grid.rb"))

  filter(:nb_max_student, :string, :header => I18n.t(:label_nb_max_student))
  column(:nb_max_student, :mandatory => true, :header => I18n.t(:label_nb_max_student))
 
  eval=eval(File.read("#{include_grids()}/bottom_grid.rb"))

  column(:actions, :html => true, :mandatory => true) do |asset|
    render :partial => "shared/assets_actions", :locals=>{:controller=>:class_schools,:object => asset}
  end
end

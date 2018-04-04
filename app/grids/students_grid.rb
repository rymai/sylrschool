class StudentsGrid < BaseGrid

  scope do
    Student
  end

  eval=eval(File.read("#{include_grids()}/top_grid.rb"))
  eval=eval(File.read("#{include_grids()}/person_grid.rb"))
  filter(:student_class_school, :integer, :header => I18n.t(:label_student_class_school))
  column(:student_class_school, :html => true, :mandatory => true, :header => I18n.t(:label_student_class_school))do |asset|
    unless asset.student_class_school.nil?
      link_to asset.student_class_school.ident, asset.student_class_school
    end
  end
  eval=eval(File.read("#{include_grids()}/bottom_grid.rb"))

  column(:actions, :html => true, :mandatory => true) do |asset|
    render :partial => "shared/assets_actions", :locals=>{:controller=>:students,:object => asset}
  end

end

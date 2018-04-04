class GradesGrid < BaseGrid

  scope do
    Grade
  end

  eval=eval(File.read("#{include_grids()}/topid_grid.rb"))

  #pour definir un lien vers un autre modele
  filter(:grade_student, :integer, :header => I18n.t(:label_grade_student))
  column(:grade_student, :html => true, :mandatory => true, :header => I18n.t(:label_grade_student))do |asset|
    link_to asset.grade_student.ident, asset.grade_student
  end

  filter(:grade_grade_context, :integer, :header => I18n.t(:label_grade_grade_context))
  column(:grade_grade_context, :html => true, :mandatory => true, :header => I18n.t(:label_grade_grade_context))do |asset|
    link_to asset.grade_grade_context.ident, asset.grade_grade_context
  end

  filter(:grade_matter, :integer, :header => I18n.t(:label_grade_matter))
  column(:grade_matter, :html => true, :mandatory => true, :header => I18n.t(:label_grade_matter))do |asset|
    link_to asset.grade_matter.ident, asset.grade_matter
  end
  
  filter(:grade_date, :date, :header => I18n.t(:label_grade_date))
  column(:grade_date, :mandatory => true, :header => I18n.t(:label_grade_date))
  
  filter(:value, :date, :header => I18n.t(:label_grade_value))
  column(:value, :mandatory => true, :header => I18n.t(:label_grade_value))

  eval=eval(File.read("#{include_grids()}/bottom_grid.rb"))

  column(:actions, :html => true, :mandatory => true) do |asset|
    render :partial => "shared/assets_actions", :locals=>{:controller=>:grades,:object => asset}
  end
end

class TeachingsGrid < BaseGrid

  scope do
    Teaching
  end

  eval=eval(File.read("#{include_grids()}/top_grid.rb"))

  #filter(:toto, :string, :header => I18n.t(:label_toto))
  #column(:toto, :mandatory => true, :header => I18n.t(:label_toto))

  #pour definir un lien vers un autre modele
  filter(:teaching_class_school, :integer, :header => I18n.t(:label_teaching_class_school))
  column(:teaching_class_school, :html => true, :mandatory => true, :header => I18n.t(:label_teaching_class_school))do |asset|
    link_to asset.teaching_class_school.ident, asset.teaching_class_school
  end

  filter(:teaching_teacher, :integer, :header => I18n.t(:label_teaching_teacher))
  column(:teaching_class_school, :html => true, :mandatory => true, :header => I18n.t(:label_teaching_teacher))do |asset|
    link_to asset.teaching_teacher.ident, asset.teaching_teacher
  end

  filter(:teaching_matter, :integer, :header => I18n.t(:label_teaching_matter))
  column(:teaching_matter, :html => true, :mandatory => true, :header => I18n.t(:label_teaching_matter))do |asset|
    link_to asset.teaching_matter.ident, asset.teaching_matter
  end

  filter(:teaching_domain, :integer, :header => I18n.t(:label_teaching_domain))
  column(:teaching_domain, :html => true, :mandatory => true, :header => I18n.t(:label_teaching_domain))do |asset|
    unless asset.teaching_domain.nil?
      link_to asset.teaching_domain.ident, asset.teaching_domain
    else
      ""
    end
  end
  filter(:teaching_start_time, :date, :header => I18n.t(:label_teaching_start_time))
  column(:teaching_start_time, :mandatory => true, :header => I18n.t(:label_teaching_start_time))

  filter(:teaching_duration, :integer, :header => I18n.t(:label_teaching_duration))
  column(:teaching_duration, :mandatory => true, :header => I18n.t(:label_teaching_duration))


  #pour definir un select sur un champ
  filter(:teaching_repetition, :enum, :header => I18n.t(:label_teaching_repetition),
        :select => SYLR::C_ALL_TEACHING_REPETITION.map {|r| [r.humanize, r]},
        :include_blank => true)
  column(:teaching_repetition, :mandatory => true, :header => I18n.t(:label_teaching_repetition))

  filter(:teaching_repetition_number, :integer, :header => I18n.t(:label_teaching_repetition_number))
  column(:teaching_repetition_number, :mandatory => true, :header => I18n.t(:label_teaching_repetition_number))

  eval=eval(File.read("#{include_grids()}/bottom_grid.rb"))

  column(:actions, :html => true, :mandatory => true) do |asset|
    render :partial => "shared/assets_actions", :locals=>{:controller=>:teachings,:object => asset}
  end
end

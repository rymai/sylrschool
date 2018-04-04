class PresentsGrid < BaseGrid

  scope do
    Present
  end

  eval=eval(File.read("#{include_grids()}/topid_grid.rb"))

  #pour definir un lien vers un autre modele
  filter(:student, :integer, :header => I18n.t(:label_student))
  column(:student, :html => true, :mandatory => true, :header => I18n.t(:label_student))do |asset|
    link_to asset.student.ident, asset.student
  end

  filter(:schedule, :integer, :header => I18n.t(:label_schedule))
  column(:schedule, :html => true, :mandatory => true, :header => I18n.t(:label_schedule))do |asset|
    link_to asset.schedule.ident, asset.schedule
  end

  filter(:teaching, :integer, :header => I18n.t(:label_teaching))
  column(:teaching, :html => true, :mandatory => true, :header => I18n.t(:label_teaching))do |asset|
    link_to asset.teaching.ident, asset.teaching
  end

  #pour definir un select sur un champ
  filter(:present_type, :enum, :header => I18n.t(:label_present_type),
        :select => SYLR::V_ALL_PRESENT_TYPES.map {|r| [r.humanize, r]},
        :include_blank => true)
  column(:present_type, :mandatory => true, :header => I18n.t(:label_present_type))

  eval=eval(File.read("#{include_grids()}/bottom_grid.rb"))

  column(:actions, :html => true, :mandatory => true) do |asset|
    render :partial => "shared/assets_actions", :locals=>{:controller=>:presents,:object => asset}
  end
end

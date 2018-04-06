class SchedulesGrid < BaseGrid

  scope do
    Schedule.select("*").where("schedule_teaching_id = -1")
  end

  eval=eval(File.read("#{include_grids()}/topid_grid.rb"))

  filter(:schedule_type, :enum, :header => I18n.t(:label_schedule_type),
    :select => SYLR::C_ALL_SCHEDULE_TYPES.map {|r| [r.humanize, r]},
    :include_blank => true)
  column(:schedule_type, :mandatory => true, :header => I18n.t(:label_schedule_type))

  filter(:start_time, :datetime, :header => I18n.t(:label_start_time))
  column(:start_time, :mandatory => true, :header => I18n.t(:label_start_time))

  filter(:schedule_father, :integer, :multiple => ',', :header => I18n.t(:label_schedule_schedule_father))
  column(:schedule_father, :html => true, :mandatory => true, :header => I18n.t(:label_schedule_schedule_father))do |asset|
    unless asset.schedule_father.nil?
      link_to asset.schedule_father.ident, asset.schedule_father
    else
      ""
    end
  end
  if true
    filter(:schedule_teaching, :integer, :multiple => ',', :header => I18n.t(:label_schedule_schedule_teaching))
    column(:schedule_teaching, :html => true, :mandatory => true, :header => I18n.t(:label_schedule_schedule_teaching))do |asset|
      unless asset.schedule_teaching.nil?
        link_to asset.schedule_teaching.ident, asset.schedule_teaching
      else
        ""
      end
    end
  end

  eval=eval(File.read("#{include_grids()}/bottom_grid.rb"))

  column(:actions, :html => true, :mandatory => true) do |asset|
    render :partial => "shared/assets_actions", :locals=>{:controller=>:schedules,:object => asset}
  end
end

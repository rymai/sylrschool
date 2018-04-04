class SchedulesGrid < BaseGrid

  scope do
    Schedule
  end

  eval=eval(File.read("#{include_grids()}/topid_grid.rb"))

  filter(:schedule_type, :enum, :header => I18n.t(:label_schedule_type),
    :select => SYLR::C_ALL_SCHEDULE_TYPES.map {|r| [r.humanize, r]},
    :include_blank => true)
  column(:schedule_type, :mandatory => true, :header => I18n.t(:label_schedule_type))

  filter(:start_time, :datetime, :header => I18n.t(:label_start_time))
  column(:start_time, :mandatory => true, :header => I18n.t(:label_start_time))

  filter(:all_of_day, :boolean, :header => I18n.t(:label_all_of_day))
  column(:all_of_day, :mandatory => true, :header => I18n.t(:label_all_of_day))

  filter(:duration, :string, :multiple => ',', :header => I18n.t(:label_schedule_duration))
  column(:duration, :mandatory => true, :header => I18n.t(:label_schedule_duration))

  filter(:schedule_father, :integer, :multiple => ',', :header => I18n.t(:label_schedule_schedule_father))
  column(:schedule_father, :html => true, :mandatory => true, :header => I18n.t(:label_schedule_schedule_father))do |asset|
    unless asset.schedule_father.nil?
      link_to asset.schedule_father.ident, asset.schedule_father
    else
      ""
    end
  end

  filter(:schedule_teaching, :integer, :multiple => ',', :header => I18n.t(:label_schedule_schedule_teaching))
  column(:schedule_teaching, :html => true, :mandatory => true, :header => I18n.t(:label_schedule_schedule_teaching))do |asset|
    unless asset.schedule_teaching.nil?
      link_to asset.schedule_teaching.ident, asset.schedule_teaching
    else
      ""
    end
  end

  eval=eval(File.read("#{include_grids()}/bottom_grid.rb"))

  column(:actions, :html => true, :mandatory => true) do |asset|
    render :partial => "shared/assets_actions", :locals=>{:controller=>:schedules,:object => asset}
  end
end

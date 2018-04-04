class MattersGrid < BaseGrid

  scope do
    Matter
  end
  eval=eval(File.read("#{include_grids()}/top_grid.rb"))

  filter(:matter_type, :string, :header => I18n.t(:label_matter_type))
  column(:matter_type, :html => true, :mandatory => true, :header => I18n.t(:label_matter_type))do |asset|
    link_to asset.matter_type.name, asset.matter_type
  end

  filter(:matter_duration, :integer, :header => I18n.t( :label_matter_duration))
  column(:matter_duration, :html => true, :mandatory => true, :header => I18n.t(:label_matter_duration))do |asset|
    unless asset.matter_duration_id.nil?
      link_to asset.matter_duration.ident, asset.matter_duration
    else
      ""
    end
  end

  filter(:matter_nb_max_student, :integer, :header => I18n.t( :label_matter_nb_max_student))
  column(:matter_nb_max_student, :html => true, :mandatory => true, :header => I18n.t(:label_matter_nb_max_student))

  eval=eval(File.read("#{include_grids()}/bottom_grid.rb"))

  column(:actions, :html => true, :mandatory => true) do |asset|
    render :partial => "shared/assets_actions", :locals=>{:controller=>:matters,:object => asset}
  end

end

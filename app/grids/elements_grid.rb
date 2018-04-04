class ElementsGrid < BaseGrid

  scope do
    Element
  end

  eval=eval(File.read("#{include_grids()}/top_grid.rb"))

  filter(:for_what, :enum, :header => I18n.t(:label_for_what),
    :select => SYLR::C_ALL_ELEMENT_FOR_WHATS.map {|r| [r.humanize, r]},
    :include_blank => true)
  column(:for_what, :mandatory => true, :header => I18n.t(:label_for_what))

  eval=eval(File.read("#{include_grids()}/bottom_grid.rb"))

  column(:actions, :html => true, :mandatory => true) do |asset|
    render :partial => "shared/assets_actions", :locals=>{:controller=>:elements,:object => asset}
  end
end

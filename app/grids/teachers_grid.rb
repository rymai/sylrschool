class TeachersGrid < BaseGrid

  scope do
    Teacher
  end
  eval=eval(File.read("#{include_grids()}/top_grid.rb"))
  eval=eval(File.read("#{include_grids()}/person_grid.rb"))
  eval=eval(File.read("#{include_grids()}/bottom_grid.rb"))

  column(:actions, :html => true, :mandatory => true) do |asset|
    render :partial => "shared/assets_actions", :locals=>{:controller=>:teachers,:object => asset}
  end
end

class NotebooksGrid < BaseGrid

  scope do
    Notebook
  end

  eval=eval(File.read("#{include_grids()}/top_grid.rb"))

  #column(:notebooktext, :mandatory => true, :header => I18n.t(:label_notebook_text))

  filter(:student, :integer, :header => I18n.t(:label_student))
  column(:student, :html => true, :mandatory => true, :header => I18n.t(:label_notebook_student))do |asset|
    link_to asset.student.ident, asset.student
  end

  eval=eval(File.read("#{include_grids()}/bottom_grid.rb"))

  column(:actions, :html => true, :mandatory => true) do |asset|
    render :partial => "shared/assets_actions", :locals=>{:controller=>:notebooks,:object => asset}
  end
end

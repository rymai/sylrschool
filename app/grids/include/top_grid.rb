filter(:id, :integer, :multiple => ',', :header => I18n.t(:label_filter_id))
#filter(:id, :integer, :range => true)
column(:id, :mandatory => true)

filter(:name, :string, :header => I18n.t(:label_name))
column(:name, :mandatory => true, :header => I18n.t(:label_name))

#filter(:description, :string, :header => I18n.t(:label_description))
column(:description, :mandatory => true, :header => I18n.t(:label_description))

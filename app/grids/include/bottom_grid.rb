filter(:custo, :string, :header => I18n.t(:label_custo))
column(:custo, :mandatory => true, :header => I18n.t(:label_custo))

filter(:updated_at, :date, :range => true)
date_column(:created_at, :mandatory => true, :header => I18n.t(:label_created_at))

filter(:created_at, :date, :range => true)
date_column(:updated_at, :mandatory => true, :header => I18n.t(:label_updated_at))


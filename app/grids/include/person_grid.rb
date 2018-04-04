filter(:email, :string, :multiple => ',', :header => I18n.t(:label_filter_email))
filter(:person_status, :enum, :header => I18n.t(:label_person_status),
    :select => SYLR::C_ALL_PERSON_STATUS.map {|r| [r.humanize, r]},
    :include_blank => true)
#filter(:phone1, :string, :header => I18n.t(:label_phone1))
#filter(:phone2, :string, :header => I18n.t(:label_phone2))
filter(:firstname, :string, :header => I18n.t(:label_firstname))
filter(:lastname, :string, :multiple => ',', :header => I18n.t(:label_filter_lastname))
filter(:postalcode, :string, :multiple => ',', :header => I18n.t(:label_filter_postalcode))
filter(:town, :string, :multiple => ',', :header => I18n.t(:label_filter_town))
filter(:birthday, :date, :header => I18n.t(:label_birthday),:range=>true)

column(:email, :mandatory => true, :header => I18n.t(:label_email))
column(:person_status, :mandatory => true, :header => I18n.t(:label_person_status))
column(:phone1, :mandatory => true, :header => I18n.t(:label_phone1))
column(:phone2, :mandatory => true, :header => I18n.t(:label_phone2))
column(:firstname, :mandatory => true, :header => I18n.t(:label_firstname))
column(:lastname, :mandatory => true, :header => I18n.t(:label_lastname))
column(:postalcode, :mandatory => true, :header => I18n.t(:label_postalcode))
column(:town, :mandatory => true, :header => I18n.t(:label_town))
column(:birthday, :mandatory => true, :header => I18n.t(:label_birthday))


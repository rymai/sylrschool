json.extract! student, :id, :firstname, :lastname, :adress, :postalcode, :town, :birthday, :description, :custo, :created_at, :updated_at
json.url student_url(student, format: :json)

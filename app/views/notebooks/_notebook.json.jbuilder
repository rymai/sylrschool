json.extract! notebook, :id, :name, :notebooktext, :student_id, :description, :custo, :created_at, :updated_at
json.url notebook_url(notebook, format: :json)

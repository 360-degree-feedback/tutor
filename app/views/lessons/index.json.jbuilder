json.array!(@lessons) do |lesson|
  json.extract! lesson, :id, :title, :description, :created_by
  json.url lesson_url(lesson, format: :json)
end

json.extract! submission, :id, :trivia_id, :team_id, :created_at, :updated_at
json.url submission_url(submission, format: :json)

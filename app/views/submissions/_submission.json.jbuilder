# frozen_string_literal: true

json.extract! submission, :id, :trivium_id, :team_id, :created_at, :updated_at
json.url submission_url(submission, format: :json)

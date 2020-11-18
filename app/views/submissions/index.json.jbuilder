# frozen_string_literal: true

json.array! @submissions, partial: 'submissions/submission', as: :submission

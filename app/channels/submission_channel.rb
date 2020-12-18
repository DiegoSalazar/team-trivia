class SubmissionChannel < ApplicationCable::Channel
  def subscribed
    stream_from "submission"
  end
end

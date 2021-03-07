# frozen_string_literal: true

require 'rails_helper'

describe TriviumSubmitter, type: :model do
  let(:trivium) { create :trivium, :populated }
  let(:team) { create :team }

  describe '.ensure_submissions' do
    context 'no submissions yet' do
      it 'creates submissions for every Team' do
        expect { described_class.ensure_submissions! trivium }
          .to change { Submission.count }.by 2
      end
    end

    context 'submissions exist' do
      before { create :submission, trivium: trivium, team: team }

      it 'does not create submissions' do
        expect { described_class.ensure_submissions! trivium }
          .to change { Submission.count }.by 0
      end
    end
  end
end

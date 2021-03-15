# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
describe Trivium, type: :model do
  subject { described_class.new attributes }
  let(:attributes) { {} }

  describe '.active' do
    let(:active) { described_class.active }

    context 'no trivia exist coming up this quarter' do
      it 'is nil' do
        expect(active).to be nil
      end
    end

    context 'active trivia' do
      subject { described_class.active }
      let!(:active) { create :trivium, game_starts_at: Time.now }
      let!(:far_future) { create :trivium, :far_future }
      let!(:expired) { create :trivium, :expired }

      it 'is a trivium instance' do
        expect(subject).to eq active
      end

      it 'is has a start time in the future' do
        expect(subject.game_starts_at).to be > 1.second.ago
      end
    end
  end

  describe 'validations' do
    before { subject.valid? }

    describe "invalid" do
      it 'title' do
        expect(subject.errors[:title]).to eq ["can't be blank"]
      end

      it 'body' do
        expect(subject.errors[:body]).to eq ["should include a hint"]
      end

      it 'start date' do
        expect(subject.errors[:game_starts_at]).to eq ['is invalid']
      end

      it 'end date' do
        expect(subject.errors[:game_ends_at]).to eq ['is invalid']
      end
    end

    describe 'valid' do
      let(:attributes) do
        { title: 'test', body: 'testing', game_starts_at: Time.new, game_ends_at: Time.new }
      end

      it 'validates start date' do
        expect(subject.errors[:game_starts_at]).to be_empty
      end

      it 'validates end date' do
        expect(subject.errors[:game_ends_at]).to be_empty
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength

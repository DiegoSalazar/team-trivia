require 'rails_helper'

describe Trivium, type: :model do
  subject { described_class.new attributes }
  let(:attributes) { {} }

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

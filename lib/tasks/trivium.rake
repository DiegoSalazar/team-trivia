# frozen_string_literal: true

namespace :trivium do
  desc 'Delete and everything and re-seed'
  task reseed: :environment do
    # Force models to load
    Dir[Rails.root.join('app/models/**/*.rb')].map { |f| require f }

    ActiveRecord::Base.transaction do
      ActiveRecord::Base.descendants.each do |model_class|
        model_class.delete_all
        puts "Deleted #{model_class.name}"
      rescue ActiveRecord::StatementInvalid => e
        # ignore
      end
    end

    puts nil, 'Seeding...'
    Rake::Task['db:seed'].invoke
  end

  desc 'reset game start time of first trivium'
  task reset: :environment do
    Trivium.transaction do
      Trivium.find_each.with_index do |trivium, i|
        next if i < 2 # leave some in the past

        reset_trivium trivium, i
      end
    end
  end

  def reset_trivium(trivium, i)
    starts_at = 40.seconds.from_now
    starts_at = ENV['s'].to_i.seconds.from_now if ENV['s'].present?
    starts_at += i.minutes
    ends_at = starts_at + (ENV['e'] || 80).to_i.seconds

    puts "#{i} Resetting Trivium #{trivium.id} to start at #{starts_at}"

    trivium.game_starts_at = starts_at
    trivium.game_ends_at = ends_at
    trivium.save!
    trivium.questions.each { |q| q.update! revealed: 0, active: false }
  end
end

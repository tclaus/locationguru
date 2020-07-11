# frozen_string_literal: true

namespace :locationguru do
  desc 'Create review tokens in reservations for existing reviews'
  task create_review_tokens: :environment do
    no_tokens = Reservation.where(review_token: nil)
    no_tokens.each do |reservation|
      if reservation.review_token.nil?
        reservation.generate_unique_secure_token
        reservation.save
      end
    end
    puts "Created #{no_tokens.count} tokens for review"
  end
end

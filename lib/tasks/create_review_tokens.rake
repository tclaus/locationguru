namespace :locationguru do
  desc "Create review tokens in reservations for existing reviews"
  task create_review_tokens: :environment do
    no_token =  Reservation.where(review_token: nil)
    no_token.each do |reservation|
      if reservation.review_token == nil
        reservation.generate_unique_secure_token
        reservation.save
      end
    end
  end
end

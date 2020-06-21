namespace :locationguru do
  desc "Delete user accounts without any signup"
  task delete_invalid_accounts: :environment do
    now = Date.today
    time_ago = (now - 3)

    ActiveRecord::Base.transaction do
      invalid_users = User.where('sign_in_count = 0 and created_at < ?', time_ago)
      puts("Delete #{invalid_users.count} invalid user accounts")
      invalid_users.delete_all
    end

    # Delete EN 'friends' without locations
    ActiveRecord::Base.transaction do
      invalid_users = User.where("sign_in_count = 1 and created_at < ? and language_id != 'de'", time_ago)

      invalid_users.each do |user|
        if user.locations.count == 0
          puts "Will delete non de user account: " + user.email
          user.delete
        end
      end
    end
  end
end

namespace :locationguru do
  desc 'Set accounts to user'
  task set_accounts_to_user: :environment do
    unknown_users = User.where(role: nil).all
    unknown_users.each do |user|
      user.role = User::USER_ROLE
      user.save(touch: false)
    end
  end
end

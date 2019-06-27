class AddFirstNameLastNameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string

    User.find_each do |user|
      user.first_name = user.fullname
      user.save!
    end
  end
end

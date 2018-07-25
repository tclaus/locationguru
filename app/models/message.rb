class Message < ApplicationRecord
  belongs_to :user
  belongs_to :location

  validates :email, presence: true,
                    length: { minimum: 5,
                              maximum: 50 }

  validates :name, presence: true,
                   length: { maximum: 50 }

  validates :message, presence: true,
                      length: { maximum: 2000 }

                      
end

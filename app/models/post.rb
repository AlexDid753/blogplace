class Post < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :title, presence: true, length: { minimum: 50 }
  validates :text, presence: true
  validates :ip_address, presence: true
  validates :rating, inclusion: { in: (1..5),
               message: "%{value} is not a valid rating" }
end

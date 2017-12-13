class Post < ActiveRecord::Base
  belongs_to :user
  has_many :ratings, dependent: :destroy
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 50,  minimum: 3  }
  validates :text, presence: true, length: { maximum: 350, minimum: 3  }
  validates :ip_address, presence: true
  validates :rating, inclusion: { in: (1..5),
               message: "%{value} is not a valid rating. The rating must be between 1 and 5" }, allow_nil: true
end

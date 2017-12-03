class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  validates :login, presence: true, length: { maximum: 5 }
end

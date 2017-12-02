class User < ActiveRecord::Base
  validates :login, presence: true, length: { maximum: 5 }
end

class Rating < ActiveRecord::Base
  belongs_to :post
  validates :post_id, presence: true
  validates :rating_value, presence: true, inclusion: { :in => 1..5, :message => "The rating must be between 1 and 5" }
end

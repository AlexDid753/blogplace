class Rating < ActiveRecord::Base
  validates :post_id, presence: true
  validates :rating_value, presence: true, inclusion: { :in => 1..10, :message => "The rating must be between 1 and 10" }
end

require 'rails_helper'

RSpec.describe Rating, type: :model do
  let(:rating) { FactoryBot.build :rating }
  subject { rating }

  it {should validate_presence_of :post_id}
  it {should validate_presence_of :rating_value}
  it { should belong_to :post }
end

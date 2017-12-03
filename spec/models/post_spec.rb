require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) {FactoryBot.build :post}
  subject {post}

  it {should validate_presence_of :title}
  it {should validate_presence_of :text}
  it {should validate_presence_of :ip_address}
  it {should validate_presence_of :user_id}

end

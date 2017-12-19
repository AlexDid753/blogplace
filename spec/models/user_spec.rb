require 'rails_helper'
require 'spec_helper'

describe User do
  before { @user = FactoryBot.build(:user) }

  subject { @user }

  it { should respond_to(:login) }
  it { should be_valid }


  describe "#posts association" do

    before do
      @user.save
      3.times { FactoryBot.create :post, user: @user }
    end
  end
end
require 'spec_helper'

describe Api::V1::UsersController do
  before(:each) {
    request.headers['Accept'] = "application/vnd.blogplace.v1, #{Mime::JSON}"
    request.headers['Content-Type'] = Mime::JSON.to_s
  }

  describe "GET #show" do
    before(:each) do
      @user = FactoryBot.create :user
      get :show, id: @user.id, format: :json
    end

    it "returns the information about a user's login" do
      user_response = JSON.parse(response.body, symbolize_names: true)
      expect(user_response[:login]).to eql @user.login
    end

    it {should respond_with 200}
  end
end
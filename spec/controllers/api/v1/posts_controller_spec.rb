require 'rails_helper'
require 'spec_helper'

describe Api::V1::PostsController do
  describe "GET #show" do
    before(:each) do
      @post = FactoryBot.create :post
      get :show, id: @post.id
    end

    it "returns the information about a post title" do
      post_response = json_response
      expect(post_response[:title]).to eql @post.title
    end

    it { should respond_with 200 }
  end
end

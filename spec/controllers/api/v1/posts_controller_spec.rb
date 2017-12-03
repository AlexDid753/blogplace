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

  describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        user = FactoryBot.create :user
        @post_attributes = FactoryBot.attributes_for :post
        post :create, { user_id: user.id, post: @post_attributes }
      end

      it "renders the json representation for the post record just created" do
        post_response = json_response
        expect(post_response[:title]).to eql @post_attributes[:title]
      end

      it { should respond_with 200 }
    end

    context "when is not created" do
      before(:each) do
        user = FactoryBot.create :user
        @invalid_post_attributes = { title: "S" }
        post :create, { user_id: user.id, post: @invalid_post_attributes }
      end

      it "renders an errors json" do
        post_response = json_response
        expect(post_response).to have_key(:errors)
      end

      it { should respond_with 422 }
    end
  end
end

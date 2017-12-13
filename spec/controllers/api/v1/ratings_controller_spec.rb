require 'rails_helper'
require 'spec_helper'

describe Api::V1::RatingsController do
  before(:each) {
    request.headers['Accept'] = "application/vnd.blogplace.v1, #{Mime::JSON}"
    request.headers['Content-Type'] = Mime::JSON.to_s
  }
  # describe "GET #show" do
  #   before(:each) do
  #     @rating = FactoryBot.create :rating
  #     get :show, id: @rating.id
  #   end
  #
  #   it "returns the information about a rating title" do
  #     rating_response = json_response
  #     expect(rating_response[:title]).to eql @rating.title
  #   end
  #
  #   it { should respond_with 200 }
  # end

  describe "rating #create" do
    context "when is successfully created" do
      before(:each) do
        @rating = FactoryBot.create :rating
        post :create, { post_id: @rating.post_id, rating_value: @rating.rating_value }
      end

      it "renders the json representation for the rating record just created" do
        rating_response = json_response
        expect(rating_response[:post_id]).to eql @rating[:post_id]
        expect(rating_response[:rating_value]).to eql @rating[:rating_value]
      end

      it { should respond_with 200 }
    end

    context "when is not created" do
      before(:each) do
        @invalid_rating_attributes = { rating_value: "5555" }
        post :create, { post_id: '100', rating_value: @invalid_rating_attributes }
      end

      it { should respond_with 422 }
    end
  end
end

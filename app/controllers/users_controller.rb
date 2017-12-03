module Api
  module V1
    class UsersController < ApplicationController

      respond_to :json

      def index
        respond_with User.all
      end

      def show
        respond_with User.find(params[:id])
      end

      def create
        user = User.new(user_params)
        if user.save
          render json: user, status: 201, location: [:api, user]
        else
          render json: {errors: user.errors}, status: 422
        end
      end
    end

  end
end


class Api::V1::CurrentUserController < ApplicationController
  before_action :authenticate_api_v1_user!

  def show
    render json: {
      data: current_api_v1_user
    }, status: :ok
  end
end

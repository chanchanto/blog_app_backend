class CurrentUserController < ApplicationController
  before_action :authenticate_user!

  def show
    render json: {
      data: current_user
    }, status: :ok
  end
end

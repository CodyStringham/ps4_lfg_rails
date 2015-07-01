class Api::V1::GamesController < Api::V1::BaseController
  respond_to :json

  skip_before_action :authenticate_user!
  before_action :set_game

  def show
    @events = @game.events
  end

  private

  def set_game
    begin
    @game = Game.friendly.find(params[:id])
    rescue ActiveRecord::RecordNotFound
    redirect_to "/404"
    end
  end

end

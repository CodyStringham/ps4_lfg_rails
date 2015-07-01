class Api::V1::EventsController < Api::V1::BaseController
  respond_to :json

  skip_before_action :authenticate_user!
  before_action :set_event

  def show
    @posts = @event.posts.order("created_at DESC")
  end

  private

  def set_event
    begin
    @event = Event.friendly.find(params[:id])
    rescue ActiveRecord::RecordNotFound
    redirect_to "/404"
    end
  end

end

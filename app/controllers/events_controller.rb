class EventsController < ApplicationController

  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :set_game, only: [:index, :new, :create]

  def default_url_options
    if session[:show_navigation] == 'false'
      {:host => "hybrid", protocol: 'link'}
    else
      {}
    end
  end

  def index
    @events = @game.events.all
  end

  def show
    expires_in 1.minute, public: true # sets an cache expiration in header for ios app
    @posts = @event.posts.order("created_at DESC")
  end

  def new
    @event = @game.events.new()
  end

  def edit
  end

  def create
    @event = @game.events.new(event_params)
    if @event.save
      redirect_to game_events_path(@event.game), notice: 'Event was successfully created.'
    else
      render :new
    end
  end

  def update
    if @event.update(event_params)
      redirect_to game_events_path(@event.game), notice: 'Event was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to game_events_path(@event.game), notice: 'Event was successfully destroyed.'
  end

  private

  def set_event
    begin
    @event = Event.friendly.find(params[:id])
    rescue ActiveRecord::RecordNotFound
    redirect_to "/404"
    end
  end

  def set_game
    @game = Game.friendly.find(params[:game_id])
  end

  def event_params
    params.require(:event).permit(:name, :group_size, :game_id)
  end

end

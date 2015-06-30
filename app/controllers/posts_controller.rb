class PostsController < ApplicationController

  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :set_event, only: [:index, :new, :create]
  before_action :ensure_owner, only: [:edit, :update, :delete]

  def default_url_options
    if session[:show_navigation] == 'false'
      {:host => "hybrid", protocol: 'link'}
    else
      {}
    end
  end

  def index
    @posts = @event.posts.all
  end

  def show
    expires_in 1.minute, public: true # sets an cache expiration in header for ios app
  end

  def new
    @post = @event.posts.new()
  end

  def edit
  end

  def create
    @post = @event.posts.new(post_params)
    if @post.save
      redirect_to direct_game_event_url(@post.game, @post.event), notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to direct_game_event_path(@post.game, @post.event), notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to direct_game_event_path(@post.game, @post.event), notice: 'Post was successfully destroyed.'
  end

  private
    def set_post
      begin
      @post = Post.find(params[:id])
      rescue ActiveRecord::RecordNotFound
      redirect_to "/404"
      end
    end

    def set_event
      @event = Event.friendly.find(params[:event_id])
    end

    def ensure_owner
      unless @post.user == current_user || current_user.admin
        redirect_to direct_game_event_path(@post.game, @post.event), alert: 'You don\'t have permission to do that.'
      end
    end

    def post_params
      params.require(:post).permit(:title, :checkpoint, :user_id, :event_id)
    end
end

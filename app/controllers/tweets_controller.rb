class TweetsController < ApplicationController
  before_action :authenticate_user, only: [:create]

  def create
    @tweet = current_user.tweets.new(tweet_params)
    if @tweet.save
      render json: @tweet, status: :created
    else
      render json: @tweet.errors, status: :unprocessable_entity
    end
  end

  def index
    @tweets = Tweet.all
    respond_to do |format|
      format.html { render :index } # Add this line to render HTML format
      format.json { render json: @tweets }
    end
  end

  def destroy
    # Find the tweet by id
    @tweet = Tweet.find(params[:id])

    if @tweet.destroy
      head :no_content
    else
      render json: { error: 'Failed to delete tweet' }, status: :unprocessable_entity
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:message)
  end

  def authenticate_user
    unless current_user
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end

class TweetsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  #skip_before_action :authenticate_user!, except: [:index]
  def index
    @tweets = Tweet.all.order(created_at: :desc)
  end

  def new
    #@user = User.find(params[:user_id])
    @tweet = Tweet.new

    #raise params.inspect
  end

  def create
    current_user
    tweet = Tweet.new(tweet_params)
    #tweet.user_id = current_user.id
    tweet.user = current_user
    if tweet.save
      redirect_to tweets_path
    else
      message =  {error: tweet.errors.full_messages.to_sentence}
      redirect_to new_tweet_path, flash: message
    end
  end

  private
  def tweet_params
    params.require(:tweet).permit(:body, :user_id)
  end
end

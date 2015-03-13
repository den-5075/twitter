get '/' do

erb :index

end

post '/show' do
  # he typed a name
  # i want to create or find from my twitterusers table the user with name params[:username]
  @twitter_user = Twitteruser.find_or_create_by(username: params[:username])
# and then i check whether this user has tweets?
  if @twitter_user.tweets.empty?
    # if dun hav i get it from twitter
    @tweets = $client.user_timeline(params[:username]).take(10)
    @tweets.each do |x|
      x = Tweet.create(tweet_text: x.text)
    end

  else
    # load from tweet table if exists
    @tweets = @twitter_user.tweets
  end
  # then i display the tweets in the show page

   erb :show
  end

  get '/:username' do
  @user = TwitterUser.find_by_username(params[:username])
  if @user.tweets_stale?
    # User#fetch_tweets! should make an API call
    # and populate the tweets table
    #
    # Future requests should read from the tweets table
    # instead of making an API call
    @user.fetch_tweets!
  end

  @tweets = @user.tweets
  erb :show
end

# get '/show/#{params[:username]}' do
#  @user = TwitterUser.find_by_username(params[:username])
#   # if @user.tweets.empty?
#   #   # User#fetch_tweets! should make an API call
#   #   # and populate the tweets table
#   #   #
#   #   # Future requests should read from the tweets table
#   #   # instead of making an API call
#   #   @user.fetch_tweets!
#   # end

#   @tweets = @user.tweets.limit(10)
# end
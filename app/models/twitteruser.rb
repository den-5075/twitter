class Twitteruser < ActiveRecord::Base
  # Remember to create a migration!
  has_many :tweets

  def fetch_tweets!
    $client.user_timeline(self.username, {count: 10}).each do |t|
      self.tweets.create(text: t.text)
    end
  end

  def tweets_stale?
    self.tweets.empty? || (Time.now - self.tweets.last.created_at) / 60 > 1 ? true : false
  end
end

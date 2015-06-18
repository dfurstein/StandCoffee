desc 'Import articles from twitter into database'

namespace :import do
  task articles: :environment do

    twitter = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end

    current_articles = Article.pluck(:twitter_id)
    twitter_articles = Array.new

    twitter.user_timeline.each do |tweet|
      twitter_id = tweet.id
      twitter_articles.push(twitter_id)

      # Do not continue if the article already exists
      next if current_articles.include? twitter_id

      # Do not continue if the tweet does not include three parts
      # <title>|<iso date>|<url>
      text = tweet.text.split('|')
      next if text.length != 3

      site = text[0]
      published_at = Date.parse(text[1])
      short_url = text[2]

      thumbnail = LinkThumbnailer.generate(short_url)

      article_url = thumbnail.url.to_s
      title = thumbnail.title
      photo_url = thumbnail.images.first.src.to_s
      description = thumbnail.description

      Article.add_article(twitter_id, site, article_url, title, photo_url, description, published_at)
    end

    # Articles that are no longer on the twitter feed
    (current_articles - twitter_articles).each do |id|
      Article.deactivate(id)
    end

    # Articles that are no longer on the twitter feed
    (twitter_articles - current_articles).each do |id|
      Article.activate(id)
    end
  end
end

class Article < ActiveRecord::Base
  attr_accessible :twitter_id, :site, :url, :title, :photo_url, :description,
                  :published_at, :is_active

  def self.add_article(twitter_id, site, url, title, photo_url, description, published_at)
    article = Article.new

    article.twitter_id = twitter_id
    article.site = site
    article.url = url
    article.title = title
    article.photo_url = photo_url
    article.description = description
    article.published_at = published_at

    article.save
  end

  def self.activate(twitter_id)
    article = find(twitter_id)
    article.is_active = true
    article.save
  rescue ActiveRecord::RecordNotFound
    puts "Cannot find id=#{twitter_id}"
  end

  def self.deactivate(twitter_id)
    article = find(twitter_id)
    article.is_active = false
    article.save
  rescue ActiveRecord::RecordNotFound
    puts "Cannot find id=#{twitter_id}"
  end
end

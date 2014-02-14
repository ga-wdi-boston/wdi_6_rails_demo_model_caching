class Article < ActiveRecord::Base
  has_many :comments

  # This callback will be fired when an article is
  # updated or deleted.
  after_commit :flush_cache

  def flush_cache
    # delete the cache entry that holds all articles
    # added by self.cached_all
    Rails.cache.delete([self.class.name, 'cached_all'])
  end

  def self.cached_all
    Rails.cache.fetch([name, 'cached_all']){ all }
  end

  def cached_comments
    Rails.cache.fetch([self, 'cached_comments']) { comments.includes(:user) }
  end

  def cached_comments_count
    # Create a key from the self.cache_key and the string
    # 'comments_count'
    # EX:
    # ["articles/10-20140214024749529002000", 'comments_count']
    # "articles/10-20140214024749529002000comments_count"
    Rails.cache.fetch([self, 'comments_count']) { comments.size }
  end
end

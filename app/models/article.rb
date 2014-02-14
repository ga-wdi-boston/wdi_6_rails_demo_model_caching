class Article < ActiveRecord::Base
  has_many :comments

  def cached_comments_count
    # Create a key from the self.cache_key and the string
    # 'comments_count'
    # EX:
    # ["articles/10-20140214024749529002000", 'comments_count']
    # "articles/10-20140214024749529002000comments_count"
    Rails.cache.fetch([self, 'comments_count']) { comments.size }
  end
end

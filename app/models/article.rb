class Article < ActiveRecord::Base
  has_many :comments

  # Article.all
  def self.cached_all 
    Rails.cache.fetch([name, 'all_of_em']){ all}
  end

  def cached_comments_count
    Rails.cache.fetch([self, 'comment_count']){ comments.size}
  end

  def cached_comments
    Rails.cache.fetch([self, 'cached_comments']){ comments.includes(:user)}
  end
end

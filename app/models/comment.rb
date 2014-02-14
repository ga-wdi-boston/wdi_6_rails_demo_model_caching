class Comment < ActiveRecord::Base
  belongs_to :article, touch: true
  belongs_to :user
end

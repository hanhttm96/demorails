class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :micropost
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :cmcontent, presence: true, length: { maximum: 140 }
end

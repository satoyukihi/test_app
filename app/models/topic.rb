class Topic < ApplicationRecord
  belongs_to :user
  has_many   :comments
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 30 },
                    uniqueness: true
end

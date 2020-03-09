class Tag < ApplicationRecord
  has_many   :tag_relationships, dependent: :destroy
  has_many   :topics, through: :tag_relationships
end

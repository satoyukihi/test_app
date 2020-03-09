class Topic < ApplicationRecord
  belongs_to :user
  has_many   :comments
  has_many   :tag_relationships, dependent: :destroy
  has_many   :tags, through: :tag_relationships
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 30 },
                    uniqueness: true
                    
  def save_tags(savetopic_tags)
  current_tags = self.tags.pluck(:name) unless self.tags.nil?
  old_tags = current_tags - savetopic_tags
  new_tags = savetopic_tags - current_tags

    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name:old_name)
    end

    new_tags.each do |new_name|
      topic_tag = Tag.find_or_create_by(name:new_name)
      self.tags << topic_tag
    end
  end






end

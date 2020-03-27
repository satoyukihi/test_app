class Topic < ApplicationRecord
  belongs_to :user
  has_many   :comments, dependent: :destroy
  has_many   :tag_relationships, dependent: :destroy
  has_many   :tags, through: :tag_relationships
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 30 },
                    uniqueness: true

  def save_tags(savetopic_tags)
    
   

    savetopic_tags.each do |new_name|
      topic_tag = Tag.find_or_create_by(name: new_name)
      if topic_tag.valid?
        tags << topic_tag
      else
        return false
      end
    end
  end

  def self.search(search)
    Topic.includes(:comments).where(['comments.content LIKE ? OR topics.title LIKE ?',
                                     "%#{search}%", "%#{search}%"]).references(:comments)
  end
end

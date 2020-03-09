require 'rails_helper'

RSpec.describe TagRelationship, type: :model do
  let(:topic) { FactoryBot.create(:topic) }
  let(:tag_relationship) { FactoryBot.create(:tag_relationship) }
  context 'カラムのバリテーション' do
    before do
      tag_relationship
    end

    it 'topic_id、tag_idがあれば有効であること' do
      tag_relationship.valid?
      expect(tag_relationship).to be_valid
    end

    it 'topic_idがない場合無効な状態であること' do
      tag_relationship.update(topic_id: nil)
      tag_relationship.valid?
      expect(tag_relationship.errors[:topic]).to include('を入力してください')
    end

    # it 'topic_idとtag_idがユニークでないと無効な状態であること' do
    # other_tag_relationship= FactoryBot.build(:tag_relationship,
    # topic_id: tag_relationship.topic_id,
    # tag_id: tag_relationship.tag_id)
    # other_tag_relationship.valid?
    # expect(other_tag_relationship.errors[:topic_id]).to include('はすでに存在します')
    # end

    it 'tag_idがない場合無効な状態であること' do
      tag_relationship.update(tag_id: nil)
      tag_relationship.valid?
      expect(tag_relationship.errors[:tag]).to include('を入力してください')
    end
  end
end

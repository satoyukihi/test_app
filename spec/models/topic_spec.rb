require 'rails_helper'

RSpec.describe Topic, type: :model do
  let(:topic) {FactoryBot.create(:topic)}
  let(:other_topic) {FactoryBot.create(:topic)}
  context "カラムのバリテーション" do
    it "title、user_idがあれば有効であること" do
      topic
      topic.valid?
      expect(topic).to be_valid
    end
    
    it "titleがない場合無効な状態であること" do
      topic =Topic.new(title: nil)
      topic.valid?
      expect(topic.errors[:title]).to include('を入力してください')
    end
    
    it "titleが重複している場合無効な状態であること" do
      topic
      other_topic = Topic.new(title: topic.title)
      other_topic.valid?
      expect(other_topic.errors[:title]).to include('はすでに存在します')
    end
    
    it "titleが31文字以上の場合無効な状態であること" do
      topic =Topic.new(title: "a" * 31)
      topic.valid?
      expect(topic.errors[:title]).to include('は30文字以内で入力してください')
    end
    
    it "user_idがない場合無効な状態であること" do
      topic = Topic.new(user_id: nil)
      topic.valid?
      expect(topic.errors[:user_id]).to include('を入力してください')
    end
  end
end

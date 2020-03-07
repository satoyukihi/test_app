require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { FactoryBot.create(:comment) }
  context 'カラムのバリテーション' do
    it 'content、user_id、topic_idがあれば有効であること' do
      comment
      comment.valid?
      expect(comment).to be_valid
    end

    it 'commentがない場合無効な状態であること' do
      comment = Comment.new(content: nil)
      comment.valid?
      expect(comment.errors[:content]).to include('を入力してください')
    end

    it 'contentが1001文字以上の場合無効な状態であること' do
      comment = Comment.new(content: 'a' * 1001)
      comment.valid?
      expect(comment.errors[:content]).to include('は1000文字以内で入力してください')
    end
  end
end
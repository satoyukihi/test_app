require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }

  context 'カラムのバリテーション' do
    it 'name、email、passwordがあれば有効な状態であること' do
      expect(user).to be_valid
    end

    it 'nameがなければ無効な状態であること' do
      user = User.new(name: nil)
      user.valid?
      expect(user.errors[:name]).to include('を入力してください')
    end

    it 'nameが重複している場合無効な状態であること' do
      user
      other_user = User.new(name: user.name)
      other_user.valid?
      expect(other_user.errors[:name]).to include('はすでに存在します')
    end

    it 'nameが16文字以上あれば無効な状態であること' do
      user = User.new(name: 'a' * 16)
      user.valid?
      expect(user.errors[:name]).to include('は15文字以内で入力してください')
    end

    it 'emailがなければ無効な状態であること' do
      user = User.new(email: nil)
      user.valid?
      expect(user.errors[:email]).to include('を入力してください')
    end

    it 'emailが重複している場合なは無効な状態であること' do
      user
      other_user = User.create(email: user.email)
      other_user.valid?
      expect(other_user.errors[:email]).to include('はすでに存在します')
    end

    it 'emailが256文字以上あれば無効な状態であること' do
      user = User.new(email: "#{'a' * 245}@foobar.com")
      user.valid?
      expect(user.errors[:email]).to include('は255文字以内で入力してください')
    end

    it 'emailのフォーマットが合わなければ無効な状態であること' do
      user = User.new(email: 'foo')
      user.valid?
      expect(user.errors[:email]).to include('は不正な値です')
    end

    it 'email大文字、小文字の区別をしないこと' do
      user
      other_user = User.new(email: user.email.upcase)
      other_user.valid?
      expect(other_user.errors[:email]).to include('はすでに存在します')
    end

    it 'passwordがなければ無効な状態であること' do
      user = User.new(password: nil, password_confirmation: nil)
      user.valid?
      expect(user.errors[:password]).to include('を入力してください')
    end

    it 'passwordが5文字以下なら無効な状態であること' do
      user = User.new(password: 'a' * 5, password_confirmation: 'a' * 5)
      user.valid?
      expect(user.errors[:password]).to include('は6文字以上で入力してください')
    end

    it 'passwordとpassword_confirmationが一致しないなら無効な状態であること' do
      user = User.new(password: 'foobar', password_confirmation: 'foobarrrr')
      user.valid?
      expect(user.errors[:password_confirmation]).to include('とパスワードの入力が一致しません')
    end
  end
end

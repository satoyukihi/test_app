require 'rails_helper'

RSpec.describe 'Comments', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
  let(:topic) { FactoryBot.create(:topic) }
  let(:other_topic) { FactoryBot.create(:topic) }
  let(:comment) { FactoryBot.create(:comment) }

  context 'コメント作成' do
    before do
      topic
    end

    it 'ゲストユーザーはコメントできないこと' do
      visit "/topics/#{topic.id}"
      expect do
        fill_in 'comment[content]', with: 'なんでも'
        click_button 'コメントする'
        expect(page).to have_content 'ログインしてください'
        expect(current_path).to eq login_path
      end.to_not change(Comment, :count)
    end

    it '無効な値でコメントできないこと' do
      sign_in_as user
      expect do
        visit "/topics/#{topic.id}"
        fill_in 'comment[content]', with: ''
        click_button 'コメントする'
      end.to_not change(Comment, :count)
    end

    it 'ログインしているユーザーはコメントできること' do
      sign_in_as user
      visit "/topics/#{topic.id}"
      expect do
        fill_in 'comment[content]', with: 'なんでも'
        click_button 'コメントする'
        expect(page).to have_content 'コメントしました'
      end.to change(Comment, :count).by(1)
    end

    it 'コメントが他のページで表示されていないこと' do
      other_topic
      sign_in_as user
      visit "/topics/#{topic.id}"
      fill_in 'comment[content]', with: '他のページで表示されない'
      click_button 'コメントする'

      visit "/topics/#{other_topic.id}"
      expect(page).to_not have_content '他のページで表示されない'
    end
  end

  context 'コメントの削除' do
    before do
      comment
      visit "/topics/#{comment.topic.id}"
    end

    it 'ゲストユーザーはコメントを削除できないこと' do
      # expect(page).to have_content '1件のスレッドが表示されています'
      expect(page).to_not have_content '削除'
    end

    it '自分のコメント以外は削除できないこと' do
      sign_in_as other_user
      # expect(page).to have_content '1件の投稿が表示されています'
      expect(page).to_not have_content '削除'
    end

    # it '有効なユーザーはコメントを削除できること' do
    # sign_in_as comment.user
    # expect do
    # click_link 'commentdelete'
    # end.to change(Topic, :count).by(-1)
    # end
  end

  it 'ユーザーを削除すると関連するコメントも削除される'
  it 'スレッドを消すと関連するコメントも削除される'
end

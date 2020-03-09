require 'rails_helper'

RSpec.describe 'Topics', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
  let(:topic) { FactoryBot.create(:topic) }
  let(:other_topic) { FactoryBot.create(:topic) }

  describe 'topページ' do
    context 'Topicの作成' do
      before do
        visit root_path
      end

      it 'ゲストユーザーはTopicを作成できないこと' do
        expect do
          fill_in 'title', with: 'なんでも'
          click_button '作成'
          expect(page).to have_content 'ログインしてください'
          expect(current_path).to eq login_path
        end.to_not change(Topic, :count)
      end

      it '無効な値でTopicを作成できないこと' do
        expect do
          sign_in_as user
          fill_in 'title', with: ''
          click_button '作成'
        end.to_not change(Topic, :count)
      end

      it 'ログインしているユーザーはTopicを作成できること' do
        sign_in_as user
        expect do
          fill_in 'title', with: 'なんでも'
          click_button '作成'
          expect(page).to have_content 'スレッドを作成しました'
        end.to change(Topic, :count).by(1)
      end

      it 'ログインしているユーザーはTopicを作成・タグつけできること' do
        sign_in_as user
        expect do
          fill_in 'title', with: 'なんでも'
          fill_in 'tag_list', with: 'tag1,tag2'
          click_button '作成'
          expect(page).to have_content 'スレッドを作成しました'
        end.to change(Tag, :count).by(2)
      end
    end
  end

  context 'Topicの削除' do
    before do
      visit root_path
    end

    it 'ゲストユーザーはTopicを削除できないこと' do
      topic
      # expect(page).to have_content '1件のスレッドが表示されています'
      expect(page).to_not have_content '削除'
    end

    it '自分のTopic以外は削除できないこと' do
      topic
      sign_in_as other_user
      # expect(page).to have_content '1件の投稿が表示されています'
      expect(page).to_not have_content '削除'
    end

    it '有効なユーザーはTopicを削除できること' do
      topic
      sign_in_as topic.user
      expect do
        click_on '削除'
      end.to change(Topic, :count).by(-1)
    end
  end

  it 'ユーザーを削除すると関連するマイクロポストも削除される'
  it 'トピックを削除するとタグの関連づけが削除されること'

  describe 'showページ' do
    before do
      topic
      visit "/topics/#{topic.id}"
    end

    it 'TopicからTopicの詳細ページを表示できること' do
      visit root_path
      click_link topic.title.to_s
      expect(current_path).to eq "/topics/#{topic.id}"
    end

    it 'トピックタイトルの文字列が存在すること' do
      expect(page).to have_content topic.title.to_s
    end

    it '正しいページタイトルが表示されること' do
      expect(page).to have_title 'なんでも掲示板-トピック詳細'
    end
  end
end

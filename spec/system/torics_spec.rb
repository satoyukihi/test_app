require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
  let(:topic) { FactoryBot.create(:topic) }
  let(:other_topic) { FactoryBot.create(:topic) }
  
  describe 'topページ' do
    context'Topicの作成' do
      before do
        visit root_path
      end
      
      it "ゲストユーザーはTopicを作成できないこと" do
        expect do
          fill_in 'topic', with: 'なんでも'
          click_button '作成'
          expect(page).to have_content 'ログインしてください'
        end.to_not change(topic, :count)
      end
        
      it "ログインしているユーザーはTopicを作成できること" do
        sign_in_as user
        expect do
          fill_in 'topic', with: 'なんでも'
          click_button '作成'
          expect(page).to have_content 'スレッドを作成しました'
        end.to change(topic, :count).by(1)
      end
      
      it "Topicが作成順に並ぶこと" do
        topic
        other_topic
        expect(other_topic).to eq other_topic.first
      end
    end
  end
  
    context"Topicの削除" do
      before do
        visit root_path
      end
      it "ゲストユーザーはTopicを削除できないこと" do
        topic
        expect(page).to have_content '1件のスレッドが表示されています'
        expect(page).to_not have_content '削除'
      end
      
      it "自分のTopic以外は削除できないこと" do
        topic
        sign_in_as other_user
        expect(page).to have_content '1件の投稿が表示されています'
        expect(page).to_not have_content '削除'
      end
      
      it "有効なユーザーはTopicを削除できること" do
        topic
        sign_in_as user
        expect  do
          click_link '削除'
        end.to change(user.topics, :count).by(-1)
      end
    end
        
      it 'ユーザーを削除すると関連するマイクロポストも削除される'
  
  describe "showページ" do
    before do
      topic
      visit show_topic_path
    end
      
    it "TopicからTopicの詳細ページを表示できること" do
      visit root_path
      click_link "#{topic.title}"
      expect(current_path).to eq show_topic_path
    end
    
    it 'なんでも掲示板の文字列が存在すること' do
      expect(page).to have_content "#{topic.title}"
    end

    it '正しいページタイトルが表示されること' do
      expect(page).to have_title 'なんでも掲示板-Topic詳細'
    end
      
  end
    
end
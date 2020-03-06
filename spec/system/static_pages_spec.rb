require 'rails_helper'

RSpec.describe 'StaticPages', type: :system do
  describe "トップページ" do
    context "ページ全体" do
      before do
        visit root_path
      end
      
      it "なんでも掲示板の文字列が存在すること" do
        expect(page).to have_content "なんでも掲示板"
      end
      
      it "正しいページタイトルが表示されること" do
        expect(page).to have_title "なんでも掲示板-top_page"
      end
      
      context "スレッド関係"
        it "ページネーションが機能する事"
        it "検索が機能すること(タイトル検索)"
        it "検索が機能すること(本文検索)"
    end
  end
end
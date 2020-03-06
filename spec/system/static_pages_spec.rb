require 'rails_helper'

RSpec.describe 'StaticPages', type: :system do
  describe "トップページ" do
    context "ページ全体" do
      before do
        visit root_path
      end
      
      it "なんでも掲示板の文字列が存在する事を確認" do
        expect(page).to have_content "なんでも掲示板"
      end
    end
  end
end
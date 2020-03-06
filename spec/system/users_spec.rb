require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'ユーザー登録ページ' do
    context 'ページレイアウト' do
      before do
        visit signup_path
      end
      it 'ユーザー登録の文字列が存在すること' do
        expect(page).to have_content 'ユーザー登録'
      end

      it '正しいページタイトルが表示されること' do
        expect(page).to have_title 'なんでも掲示板-signup'
      end
    end
    context 'ユーザー登録処理' do
      before do
        visit signup_path
      end

      it '有効なユーザー登録を行うとユーザー登録成功のフラッシュが表示されること' do
        expect do
          fill_in 'user[name]', with: 'yuki'
          fill_in 'user[email]', with: 'test@example.com'
          fill_in 'user[password]', with: 'foobar'
          fill_in 'user[password_confirmation]', with: 'foobar'
          click_button '作成'

          expect(page).to have_content 'ユーザー登録完了'
        end.to change(User, :count).by(1)
      end

      it '無効なユーザー登録を行うとユーザー登録できないこと' do
        expect do
          fill_in 'user[name]', with: ' '
          fill_in 'user[email]', with: 'test@example.com'
          fill_in 'user[password]', with: 'foobar'
          fill_in 'user[password_confirmation]', with: 'foobar'
          click_button '作成'
        end.to_not change(User, :count)
      end
    end
  end
end

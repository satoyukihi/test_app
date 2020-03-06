require 'rails_helper'

RSpec.describe 'Sessions', type: :system do
  let(:user) { FactoryBot.create(:user) }

  describe 'ユーザログインページ' do
    context 'ページレイアウト' do
      before do
        visit login_path
      end

      it 'ログインの文字列が存在すること' do
        expect(page).to have_content 'ログイン'
      end

      it '正しいページタイトルが表示されること' do
        expect(page).to have_title 'なんでも掲示板-login'
      end
    end
    context 'ユーザーログイン処理' do
      before do
        visit login_path
      end

      it '有効なユーザーでログインするとログイン成功のフラッシュが表示されること' do
        user
        fill_in 'email', with: user.email
        fill_in 'password', with: user.password
        click_button 'ログイン'
        expect(page).to have_content 'ログインしました'
      end

      it '誤った情報でログインできないこと' do
        user
        fill_in 'email', with: 'test@example.com'
        fill_in 'password', with: 'foobar'
        click_button 'ログイン'
        expect(page).to have_content 'メールアドレスかパスワードが間違っています'
      end
    end

    context 'ログアウト処理' do
      it 'ログアウトするとログアウト成功のフラッシュが表示されること' do
        sign_in_as(user)
        click_on 'ログアウト'
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end
end

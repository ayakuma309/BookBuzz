require 'rails_helper'

RSpec.describe User, type: :system do
  describe 'User CRUD' do
    let(:user) { create(:user) }

    describe 'ログイン前' do
      describe 'ユーザー新規登録' do
        context '成功' do
          it '作成完了' do
            visit new_user_path
            fill_in '名前', with: 'test_sign_upuser'
            fill_in 'メールアドレス', with: 'test_sign_up@example.com'
            fill_in 'パスワード', with: 'password'
            fill_in 'パスワード確認', with: 'password'
            click_button '登録'
            expect(current_path).to eq new_user_path
          end
        end

        context '失敗' do
          it '作成失敗' do
            visit new_user_path
            fill_in '名前', with: ''
            fill_in 'メールアドレス', with: ''
            fill_in 'パスワード', with: ''
            fill_in 'パスワード確認', with: ''
            click_button '登録'
            expect(current_path).to eq new_user_path
          end
        end
      end

      describe 'ユーザーログイン' do
        context '成功' do
          it 'ログイン完了' do
            visit login_path
            fill_in 'email', with: 'test@example.com'
            fill_in 'password', with: 'password'
            click_button 'ログイン'
            expect(current_path).to eq login_path
            expect(page).to have_content 'ユーザー登録'
          end
        end
        context '失敗' do
          it 'ログイン失敗' do
            visit login_path
            fill_in 'email', with: 'test@example.com'
            fill_in 'password', with: 'password'
            click_button 'ログイン'
            expect(current_path).to eq login_path
          end
        end
      end

    end

    describe 'ログイン後' do
      before do
        visit login_path
        fill_in 'email', with: 'test@example.com'
        fill_in 'password', with: 'password'
        click_button 'ログイン'
      end

      describe 'ログアウト' do
        context '正常' do
          it 'トップページに遷移' do
            visit logout_path
            expect(current_path).to eq login_path
          end
        end
      end
    end
  end

  describe 'フッターチェック' do
    context '正常に表示できるか' do
      before do
        visit root_path
      end
      it '利用規約' do
        visit terms_path
        expect(page).to have_content '第1条（適用）'
      end
      it 'プライバシーポリシー' do
        visit privacy_path
        expect(page).to have_content 'プライバシーポリシー'
      end
    end
  end
end

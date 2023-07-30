require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'userモデルのテスト' do

    it '有効なユーザーモデル作成' do
      user = FactoryBot.build(:user)
      expect(user).to be_valid
    end
    #nameについて
    it 'ユーザー名がない場合、無効' do
      user = build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include('を入力してください')
    end

    #eamilについて
    it 'メールアドレスがない場合、無効である' do
      user = FactoryBot.build(:user, email: '')
      user.valid?
      expect(user.errors.of_kind?(:email, :blank)).to be_truthy
    end

    it '空欄の場合はエラーが出る' do
      user = FactoryBot.build(:user, email: '')
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    it '同じアドレスは無効である' do
      user_1 = FactoryBot.create(:user, email: 'sample@sample.com')
      user_2 = FactoryBot.build(:user, email: 'sample@sample.com')
      user_2.valid?

      expect(user_2.errors.of_kind?(:email, :taken)).to be_truthy
    end

    #パスワードについて
    it 'パスワードがない場合、無効である' do
      user = FactoryBot.build(:user, password: '')
      user.valid?
      expect(user.errors.of_kind?(:password, :blank)).to be_truthy
    end

    it 'パスワードがない場合はエラーが出る' do
      user = FactoryBot.build(:user, password: '')
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end


    it 'パスワードが短すぎ場合、無効である' do
      user = FactoryBot.build(:user, password: 'a')
      user.valid?
      expect(user.errors.of_kind?(:password, :too_short)).to be_truthy
    end

    it 'パスワードが短すぎ(６文字未満)の場合はエラーが出る' do
      user = FactoryBot.build(:user, password: 'a')
      user.valid?
      expect(user.errors[:password]).to include("は6文字以上で入力してください")
    end

    it 'パスワードが不一致' do
      user = FactoryBot.build(:user, password: 'password1',password_confirmation: 'password2')
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end

  describe '各モデルとのアソシエーション' do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context 'Bookmark' do
      let(:target) { :bookmarks }
      it { expect(association.macro).to eq :has_many }
      it { expect(association.class_name).to eq 'Bookmark' }

      it '1:Nとなっている' do
        expect(association.macro).to eq :has_many
      end
    end
    end
  end
end

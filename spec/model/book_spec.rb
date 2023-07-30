require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'validation' do
    it '同じisbn登録は無効である' do
      book_1 = FactoryBot.create(:book, isbn: '123456')
      book_2 = FactoryBot.build(:book, isbn: '123456')
      book_2.valid?

      expect(book_2.errors.of_kind?(:isbn, :taken)).to be_truthy
    end

    describe '各モデルとのアソシエーション' do
      before do
        @book = FactoryBot.create(:book)
        user = FactoryBot.create(:user)
        sleep 0.1
      end

      let(:association) do
        described_class.reflect_on_association(target)
      end

      context "Bookmarkモデルとのアソシエーション" do
        let(:target) { :bookmarks }

        it "Bookmarkとの関連付けはhas_manyであること" do
          expect(association.macro).to eq :has_many
        end
      end
    end
  end
  describe 'メソッドのテスト' do
    describe '#save_with' do
      let(:book) { create(:book) }
      let(:tag1) { create(:tag) }
      let(:tag2) { create(:tag) }
      let(:tag_ids) { [tag1.id, tag2.id] }

      context 'タグが保存されるとき' do
        it 'アソシエーションのテスト' do
          expect {
            book.save_with(tag_ids)
          }.to change { BookTag.count }.by(2)
            .and change { book.tags.count }.by(2)
        end

        it 'returns true' do
          expect(book.save_with(tag_ids)).to be_truthy
        end
      end
      context 'タグが保存されないとき' do
        it 'アソシエーションのテスト' do
          expect {
            book.save_with([tag1.id, 999]) # 999 is an invalid tag id
          }.to raise_error(ActiveRecord::RecordInvalid)
            .and not_change { BookTag.count }
            .and not_change { book.tags.count }
        end

        it 'returns false' do
          expect(book.save_with([tag1.id, 999])).to be_falsey
        end
      end
    end

    
  end
end

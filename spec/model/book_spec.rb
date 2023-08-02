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
    end

    describe '#bookmark?' do
      let(:user) { create(:user) }
      let(:book) { create(:book) }

      context 'ブックマークされたとき' do
        before { create(:bookmark, user: user, book: book) }

        it 'returns true' do
          expect(book.bookmark?(user)).to be_truthy
        end
      end

      context 'ブックマーク外したとき' do
        it 'returns false' do
          expect(book.bookmark?(user)).to be_falsey
        end
      end
    end

    describe 'recommend_booksメソッド' do
      let(:user) { create(:user) }
      let!(:book1) { create(:book) }
      let!(:book2) { create(:book, isbn: '56789') }
      let!(:book3) { create(:book, isbn: '67890') }

      before do
        create(:bookmark, user: user, book: book1)
        create(:bookmark, user: user, book: book2)
      end

      it 'ユーザーがブックマークした本のタグを分析し、同じ種類のタグを持つ本を推薦するメソッド' do
        expect(Book).to receive(:get_bookmarked_books).with(user).and_return([book1, book2])
        expect(Book).to receive(:get_bookmarked_tags).with([book1, book2]).and_return(['tag1', 'tag2'])
        expect(Book).to receive(:find_similar_books).with([book1, book2], ['tag1', 'tag2']).and_return([book3])
        expect(Book).to receive(:get_top_recommendations).with([book3]).and_return([book3])

        recommended_books = Book.recommend_books(user)
        expect(recommended_books).to eq([book3])
      end
    end

    describe 'get_bookmarked_booksメソッド' do
      let(:user) { create(:user) }
      let!(:book1) { create(:book) }
      let!(:book2) { create(:book, isbn: '56789') }

      before { create(:bookmark, user: user, book: book1) }

      it 'ユーザーがブックマークした本の配列を取得' do
        expect(Book.get_bookmarked_books(user)).to eq([book1])
      end
    end

    describe 'get_bookmarked_tagsメソッド' do
      let!(:book1) { create(:book) }
      let!(:book2) { create(:book, isbn: '56789') }
      let!(:tag1) { create(:tag) }
      let!(:tag2) { create(:tag) }

      before do
        book1.tags << tag1
        book2.tags << tag2
      end

      it 'ブックマークした本のタグの収集（重複を除く）' do
        bookmarked_books = [book1, book2]
        expect(Book.get_bookmarked_tags(bookmarked_books)).to eq([tag1, tag2])
      end
    end

    describe 'find_similar_booksメソッド' do
      let!(:user) { create(:user) }
      let!(:book1) { create(:book) }
      let!(:book2) { create(:book, isbn: '56789') }
      let!(:tag1) { create(:tag) }
      let!(:tag2) { create(:tag) }

      it 'ブックマークしたタグと類似度が高い本を返す' do
        # テストデータの設定
        bookmarked_books = [book1]
        bookmarked_tags = [tag1]
        # 類似度の計算結果
        allow(Book).to receive(:calculate_similarity).and_return(0.7, 0.5)

        recommended_books = Book.find_similar_books(bookmarked_books, bookmarked_tags)

        expect(recommended_books).to be_an(Array)
        expect(recommended_books.length).to eq(1)
        expect(recommended_books[0][:book]).to eq(book2)
        expect(recommended_books[0][:similarity]).to eq(0.7)
      end
    end

    # 上位5件の本のリストを返す
    describe 'get_top_recommendationsメソッド' do
      let!(:book1) { create(:book) }
      let!(:book2) { create(:book, isbn: '56789') }
      let!(:book3) { create(:book, isbn: '02345') }
      let!(:book4) { create(:book, isbn: '43536') }
      let!(:book5) { create(:book, isbn: '54454') }
      let!(:book6) { create(:book, isbn: '65677') }

      let(:recommended_books) do
        [
          { book: book1, similarity: 0.9 },
          { book: book2, similarity: 0.7 },
          { book: book3, similarity: 0.5 },
          { book: book4, similarity: 0.8 },
          { book: book5, similarity: 0.6 },
          { book: book6, similarity: 0.4 }
        ]
      end

      it '上位5件の本のリストを返す' do
        # テスト対象のメソッドを呼び出す
        top_recommendations = Book.get_top_recommendations(recommended_books)

        # アサーション
        expect(top_recommendations).to be_an(Array)
        expect(top_recommendations.length).to eq(5)
        expect(top_recommendations).to include(book1, book2, book4, book3, book5)
        expect(top_recommendations).not_to include(book6)
      end
    end

    describe 'calculate_similarityメソッド' do
      let!(:tag1) { create(:tag) }
      let!(:tag2) { create(:tag) }
      let!(:tag3) { create(:tag) }

      it 'タグの類似度を計算するメソッド' do
        bookmarked_tags = [tag1, tag2]
        book_tags = [tag2, tag3]
        similarity = Book.calculate_similarity(bookmarked_tags, book_tags)
        expect(similarity).to be_within(0.01).of(0.33)
      end

      it 'タグリストが空の場合は類似度を0とする' do
        bookmarked_tags = []
        book_tags = [tag1, tag2]
        similarity = Book.calculate_similarity(bookmarked_tags, book_tags)
        expect(similarity).to eq(0)

        bookmarked_tags = [tag1, tag2]
        book_tags = []
        similarity = Book.calculate_similarity(bookmarked_tags, book_tags)
        expect(similarity).to eq(0)
      end
    end

    describe 'recommend_books_with_different_tagsメソッド' do
      let(:user) { create(:user) }
      let!(:book1) { create(:book) }
      let!(:book2) { create(:book, isbn: '56789') }
      let!(:book3) { create(:book, isbn: '67890') }
      let!(:tag1) { create(:tag) }
      let!(:tag2) { create(:tag) }
      let!(:tag3) { create(:tag) }

      before do
        create(:bookmark, user: user, book: book1)
        book1.tags << tag1
        book2.tags << tag2
        book3.tags << tag3
      end

      it 'ユーザーがブックマークした本のタグを分析し、違う種類のタグを持つ本を5件推薦するメソッド' do
        expect(Book.recommend_books_with_different_tags(user).count).to eq(2)
      end
    end
  end
end

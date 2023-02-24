require 'rails_helper'

RSpec.describe Movie, type: :model do
  # TODO:rspecが途中で構文エラーやテストが失敗するとユーザーが作成されてしまう時がある
    describe '登録系のテスト' do
      context '正常系' do
        it '正しく登録できること' do
          @user = FactoryBot.create(:user)
          movie = Movie.new(
            title: 'インターステラー',
            image_path: 'example_path',
            director: 'クリストファー・ノーラン',
            release_at: '2010-01-01',
            evaluation: 5,
            viewing_at: '2018-01-01',
            review: '最高だった！',
            user_id: @user.id
          )
          
          expect(movie).to be_valid
          
          movie.save!
          ["example_actor1"].map {|actor|
            movie.starrings.find_or_create_by!(name: actor)
          }
          ["example_genre1"].map {|genre|
            movie.genres.find_or_create_by!(name: genre)
          }

          result_movie = Movie.find(movie.id);
          expect(result_movie.title).to eq('インターステラー')
          expect(result_movie.image_path).to eq('example_path')
          expect(result_movie.director).to eq('クリストファー・ノーラン')
          expect(result_movie.release_at).to eq('2010-01-01')
          expect(result_movie.evaluation).to eq(5)
          expect(result_movie.viewing_at).to eq('2018-01-01')
          expect(result_movie.review).to eq('最高だった！')
          expect(result_movie.user_id).to eq(@user.id)
          result_movie.starrings.each do |starring|
            expect(starring.name).to eq("example_actor1")
          end
          result_movie.genres.each do |genre|
            expect(genre.name).to eq("example_genre1")
          end
        end
        it '映画の画像とレビューが空でも保存できること' do
          @user = FactoryBot.create(:user)
          movie = Movie.new(
            title: 'インターステラー',
              image_path: '',
              director: 'クリストファー・ノーラン',
              release_at: '2010-01-01',
              evaluation: '1',
              viewing_at: '2018-01-01',
              review: '',
              user_id: @user.id
          )
          expect(movie).to be_valid
        end
      end
      context '異常系のテスト（バリデーションが発生すること）' do
        it '映画のタイトルが必須であること' do
          @user = FactoryBot.create(:user)
          movie = Movie.new(
            title: '',
            image_path: 'example_path',
            director: 'クリストファー・ノーラン',
            release_at: '2010-01-01',
            evaluation: 5,
            viewing_at: '2018-01-01',
            review: '最高だった！',
            user_id: @user.id
          )
          expect(movie).not_to be_valid
          expect(movie.errors[:title]).to include(I18n.t('errors.messages.blank'))
        end

        it '評価が数値であること' do
          @user = FactoryBot.create(:user)
          movie = Movie.new(
            title: 'インターステラー',
            image_path: 'example_path',
            director: 'クリストファー・ノーラン',
            release_at: '2010-01-01',
            evaluation: 'evaluation',
            viewing_at: '2018-01-01',
            review: '最高だった！',
            user_id: @user.id
          )
          expect(movie).not_to be_valid
          expect(movie.errors[:evaluation]).to include(I18n.t('errors.messages.not_a_number'))
        end

        it '評価は1~5までの範囲であること' do
          @user = FactoryBot.create(:user)
          movie = Movie.new(
            title: 'インターステラー',
            image_path: 'example_path',
            director: 'クリストファー・ノーラン',
            release_at: '2010-01-01',
            evaluation: 6,
            viewing_at: '2018-01-01',
            review: '最高だった！',
            user_id: @user.id
          )
          expect(movie).not_to be_valid
          expect(movie.errors[:evaluation]).to include(I18n.t('errors.messages.invalid_int_range'))
        end
    end
  end
end

require 'rails_helper'

RSpec.describe Movie, type: :model do
    describe '登録系のテスト' do
      context '正常系' do
        it '正しく登録できること' do
          @user = create(:user)
          movie = create(:movie, user: @user)

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
          @user = create(:user)
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
          @user = create(:user)
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
          @user = create(:user)
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
          @user = create(:user)
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
    describe '参照系のテスト' do
      it '指定した映画のタイトルは取得できているか' do
        user =  create(:user)
        movie = create(:movie, user: user)
        params = {:title => 'インターステラー'}
        expect(Movie.search_movies(params)).to include(movie)
      end

      it '指定した映画のタイトルは複数取得できているか' do
        user =  create(:user)
        movies  = [
          create(:movie, user: user),
          create(:movie, user: user)
        ]
        params = {:title => 'インターステラー'}
        expect(Movie.search_movies(params)).to contain_exactly(movies[0], movies[1])
      end

      it '指定した映画のタイトルの部分一致でも映画を取得できているか' do
        user = create(:user)
        movie = create(:movie, user: user)
        params = {:title=>"インター", :user_id=>user.id}
        expect(Movie.search_movies(params)).to include(movie)
      end

      it '存在しない映画のタイトルは取得していないか' do
        user = create(:user)
        params = {:title=>"not found", :user_id=>user.id}
        expect(Movie.search_movies(params)).to be_empty
      end
    end
end

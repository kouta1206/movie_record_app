
Faker::Config.locale = 'es'
# client = HTTPClient.new
# url =  "https://api.themoviedb.org/3"
# img_src =  "https://image.tmdb.org/t/p/w300_and_h450_bestv2"
# req = client.get("#{url}/movie/popular?api_key=#{ENV['API_KEY']}")
# res = JSON.parse(req.body)
# movies = res['results']
genre_name = ["アクション映画", "冒険映画", "アニメーション映画", "伝記映画", "コメディ映画", "犯罪映画", "ドキュメンタリー映画", "ドラマ映画", "ファミリー映画", "ファンタジー映画", "フィルムノワール", "歴史映画", "ホラー映画", "音楽", "ミュージカル映画", "ミステリー映画", "ロマンス", "SF映画", "短編映画", "スポーツ", "スリラー映画", "戦争映画", "西部劇"]
# movies.each do |movie|
10000.times do |n|
    viewing_at =  Faker::Date.between(from: 1.year.ago, to: 1.year.from_now)
    review = Faker::Lorem.paragraph(sentence_count: 10)
    image_path = Faker::Name.unique.name
    movie_result = Movie.create!(user_id: rand(1..10), title: Faker::Name.unique.name, image_path: image_path, release_at: Faker::Date.between(from: 1.year.ago, to: 1.year.from_now), director: Faker::Name.unique.name, evaluation: rand(1..5), viewing_at: viewing_at, review: review)
    10.times do |n|
        starring = Starring.find_or_create_by!(name: Faker::Name.unique.name)
        movie_result.starrings << starring
    end
    10.times do |n|
        genre = Genre.find_or_create_by!(name: genre_name.sample)
        movie_result.genres << genre
    end
end



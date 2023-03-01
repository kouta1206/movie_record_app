# Faker::Config.locale = 'es'
# client = HTTPClient.new
# url =  "https://api.themoviedb.org/3"
# img_src =  "https://image.tmdb.org/t/p/w300_and_h450_bestv2"
# req = client.get("#{url}/movie/popular?api_key=#{ENV['API_KEY']}")
# res = JSON.parse(req.body)
# movies = res['results']
# movies.each do |movie|
genre_name = ["アクション", "アドベンチャー", "アニメーション", "伝記", "コメディ", "犯罪", "ドキュメンタリー", "ドラマ", "ファミリー", "ファンタジー", "フィルムノワール", "歴史", "ホラー", "音楽", "ミュージカル", "ミステリー", "ロマンス", "SF", "短編", "スポーツ", "スリラー", "戦争", "西部劇"]
#     viewing_at =  Faker::Date.between(from: 1.year.ago, to: 1.year.from_now)
#     review = Faker::Lorem.paragraph(sentence_count: 10)
#     image_path = "#{img_src}#{movie['backdrop_path']}"
#     movie_result = Movie.create!(user_id: 1, title: movie["title"], image_path: image_path, release_at: movie["release_date"], director: Faker::Name.unique.name, evaluation: rand(1..5), viewing_at: viewing_at, review: review)
#     5.times do |n|
#         starring = Starring.find_or_create_by!(name: Faker::Name.unique.name)
#         movie_result.starrings << starring
#     end
#     3.times do |n|
#         genre = Genre.find_or_create_by!(name: genre_name.sample)
#         movie_result.genres << genre
#     end
# end

movie = Movie.create!(user_id: 1,
    title:'トップガン', 
    image_path: 'https://image.tmdb.org/t/p/w300_and_h450_bestv2/jILeJ60zPpIjjJHGSmIeY4eO30t.jpg', 
    release_at: '1986-12-06', 
    director: 'トニー・スコット', 
    evaluation: 5, 
    viewing_at: '2023-01-26', 
    review: '今更ですが、初視聴しました。時代は感じるものの、とても面白かったです。若かりし頃のトムクルーズ！やっぱりカッコ良いです。ただ、周りの背が高いのか、トムが低いのか、凄く小さく見えます。音楽これ聞いたことあるって曲が流れてきます！それだけでも、ノリノリになれます。')
    starrings_name = ['トム・クルーズ', 'マイルズ・テラー','ジェニファー・コネリー', 'エド・ハリス', 'ジョン・ハム', 'ヴァル・キルマー']
    starrings_name.each do |name|
        starring = Starring.find_or_create_by!(name:name)
        movie.starrings <<  starring
    end
    genre = Genre.find_or_create_by!(name: genre_name[0])
     movie.genres << genre
movie = Movie.create!(user_id: 1,
    title:'トップガン トップガン マーヴェリック', 
    image_path: 'https://image.tmdb.org/t/p/w300_and_h450_bestv2/odJ4hx6g6vBt4lBWKFD1tI8WS4x.jpg', 
    release_at: '2022-05-27', 
    director: 'ジョセフ・コシンスキー', 
    evaluation: 5, 
    viewing_at: '2023-01-27', 
    review: '空中のシーンは臨場感ありすぎて緊張した‼️
    トムクルーズも若くないのにまだまだ元気にアクションやってて、すげぇカッコよかった！
    前作見てない人にも分かりやすいような描かれ方で、知らなくても楽しめた')
    starrings_name = ['トム・クルーズ', 'マイルズ・テラー','ジェニファー・コネリー', 'エド・ハリス', 'ジョン・ハム', 'ヴァル・キルマー']
    starrings_name.each do |name|
        starring = Starring.find_or_create_by!(name:name)
        movie.starrings <<  starring
    end
    genre = Genre.find_or_create_by!(name: genre_name[0])
     movie.genres << genre


movie = Movie.create!(user_id: 1,
    title:'インターステラー', 
    image_path:'https://image.tmdb.org/t/p/w300_and_h450_bestv2/rAiYTfKGqDCRIIqo664sY9XZIvQ.jpg',
    release_at: '2014-11-22', 
    director: 'クリストファー・ノーラン', 
    evaluation: 4, 
    viewing_at: '2018-01-26', 
    review: '今更ですが、初視聴しました。時代は感じるものの、とても面白かったです。若かりし頃のトムクルーズ！やっぱりカッコ良いです。ただ、周りの背が高いのか、トムが低いのか、凄く小さく見えます。音楽これ聞いたことあるって曲が流れてきます！それだけでも、ノリノリになれます。')
    starrings_name = ['マシュー・マコノヒー', 'アン・ハサウェイ','ジェシカ・チャステイン', 'マイケル・ケイン', 'ジョン・ハム', 'ヴァル・キルマー']
    starrings_name.each do |name|
        starring = Starring.find_or_create_by!(name:name)
        movie.starrings <<  starring
    end
    genre = Genre.find_or_create_by!(name: genre_name[1])
     movie.genres << genre


movie = Movie.create!(user_id: 1,
    title:'TENET テネット', 
    image_path: 'https://image.tmdb.org/t/p/w300_and_h450_bestv2/yY76zq9XSuJ4nWyPDuwkdV7Wt0c.jpg', 
    release_at: '2020-09-18', 
    director: 'クリストファー・ノーラン', 
    evaluation: 4, 
    viewing_at: '2023-01-27', 
    review: 'やっぱりノーラン凄い。垂れ流しアクションではなく。その裏がちゃんとしている。魅せ方が人間じゃない。ただストーリーが分かりづらい。インセプションが丁度いい。')
    starrings_name = ['ジョン･デヴィッド･ワシントン', 'ロバート・パティンソン','エリザベス・デビッキ', 'アーロン・テイラー・ジョンソン', 'クレマンス・ポエジー', 'ヴァル・キルマー']
    starrings_name.each do |name|
        starring = Starring.find_or_create_by!(name:name)
        movie.starrings <<  starring
    end
    genre = Genre.find_or_create_by!(name: genre_name[0])
     movie.genres << genre


movie = Movie.create!(user_id: 1,
    title:'ダンケルク', 
    image_path: '	https://image.tmdb.org/t/p/w300_and_h450_bestv2/eXYbyOx6GFvmpOJl6AS8QxXeIYE.jpg', 
    release_at: '2017-09-09', 
    director: 'クリストファー・ノーラン', 
    evaluation: 3, 
    viewing_at: '2023-01-03', 
    review: '音楽が！ずっと！ドキドキさせてきた！
    久々に息が詰まる映画だった
    防波堤、海、空
    一息ついたと思ったらまた攻撃、また攻撃、また攻撃
    生き残るを描いた映画
    全体的にセリフが…')
    starrings_name = ['フィン・ホワイトヘッド', 'ダミエン・ボナール','アナイリン・バーナード', 'リー・アームストロング', 'ジェームス・ブロアー', 'ヴァル・キルマー']
    starrings_name.each do |name|
        starring = Starring.find_or_create_by!(name:name)
        movie.starrings <<  starring
    end
    genre = Genre.find_or_create_by!(name: genre_name[6])
     movie.genres << genre


movie = Movie.create!(user_id: 1,
    title:'スタートアップ：夢の扉', 
    image_path: 'https://image.tmdb.org/t/p/w300_and_h450_bestv2/8NK9un1DPUTgRzGtJHMvpdIB5Ay.jpg', 
    release_at: '2020-10-17', 
    director: 'パク・ヘリョン', 
    evaluation: 5, 
    viewing_at: '2022-10-01', 
    review: '面白かった～。
    ハイテク企業の起業がテーマでコンピューター苦手だけどついていけた。
    主人公ダルミとドサンの恋愛初心者とダルミの少女のときの文通相手ジヒョンの三角関係。
    皆で会社大きくしようとするとこが良かった。
    でも、ダルミがお姉さんのこといつまでもライバル視してなんかそこがな。')
    starrings_name = ['ペ・スジ', 'ナム・ジュヒョク','キム・ソンホ（キム・ソノ）', 'カン・ハンナ', 'キム・ヘスク', 'ユ・スビン']
    starrings_name.each do |name|
        starring = Starring.find_or_create_by!(name:name)
        movie.starrings <<  starring
    end
    genre = Genre.find_or_create_by!(name: genre_name[4])
     movie.genres << genre


movie = Movie.create!(user_id: 1,
    title:'The 100/ハンドレッド<ファースト・シーズン>', 
    image_path: 'https://image.tmdb.org/t/p/w300_and_h450_bestv2/hTExot1sfn7dHZjGrk0Aiwpntxt.jpg', 
    release_at: '2022-12-04', 
    director: 'ディーン・ホワイト', 
    evaluation: 5, 
    viewing_at: '2021-12-26', 
    review: '人類が絶滅されたとされる地球に降ろされた100人のサバイバル
    地球を初めて見た表情が印象的
    クラークやオクタヴィア、レイヴンが美しく、フィンやリンカーンがカッコよくて目の保養
    人類は絶滅したはずの地球には人類がいて、戦争を繰り返している模様
    彼らにしてみればクラークたちは侵略者なので攻撃される
    地球に送られた100人は未成年の前科者（大した罪じゃなかったり罪を犯してない人もいるけど）なので、「いやいやもうちょっと考えて！」って時もありヒヤヒヤするし、統率が取れてないせいでいざこざも絶えないけれど、若者だってなんだかんだで社会は作れる
    四苦八苦しながらのサバイバルや戦いは面白い')
    starrings_name = ['エリザ・テイラー', 'ペイジ・ターコー','リッキー・ウィトル']
    starrings_name.each do |name|
        starring = Starring.find_or_create_by!(name:name)
        movie.starrings <<  starring
    end
    genre = Genre.find_or_create_by!(name: genre_name[8])
     movie.genres << genre


movie = Movie.create!(user_id: 1,
    title:'イミテーション・ゲーム／エニグマと天才数学者の秘密',
    image_path: 'https://image.tmdb.org/t/p/w300_and_h450_bestv2/jFp5aAlGQ1H3gwdORL2urr8dnoN.jpg', 
    release_at: '2015-03-13', 
    director: 'モルテン・ティルドゥム',
    evaluation: 3, 
    viewing_at: '2022-10-09',
    review: '話の入ってきやすい展開
    事実に基づいたストーリーとは思えないほど。')
    starrings_name = ['ベネディクト・カンバーバッチ', 'キーラ・ナイトレイ','チャールズ・ダンス', 'マシュー・グード', 'マーク・ストロング']
    starrings_name.each do |name|
        starring = Starring.find_or_create_by!(name:name)
        movie.starrings <<  starring
    end
    genre = Genre.find_or_create_by!(name: genre_name[9])
     movie.genres << genre


movie = Movie.create!(user_id: 1,
    title:'ゲーム・オブ・スローンズ 第一章：七王国戦記', 
    image_path: 'https://image.tmdb.org/t/p/w300_and_h450_bestv2/2OMB0ynKlyIenMJWI2Dy9IWT4c.jpg',
    release_at: '2011-02-02', 
    director: 'ジョージ・R・R・マーティン',
    evaluation: 5,
    viewing_at: '2022-01-26', 
    review: "思ったほどファンタジー色が強くなくて良かった。そこまで目が離せない展開はないけどどんどん見てしまうのは世界観の作り込みと役者たちの良さかなと思う。
    でも9話の最後から予想外の展開すぎて目が離せなくなってしまった。今のところスノウとティリオンが好き。好きなキャラもこの先どうなるか楽しみ。")
    starrings_name = ['ショーン・ビーン', 'エミリア・クラーク', 'キット・ハリントン', 'マーク・アディ', 'レナ・ヘディ', 'ニコライ・コスター・ワルドウ']
    starrings_name.each do |name|
        starring = Starring.find_or_create_by!(name:name)
        movie.starrings <<  starring
    end
    genre = Genre.find_or_create_by!(name: genre_name[3])
     movie.genres << genre


movie = Movie.create!(user_id: 1,
    title:'ハリー・ポッターと死の秘宝 PART2', 
    image_path: 'https://image.tmdb.org/t/p/w300_and_h450_bestv2/n5A7brJCjejceZmHyujwUTVgQNC.jpg', 
    release_at: '2011-02-02', 
    director: 'デヴィッド・イェーツ', 
    evaluation: 4, 
    viewing_at: '2021-01-26', 
    review: 'ハリーポッターの最終章
    スネイプ先生の愛の深さに泣いた
    実はずっと影から見守ってたなんて不器用すぎるよスネイプ先生
    ハーマイオニーとロンのキスシーンは微笑ましかった
    そして、ネビル凄く強くなったね
    あんなに立派な子になるなんて思わなかった
    大切な子供達を殺されて最後ヘレナにキレるロンのお母さんをみて母強しと思った
    ニワトコの杖を何の躊躇もなく折るハリーは凄いと思った
    やっぱりハリーポッターシリーズは見れば見るほど面白い作品だと思った',)
    starrings_name = ['ダニエル・ラドクリフ', 'ルパート・グリント','エマ・ワトソン', 'ヘレナ・ボナムカーター', 'ロビー・コルトレーン', 'レイフ・ファインズ']
    starrings_name.each do |name|
        starring = Starring.find_or_create_by!(name:name)
        movie.starrings <<  starring
    end
    genre = Genre.find_or_create_by!(name: genre_name[0])
     movie.genres << genre


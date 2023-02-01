class AccessApi

    class << self
        def search(params = { })
            client = HTTPClient.new
            url =  "https://api.themoviedb.org/3"
            img_src =  "https://image.tmdb.org/t/p/w300_and_h450_bestv2"
            url = URI.encode  "#{url}/search/multi?api_key=#{ENV['API_KEY']}&query=#{params["value"]}"
            req = client.get(url)
            res = JSON.parse(req.body)
            res["result"].present? ? res["results"][0]["backdrop_path"] =  "#{img_src}#{res["results"][0]["backdrop_path"]}" :  []
            movie = res['results']
        end
    end
end

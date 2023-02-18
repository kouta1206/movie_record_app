<template>
  <section style="width: 90vw" class="mt-6">
    <b-field position="is-centered">
      <b-input
        placeholder="検索から登録"
        type="search"
        icon="magnify"
        v-model="searchParam"
      >
      </b-input>
      <p class="control">
        <b-button label="Search" type="is-info" @click="searchAsyncTmdbMovie" />
      </p>
    </b-field>
    <b-loading
      :is-full-page="isFullPage"
      v-model="isLoading"
      :can-cancel="true"
    ></b-loading>
    <hr />
    <div class="is-flex is-flex-wrap-wrap is-justify-content-center">
      <div
        v-for="movie in tmdbMovie"
        :key="movie.id"
        ref="currentCard"
        @click="confirm(movie)"
      >
        <div class="card mx-4 mb-5" style="width: 20vw; cursor: pointer">
          <div class="card-image">
            <figure class="image is-4by3">
              <img
                :src="`https://image.tmdb.org/t/p/w300_and_h450_bestv2${movie['backdrop_path']}`"
                alt="Placeholder image"
              />
            </figure>
          </div>
          <div class="card-content">
            <div class="media">
              <div class="media-left">
                <figure class="image is-48x48">
                  <img
                    :src="`https://image.tmdb.org/t/p/w300_and_h450_bestv2${movie['backdrop_path']}`"
                    alt="Placeholder image"
                  />
                </figure>
              </div>
              <div class="media-content">
                <p class="title is-4">{{ movie.name }}</p>
              </div>
            </div>

            <div class="content">
              <label for="">放送開始日</label>
              {{ movie.first_air_date }}
              <br />
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
export default {
  middleware: ['unauthorized'],
  data() {
    return {
      tmdbMovie: [],
      searchParam: "",
      isLoading: false,
      isFullPage: true,
    };
  },
  methods: {
    async searchAsyncTmdbMovie() {
      this.isLoading = true;
      this.tmdbMovie = [];
      let params = this.setSearchParam();
      await this.$axios
        .$get("api/v1/access_tmdb", {
          params,
        })
        .then((res) => {
          if (!res.length) {
            return;
          } else {
            this.tmdbMovie.push(...res);
            console.log(this.tmdbMovie);
          }
        })
        .catch((error) => {
          console.log(error);
        });
      this.isLoading = false;
    },
    setSearchParam() {
      let params = [];
      if (this.searchParam) {
        params.push(["value", this.searchParam]);
      }
      return Object.fromEntries(params);
    },
    confirm(movie) {
      this.$buefy.dialog.confirm({
        message: "こちらの映画のレビューを書きますか？",
        onConfirm: () => this.prepareRecord(movie),
        // console.log(movie),
      });
    },
    prepareRecord(movie) {
      //選択したタイトルと画像path、放送開始日をdispach
      let leadImgUrl = "https://image.tmdb.org/t/p/w300_and_h450_bestv2";
      this.$store.commit("tmdb/setTmdbTitle", movie.name);
      this.$store.commit("tmdb/setTmdbImagePath", leadImgUrl + movie.backdrop_path);
      this.$store.commit("tmdb/setTmdbReleaseDate", movie.first_air_date);
      this.$router.push("/record-movie");
    },
  },
};
</script>

<style>
</style>

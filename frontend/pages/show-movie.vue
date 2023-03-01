<template>
  <div style="width: 100vw">
    <div class="header-container">
      <div class="is-flex">
        <div v-if="movieData.image_path !== null">
          <img :src="`${movieData.image_path}`" alt="" style="width: 250px" />
        </div>
        <div v-else>
          <img src="../assets/no_image.png" alt="" srcset="" />
        </div>
        <div class="header-movie-detail ml-6">
            <h1>{{ movieData.title }}</h1>
          <div class="header-movie-genres mb-3">
            <h2>ジャンル</h2>
            <span
              class="movie-headline"
              v-for="(genre, index) in genreData"
              :key="index"
              >{{ genre.name }}</span
            >
          </div>
          <div class="header-movie-director mb-3">
            <h2>映画監督</h2>
            <span class="movie-headline">{{ movieData.director }}</span>
          </div>
          <div class="header-movie-starrings mb-3">
            <h2>出演者</h2>
            <span
              class="movie-headline"
              v-for="(starring, index) in starringData"
              :key="index"
              >{{ starring.name }}</span
            >
          </div>
          <b-loading
            :is-full-page="isFullPage"
            v-model="isLoading"
            :can-cancel="true"
          ></b-loading>
          <div class="header-movie-evaluation">
            <h2 for="">評価</h2>
            <AwesomeVueStarRating
              disabled
              :star="movieData.evaluation"
              :hasresults="false"
              :hasdescription="false"
            />
          </div>
          <div class="buttons mt-5">
            <b-button
              type="is-light is-light mr-5"
              outlined
              @click="editRecordMovie()"
              >編集する</b-button
            >
            <b-button
              type="is-danger is-danger"
              outlined
              @click="confirmDeleteDialog()"
              >削除する</b-button
            >
          </div>
        </div>
      </div>
    </div>
    <div class="balloon4">
      <p>{{ movieData.review }}</p>
    </div>
  </div>
</template>

<script>
import AwesomeVueStarRating from "awesome-vue-star-rating";

export default {
  components: {
    AwesomeVueStarRating,
  },
  async mounted() {
    await this.getAsyncMovie(this.id);
  },
  data() {
    return {
      id: this.$route.query.id,
      movieData: [],
      starringData: [],
      genreData: [],
      ignoreKeys: ["genres", "starrings"],
      isLoading: false,
      isFullPage: false,
    };
  },
  methods: {
    async getAsyncMovie(id) {
      this.isLoading = true;
      await this.$axios
        .$get(`api/v1/movies/${id}`)
        .then((res) => {
          let movieData = this.ignoreObjectKey(res, this.ignoreKeys);
          this.movieData = movieData;
          this.genreData = res.genres;
          this.starringData = res.starrings;
        })
        .catch((error) => {
        });
      this.isLoading = false;
    },
    ignoreObjectKey(data, ignoreKeys) {
      const filteredObjectDate = {};
      for (const key in data) {
        if (!ignoreKeys.filter((ignoreKey) => ignoreKey === key).length) {
          filteredObjectDate[key] = data[key];
        }
      }
      return filteredObjectDate;
    },
    editRecordMovie() {
      this.$buefy.dialog.confirm({
        message: `${this.movieData.title}の映画を編集しますか？`,
        onConfirm: () => this.prepareEditMovie(),
      });
    },
    confirmDeleteDialog() {
      this.$buefy.dialog.confirm({
        message: `記録した${this.movieData.title}を削除しますか？`,
        onConfirm: () => this.asyncDeleteRecordMovie(),
      });
    },
    async asyncDeleteRecordMovie() {
      const paramsId = { id: this.movieData.id };
      this.$axios
        .$delete(`api/v1/movies/${paramsId.id}`)
        .then((res) => {
          this.toasterOutput();

          this.$router.push({
            name: "index-movie",
            path: "index-movie",
          });
        })
        .catch((error) => {});
    },
    toasterOutput() {
      this.$buefy.notification.open({
        message: `映画を削除しました`,
        type: "is-link",
        pauseOnHover: true,
        "auto-close": true,
        position: "is-bottom-right",
      });
    },
    prepareEditMovie() {
      this.$store.commit("edit/setMovieId", this.id);
      this.$store.commit("edit/setMovieTitle", this.movieData.title);
      this.$store.commit("edit/setMovieDirector", this.movieData.director);
      this.$store.commit("edit/setMovieImg", this.movieData.image_path);
      this.$store.commit("edit/setGenreName", this.genreData);
      this.$store.commit("edit/setStarringName", this.starringData);
      this.$store.commit("edit/setMovieEvaluation", this.movieData.evaluation);
      this.$store.commit("edit/setMovieReleaseDate", this.movieData.release_at);
      this.$store.commit("edit/setMovieViewingDate", this.movieData.viewing_at);
      this.$store.commit("edit/setMovieViewingDate", this.movieData.viewing_at);
      this.$store.commit("edit/setMovieReview", this.movieData.review);
      this.$store.commit("edit/setDataExists", true);

      this.$router.push({
        name: "edit-movie",
        path: "edit-movie",
      });
    },
  },
};
</script>

<style>
h2 {
  font-weight: 700;
}

.header-container {
  padding: 20px;
  margin-top: 20px;
  background-image: linear-gradient(
    to right,
    rgba(31.5, 31.5, 52.5, 1) calc((50vw - 170px) - 340px),
    rgba(31.5, 31.5, 52.5, 0.84) 30%,
    rgba(31.5, 31.5, 52.5, 0.84) 100%
  );
  color: #fff;
}
.header-movie-title > h1 {
  font-weight: 700;
  font-size: 2rem;
}

.balloon4 {
  position: relative;
  margin: 2em 0 2em 40px;
  padding: 15px;
  background: #fff0c6;
  border-radius: 30px;
}

.balloon4:before {
  content: "";
  position: absolute;
  left: -38px;
  width: 13px;
  height: 12px;
  bottom: 0;
  background: #fff0c6;
  border-radius: 50%;
}

.balloon4:after {
  content: "";
  position: absolute;
  left: -24px;
  width: 20px;
  height: 18px;
  bottom: 3px;
  background: #fff0c6;
  border-radius: 50%;
}
.balloon4 p {
  margin: 0;
  padding: 0;
}

.movie-headline {
  position: relative;
  display: inline-block;
  margin-left: 30px;
  color: #fff;
  background: #7957d5;
  padding-right: 5px;
  margin-bottom: 4px;
}

.movie-headline:before {
  position: absolute;
  left: -12px;
  content: "";
  border-width: 12px 12px 12px 0;
  border-style: solid;
  border-color: transparent #7957d5 transparent transparent;
}

.movie-headline:after {
  position: absolute;
  top: calc(50% - 3px);
  left: -7px;
  width: 6px;
  height: 6px;
  content: "";
  border-radius: 50%;
  background: #fff;
}
</style>

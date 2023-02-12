<template>
  <div style="width: 100vw">
    <div class="header-container">
      <div class="is-flex">
        <div v-if="movieDate.image_path !== null">
          <img :src="`${movieDate.image_path}`" alt="" style="width: 250px" />
        </div>
        <div v-else>
          <img src="../assets/no_image.png" alt="" srcset="" />
        </div>
        <div class="header-movie-detail ml-6">
          <div class="header-movie-title">
            <h1>{{ movieDate.title }}</h1>
          </div>
          <div class="header-movie-genres mb-3">
            <h2>ジャンル</h2>
            <span
              class="movie-headline"
              v-for="(genre, index) in genreDate"
              :key="index"
              >{{ genre }}</span
            >
          </div>
          <div class="header-movie-director mb-3">
            <h2>映画監督</h2>
            <span class="movie-headline">{{ movieDate.title }}</span>
          </div>
          <div class="header-movie-starrings mb-3">
            <h2>出演者</h2>
            <span
              class="movie-headline"
              v-for="(starring, index) in starringDate"
              :key="index"
              >{{ starring }}</span
            >
          </div>
          <div class="header-movie-evaluation">
            <h2 for="">評価</h2>
            <AwesomeVueStarRating
              disabled
              :star="movieDate.evaluation"
              :hasresults="false"
              :hasdescription="false"
            />
          </div>
        </div>
      </div>
      <div></div>
    </div>
    <div class="balloon4">
      <p>{{ movieDate.review }}</p>
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
      movieDate: [],
      starringDate: [],
      genreDate: [],
    };
  },
  methods: {
    async getAsyncMovie(id) {
      await this.$axios
        .$get(`api/v1/movies/${id}`)
        .then((res) => {
          (this.movieDate = res["movie"]),
            (this.genreDate = res["genres"]),
            (this.starringDate = res["starrings"]);
          console.log(this.genreDate);
        })
        .catch((error) => {
          console.log(error);
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
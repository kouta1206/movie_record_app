<template>
  <div style="width: 90vw">
    <div class="is-flex mx-6 my-6">
      <div>
        <figure class="image is-256x256">
          <img
            v-if="tmdbImgPath == null"
            style="width: 256px"
            height="256px"
            src="../assets/no_image.png"
          />
          <img v-else style="width: 256px" height="256px" :src="tmdbImgPath" />
        </figure>
      </div>
      <section class="ml-6">
        <div class="mt-6">
          <b-field
            class="mb-6"
            label="映画のタイトル"
            :label-position="labelPosition"
          >
            <b-input :value="tmdbTitle" v-model="tmdbTitle"></b-input>
          </b-field>

          <b-field class="mb-5" label="出演者" :label-position="labelPosition">
            <b-taginput
              :value="['hoge']"
              ellipsis
              icon="label"
              placeholder="出演者を入力下さい"
            >
            </b-taginput>
          </b-field>

          <label
            style="
              font-weight: 600;
              color: #363636;
              font-size: calc(1rem * 0.75);
            "
            for=""
            >評価</label
          >
          <div class="is-flex">
            <AwesomeVueStarRating
              :star="evaluation"
              :hasresults="false"
              :hasdescription="false"
            />
            <b-field
              label="ジャンル"
              :label-position="labelPosition"
              class="mb-5 ml-6"
            >
              <b-select
                placeholder="ジャンルを選択して下さい"
                v-model="genreName"
              >
                <option
                  v-for="genre in genres"
                  :value="genre.name"
                  :key="genre.id"
                >
                  {{ genre.name }}
                </option>
              </b-select>
            </b-field>
          </div>
        </div>
      </section>

      <section class="ml-6">
        <div class="mt-6">
          <b-field
            class="mb-6"
            label="映画監督"
            :label-position="labelPosition"
          >
            <b-autocomplete
              rounded
              :data="['jQuery', 'Vue', 'React']"
              placeholder="映画監督"
              icon="magnify"
              clearable
              @select="(option) => (selected = option)"
            >
              <template #empty>No results found</template>
            </b-autocomplete>
          </b-field>

          <b-field
            class="mb-6"
            label="放送開始日"
            :label-position="labelPosition"
          >
            <b-datepicker
              placeholder="放送開始日を入力ください"
              icon="calendar-today"
              v-model="tmdbReleaseDate"
              trap-focus
            >
            </b-datepicker>
          </b-field>

          <b-field label="視聴日" :label-position="labelPosition">
            <b-datepicker
              placeholder="視聴日を入力ください"
              icon="calendar-today"
              trap-focus
            >
            </b-datepicker>
          </b-field>
        </div>
      </section>
    </div>
    <div style="text-align: center">
      <TextareaAutosize
        style="width: 80vw"
        placeholder="レビューを入力してください....."
        ref="myTextarea"
        :min-height="200"
        :max-height="700"
      />
    </div>
  </div>
</template>

<script>
import AwesomeVueStarRating from "awesome-vue-star-rating";

export default {
  name: "RecordMovie",
  components: {
    AwesomeVueStarRating,
  },
  mounted() {
    this.setValueFromTmdb();

    this.getGenreNames();
  },
  data() {
    return {
      tmdbTitle: "",
      tmdbImgPath: null,
      tmdbReleaseDate: [],
      evaluation: 1,
      director: "",
      starrings: [],
      viewingDate: [],
      labelPosition: "on-border",
      genres: [],
      genreName: "",
      imgPath: null
    };
  },
  methods: {
    setValueFromTmdb() {
      if (this.$store.state.tmdb.title) {
        this.tmdbTitle = this.$store.state.tmdb.title;
      }

      if (this.$store.state.tmdb.imagePath) {
        this.tmdbImgPath = this.$store.state.tmdb.imagePath;
      }

      if (this.$store.state.tmdb.releaseDate) {
        this.tmdbReleaseDate.push(new Date(this.$store.state.tmdb.releaseDate));
      }
    },
    getGenreNames() {
      this.$axios
        .$get("api/v1/movies")
        .then((res) => {
          this.genres = res;
        })
        .catch((error) => {
          console.log(error);
        });
    },
  },
};
</script>

<style>
</style>

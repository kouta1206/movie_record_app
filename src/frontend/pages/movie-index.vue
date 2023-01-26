<template>
  <div>
    <div style="height: 20vh mx-5 my-5">
      <section class="mx-3 my-3 is-flex" style="">
        <div class="mr-5">
          <b-field
            label="映画タイトル"
            :label-position="labelPosition"
            grouped
            class="mb-5"
          >
            <b-input
              placeholder="Search..."
              type="search"
              v-model="title"
            ></b-input>
          </b-field>

          <b-field label="映画監督" :label-position="labelPosition" grouped>
            <b-input
              placeholder="Search..."
              type="search"
              v-model="director"
            ></b-input>
          </b-field>
        </div>
        <div class="mr-5 ml-5">
          <b-field label="主演名" :label-position="labelPosition" class="mb-5">
            <b-autocomplete
              rounded
              :data="['jQuery', 'Vue', 'React']"
              placeholder="e.g. jQuery"
              icon="magnify"
              clearable
              v-model="starring"
            >
              <template #empty>No results found</template>
            </b-autocomplete>
          </b-field>

          <div class="is-flex">
            <b-field label="視聴日から" :label-position="labelPosition">
              <b-datepicker
                placeholder="Click to select..."
                icon="calendar-today"
                trap-focus
                v-model="viewingAtFrom"
              >
              </b-datepicker>
            </b-field>
            <strong>~</strong>
            <b-field label="視聴日まで" :label-position="labelPosition">
              <b-datepicker
                v-model="viewingAtTo"
                placeholder="Click to select..."
                icon="calendar-today"
                trap-focus
              >
              </b-datepicker>
            </b-field>
          </div>
          <div></div>
        </div>
        <div class="ml-6">
          <b-field
            label="ジャンル"
            :label-position="labelPosition"
            class="mb-5"
          >
            <b-select placeholder="Select a subject" v-model="genreName">
              <option
                v-for="genre in genres"
                :value="genre.name"
                :key="genre.id"
              >
                {{ genre.name }}
              </option>
            </b-select>
          </b-field>

          <b-field label="リリース日" :label-position="labelPosition">
            <b-datepicker
              placeholder="Click to select..."
              icon="calendar-today"
              trap-focus
              v-model="releaseAt"
            >
            </b-datepicker>
          </b-field>
        </div>
      </section>
      <div class="is-flex is-justify-content-flex-end">
        <p class="control">
          <b-button
            class="button is-primary"
            style="width: 10vw"
            @click="searchMovies()"
            >検索</b-button
          >
        </p>
      </div>
    </div>
    <CommonTable :movieList="movieList" ref="commonTable" />
  </div>
</template>

<script>
import CommonTable from "../components/CommonTable.vue";
import moment from "moment";

export default {
  components: {
    CommonTable,
  },
  mounted() {
    // 検索条件初期化
    this.clearSearchParam();
    // マスターデータ取得
    this.getGenreNames();
    // 映画検索
    this.searchMovies();
  },
  data() {
    return {
      labelPosition: "on-border",
      title: "",
      director: "",
      starring: "",
      viewingAtFrom: [],
      viewingAtTo: [],
      releaseAt: null,
      genres: [],
      genreName: "",
      searchText: [],
      movieList: [],
    };
  },
  methods: {
    clearSearchParam() {
      this.viewingAtFrom = new Date();
      let afterSixMonth = moment().add(6, "months").format("YYYY-MM-DD");
      this.viewingAtTo = new Date(afterSixMonth);
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
    async searchMovies() {
      let params = this.setSearchParams();
      this.movieList = [];

      console.log(params);
      await this.$axios
        .$get("api/v1/movies/search", {
            params,
        })
        .then((res) => {
          console.log(res);
          this.movieList.push(...res);
        })
        .catch((error) => {
          console.log(error);
        });
    },
    setSearchParams() {
      let params = [];

      if (this.title) {
        params.push(["title", this.title]);
      }

      if (this.director) {
        params.push(["director", this.director]);
      }

      if (this.eveluation) {
        params.push(["evaluation", this.eveluation]);
      }

      if (this.starring) {
        params.push(["starring", this.starring]);
      }

      if (this.viewingAtFrom && this.viewingAtTo) {
        const viewingAtFrom = moment(this.viewingAtFrom).format("YYYY-MM-DD");
        params.push(["viewingAtFrom", viewingAtFrom]);
      }

      if (this.viewingAtFrom && this.viewingAtTo) {
        const viewingAtTo = moment(this.viewingAtTo).format("YYYY-MM-DD");
        params.push(["viewingAtTo", viewingAtTo]);
      }

      if (this.releaseAt) {
        const releaseAt = moment(this.releaseAt).format("YYYY-MM-DD");
        params.push(["releaseAt", releaseAt]);
      }

      if (this.genreName) {
        params.push(["genre", this.genreName]);
      }

      return Object.fromEntries(params);
    },
  },
  computed: {},
};
</script>

<style>
</style>

<template>
  <div style="width: 90vw">
    <div class="is-flex mx-6 my-6">
      <div>
        <figure class="image is-256x256">
          <img
            v-if="movieImgPath == null"
            style="width: 256px"
            height="256px"
            src="../assets/no_image.png"
          />
          <img v-else style="width: 256px" height="256px" :src="movieImgPath" />
        </figure>
      </div>
      <section class="ml-6">
        <div>
          <label
            style="
              font-weight: 600;
              color: #363636;
              font-size: calc(1rem * 0.75);
            "
            >映画タイトル</label
          >
          <b-input
            :value="movieTitle"
            v-model="movieTitle"
            icon="apps"
          ></b-input>
          <label
            class="typo__label"
            for="ajax"
            style="
              font-weight: 600;
              color: #363636;
              font-size: calc(1rem * 0.75);
            "
            >出演者</label
          >
          <b-taginput
            v-model="starrings"
            type="is-primary"
            :data="filteredStarrings"
            field="name"
            autocomplete
            :allow-new="true"
            icon="account"
            placeholder="出演者を選択"
            @typing="getFilteredStarrings"
          >
          </b-taginput>

          <div>
            <label
              class="typo__label"
              for="ajax"
              style="
                font-weight: 600;
                color: #363636;
                font-size: calc(1rem * 0.75);
              "
              >ジャンル</label
            >
            <div>
              <multiselect
                icon="account"
                v-model="selectedGenres"
                id="id"
                label="name"
                track-by="name"
                placeholder="ジャンルを選択"
                open-direction="bottom"
                :options="genreNames"
                :multiple="true"
                :searchable="true"
                :loading="isLoading"
                :internal-search="false"
                :clear-on-select="false"
                :close-on-select="false"
                :options-limit="300"
                :limit="3"
                :limit-text="limitText"
                :max-height="600"
                :show-no-results="false"
                :hide-selected="true"
                @search-change="asyncFindGenreNames()"
              >
                <template slot="tag" slot-scope="{ option, remove }"
                  ><span class="custom__tag"
                    ><span>{{ option.name }}</span
                    ><span class="custom__remove" @click="remove(option)"
                      >❌</span
                    ></span
                  ></template
                >
                <template slot="clear" slot-scope="props">
                  <div
                    class="multiselect__clear"
                    v-if="selectedGenres.length"
                    @mousedown.prevent.stop="clearAll(props.search)"
                  ></div> </template
                ><span slot="noResult"
                  >Oops! No elements found. Consider changing the search
                  query.</span
                >
              </multiselect>
            </div>
          </div>
        </div>
      </section>

      <section class="ml-6">
        <div>
          <label
            class="typo__label"
            for="ajax"
            style="
              font-weight: 600;
              color: #363636;
              font-size: calc(1rem * 0.75);
            "
            >映画監督</label
          >
          <b-autocomplete
            v-model="director"
            rounded
            placeholder="映画監督"
            icon="account"
            clearable
            @select="(option) => (selected = option)"
          >
            <template #empty>No results found</template>
          </b-autocomplete>

          <label
            class="typo__label"
            for="ajax"
            style="
              font-weight: 600;
              color: #363636;
              font-size: calc(1rem * 0.75);
            "
            >放送開始日</label
          >
          <b-datepicker
            placeholder="放送開始日を入力ください"
            icon="calendar-today"
            v-model="movieReleaseDate"
            trap-focus
          >
          </b-datepicker>

          <label
            class="typo__label"
            for="ajax"
            style="
              font-weight: 600;
              color: #363636;
              font-size: calc(1rem * 0.75);
            "
            >視聴日</label
          >
          <b-datepicker
            placeholder="視聴日を入力ください"
            icon="calendar-today"
            trap-focus
            v-model="viewingDate"
          >
          </b-datepicker>
        </div>
      </section>
      <div class="ml-6">
        <label
          style="font-weight: 600; color: #363636; font-size: calc(1rem * 0.75)"
          >評価</label
        >
        <star-rating
          v-model="evaluation"
          :rating="rating"
          :star-size="starSize"
          :show-rating="false"
        />
      </div>
    </div>
    <div class="buttons is-justify-content-flex-end mr-6 mb-3">
      <b-button type="is-primary" @click="editRecordMovie()"
        >映画を更新する</b-button
      >
    </div>

    <div style="text-align: center">
      <textarea-autosize
        style="width: 80vw"
        placeholder="レビューを入力してください....."
        ref="myTextarea"
        :min-height="200"
        v-model="review"
        :max-height="700"
      />
    </div>
  </div>
</template>

<script>
import Vue from "vue";
import Multiselect from "vue-multiselect";
import StarRating from "vue-star-rating";
import moment from "moment";
Vue.component("multiselect", Multiselect);
export default {
  middleware: ["unauthorized"],
  name: "RecordMovie",
  components: {
    Multiselect,
    StarRating,
  },
  mounted() {
    //   Vuexより編集映画情報があればセット
    this.setValueFromEditMovie();
    //　ジャンルマスタデータ取得
    this.asyncFindGenreNames();
    //  出演者マスタデータ取得
    this.asyncFindStarringNames();
  },
  data() {
    return {
      movieTitle: "",
      movieImgPath: null,
      movieReleaseDate: [],
      evaluation: null,
      rating: 0,
      review: "",
      starSize: 30,
      director: "",
      viewingDate: [],
      labelPosition: "on-border",
      imgPath: null,
      value: null,
      selectedGenres: [],
      genreNames: [],
      isLoading: false,
      starrings: [],
      starringNames: null,
      filteredStarrings: this.starringNames,
      isEditMode: false,
      movieId: null,
    };
  },
  methods: {
    limitText(count) {
      return `and ${count} other genreNames`;
    },
    setValueFromEditMovie() {
      if (!this.$store.state.edit.dataExists) {
        return;
      } else {
        this.isEditMode = this.$store.state.edit.dataExists;
      }
      if (this.$store.state.edit.id) {
        this.movieId = this.$store.state.edit.id;
      }
      if (this.$store.state.edit.title) {
        this.movieTitle = this.$store.state.edit.title;
      }
      if (this.$store.state.edit.director) {
        this.director = this.$store.state.edit.director;
      }
      if (this.$store.state.edit.img) {
        this.movieImgPath = this.$store.state.edit.img;
      }
      if (this.$store.state.edit.releaseDate) {
        this.movieReleaseDate = new Date(this.$store.state.edit.releaseDate);
      }
      if (this.$store.state.edit.genreName) {
        this.selectedGenres = this.$store.state.edit.genreName;
      }
      if (this.$store.state.edit.starringName) {
        this.starrings = this.$store.state.edit.starringName.map((starring => starring.name));
      }
      if (this.$store.state.edit.evaluation) {
        this.evaluation = this.$store.state.edit.evaluation;
      }
      if (this.$store.state.edit.viewingDate) {
        this.viewingDate = new Date(this.$store.state.edit.viewingDate);
      }
      if (this.$store.state.edit.review) {
        this.review = this.$store.state.edit.review;
      }
    },
    async asyncFindStarringNames() {
      await this.$axios
        .$get("api/v1/starrings")
        .then((res) => {
          this.starringNames = res;
        })
        .catch((error) => {});
    },
    async asyncFindGenreNames() {
      await this.$axios
        .$get("api/v1/genres")
        .then((res) => {
          this.genreNames = res;
        })
        .catch((error) => {});
    },
    clearAll() {
      this.selectedGenres = [];
    },
    getFilteredStarrings(text) {
      this.filteredStarrings = this.starringNames.filter((option) => {
        return (
          option.name.toString().toLowerCase().indexOf(text.toLowerCase()) >= 0
        );
      });
    },
    setEditMovieParams() {
      let movie = {};
      let starring = {};
      let genre = {};
      movie.title = this.movieTitle;

      movie.evaluation = this.evaluation;

      movie.image_path = this.movieImgPath;

      movie.director = this.director;

      const viewingDate = moment(this.viewingDate).format("YYYY-MM-DD");
      movie.viewing_at = viewingDate;

      const releaseDate = moment(this.movieReleaseDate).format("YYYY-MM-DD");
      movie.release_at = releaseDate;

      movie.review = this.review;

      starring.name = this.starrings.map((starring) => starring);

      genre.name = this.selectedGenres.map((genre) => genre.name);

      return { movie, starring, genre };
    },
    clearEditMovieVuex() {
      this.$store.commit("edit/setMovieId", null);
      this.$store.commit("edit/setMovieTitle", null);
      this.$store.commit("edit/setMovieDirector", null);
      this.$store.commit("edit/setMovieImg", null);
      this.$store.commit("edit/setGenreName", []);
      this.$store.commit("edit/setStarringName", []);
      this.$store.commit("edit/setMovieEvaluation", null);
      this.$store.commit("edit/setMovieReleaseDate", null);
      this.$store.commit("edit/setMovieViewingDate", null);
      this.$store.commit("edit/setMovieViewingDate", null);
      this.$store.commit("edit/setMovieReview", null);
      this.$store.commit("edit/setDataExists", false);
    },
    async editRecordMovie() {
      const params = this.setEditMovieParams();

      await this.$axios
        .$put(`api/v1/movies/${this.movieId}`, {
          ...params,
        })
        .then((res) => {
          if (res.status == 400) {
            this.showValidationDialog(res);
            return;
          }
          this.toasterOutput();
          this.clearEditMovieVuex();
          this.$router.push({
            name: "index-movie",
            path: "index-movie",
          });
        })
        .catch((error) => {});
    },
    toasterOutput() {
      this.$buefy.notification.open({
        message: `映画を登録しました`,
        type: "is-link",
        pauseOnHover: true,
        "auto-close": true,
        position: "is-bottom-right",
      });
    },
    showValidationDialog(res) {
      this.$buefy.dialog.confirm({
        title: "警告",
        message: `・${res.message.join("<br>・")}`,
        type: "is-danger",
        hasIcon: true,
      });
    },
  },
};
</script>

<style src="vue-multiselect/dist/vue-multiselect.min.css"></style>

<style scoped>
.custom__tag {
  display: inline-block;
  padding: 3px 12px;
  background: #d2d7ff;
  margin-right: 8px;
  margin-bottom: 8px;
  border-radius: 10px;
  cursor: pointer;
}
</style>

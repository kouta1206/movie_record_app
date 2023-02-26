<template>
  <div style="width: 90vw; padding: 35px;">
    <div class="is-flex mx-6 my-3">
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
        <div>
          <label
            style="
              font-weight: 600;
              color: #363636;
              font-size: calc(1rem * 0.75);
            "
            >映画タイトル</label
          >
          <b-input :value="tmdbTitle" v-model="tmdbTitle" icon="apps"></b-input>
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
            v-model="tmdbReleaseDate"
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
      <b-button  type="is-primary" @click="recordMovie()"
        >映画を登録する</b-button>
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
    //　Vuexよりtmdb情報をセット
    this.setValueFromTmdb();
    //　ジャンルマスタデータ取得
    this.asyncFindGenreNames();
    //  出演者マスタデータ取得
    this.asyncFindStarringNames();
  },
  data() {
    return {
      tmdbTitle: "",
      tmdbImgPath: null,
      tmdbReleaseDate: [],
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
    setValueFromTmdb() {
      if (this.$store.state.tmdb.title) {
        this.tmdbTitle = this.$store.state.tmdb.title;
      }
      if (this.$store.state.tmdb.imagePath) {
        this.tmdbImgPath = this.$store.state.tmdb.imagePath;
      }
      if (this.$store.state.tmdb.releaseDate) {
        this.tmdbReleaseDate = new Date(this.$store.state.tmdb.releaseDate);
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
    async recordMovie() {
      let params = this.setRecordMovieParams();
      await this.$axios
        .$post("api/v1/movies", {
          ...params,
        })
        .then((res) => {
          if (res.status == 400) {
            //バリデーションダイアログ
            this.showValidationDialog(res);
            return;
          }
          // トースタ出力
          this.toasterOutput();
          // リダイレクト
          this.$router.push({
            name: "index-movie",
            path: "index-movie",
          });
        })
        .catch((error) => {});
    },
    setRecordMovieParams() {
      let movie = {};
      let starring = {};
      let genre = {};

      movie.title = this.tmdbTitle;

      if (this.evaluation) {
        movie.evaluation = this.evaluation;
      }

      if (this.tmdbImgPath) {
        movie.image_path = this.tmdbImgPath;
      }

      if (this.director) {
        movie.director = this.director;
      }

      if (this.viewingDate) {
        const viewingDate = moment(this.viewingDate).format("YYYY-MM-DD");
        movie.viewing_at = viewingDate;
      }

      if (this.tmdbReleaseDate) {
        const releaseDate = moment(this.tmdbReleaseDate).format("YYYY-MM-DD");
        movie.release_at = releaseDate;
      }

      if (this.review) {
        movie.review = this.review;
      }

      if (this.starrings) {
        starring.name = this.starrings.map((starring) => starring.name);
      }

      if (this.selectedGenres) {
        genre.name = this.selectedGenres.map((genre) => genre.name);
      }
      return { movie, starring, genre };
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

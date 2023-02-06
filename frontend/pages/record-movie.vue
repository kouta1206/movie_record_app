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
        <div>
          <label
            style="
              font-weight: 600;
              color: #363636;
              font-size: calc(1rem * 0.75);
            "
            >映画タイトル</label
          >
          <b-input :value="tmdbTitle" v-model="tmdbTitle"></b-input>
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
          <!-- <b-taginput
            v-model="starrings"
            :value="['hoge', 'foo']"
            ellipsis
            icon="label"
            placeholder="出演者を入力下さい"
          >
          </b-taginput> -->
            <b-taginput
                v-model="starrings"
                :data="filteredTags"
                autocomplete
                :allow-new="true"
                :open-on-focus="openOnFocus"
                field="user.first_name"
                icon="label"
                placeholder="出演者を選択"
                @typing="getFilteredStarrings">
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
              <label class="typo__label" for="ajax">Async multiselect</label>
              <multiselect
                v-model="selectedGenres"
                id="id"
                label="name"
                track-by="name"
                placeholder="Type to search"
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
            :data="['jQuery', 'Vue', 'React']"
            placeholder="映画監督"
            icon="magnify"
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
          >
          </b-datepicker>
        </div>
      </section>
      <div class="ml-6">
        <label
          style="font-weight: 600; color: #363636; font-size: calc(1rem * 0.75)"
          >評価</label
        >
        <awesome-vue-starRating
          :star="evaluation"
          :hasresults="false"
          :hasdescription="false"
        />
      </div>
    </div>
    <b-button @click="recordMovie()">Click Me</b-button>

    <div style="text-align: center">
      <textarea-autosize
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
import Vue from "vue";
import Multiselect from "vue-multiselect";
import AwesomeVueStarRating from "awesome-vue-star-rating";
import moment from "moment";

Vue.component("multiselect", Multiselect);

export default {
  name: "RecordMovie",
  components: {
    AwesomeVueStarRating,
    Multiselect,
  },
  mounted() {
    this.setValueFromTmdb();
    this.asyncFindGenreNames();
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
      imgPath: null,
      value: null,
      selectedGenres: [],
      genreNames: [],
      isLoading: false,
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
        this.tmdbReleaseDate.push(new Date(this.$store.state.tmdb.releaseDate));
      }
    },
    asyncFindGenreNames() {
      this.$axios
        .$get("api/v1/movies")
        .then((res) => {
          this.genreNames = res;
        })
        .catch((error) => {
          console.log(error);
        });
    },
    clearAll() {
      this.selectedGenres = [];
    },
    getFilteredStarrings() {
    
    },
    recordMovie() {
      this.setRecordMovieParams();
      return;
      this.$axios
        .$post("api/v1/movies", {
          params,
        })
        .then((res) => {
          this.hogeToast();
          this.$router.push({
            name: "index-movie",
            path: "index-movie",
          });
        });
    },
    setRecordMovieParams() {
      let params = [];

      if (this.tmdbTitle) {
        params.push(["title", this.tmdbTitle]);
      }

      if (this.tmdbImgPath) {
        params.push(["image_path", this.tmdbImgPath]);
      }

      if (this.director) {
        params.push(["director", this.director]);
      }

      if (this.viewingDate) {
        const viewingDate = moment(this.viewingDate).format("YYYY-MM-DD");
        params.push(["viewing_at", viewingDate]);
      }

      if (this.tmdbReleaseDate) {
        params.push("release_at", this.tmdbReleaseDatef);
      }
    },
    hogeToast() {
      this.$buefy.notification.open("Clicked!!");
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

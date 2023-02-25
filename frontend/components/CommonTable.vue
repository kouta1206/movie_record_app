<template>
  <section style="width: 80vw;:">
    <br />
    <b-tabs>
      <b-tab-item label="Table">
        <b-table
          :loading="loading"
          paginated
          pagination-position="top"
          height="300"
          sort-multiple
          backend-sorting
          hoverable
          striped
          bordered
          :data="movieList"
          @sort="onSort"
          :default-sort-direction="defaultOrder"
          backend-pagination
          :per-page="perPage"
          :total="this.count"
          @page-change="onPageChange"
          aria-next-label="Next page"
          aria-previous-label="Previous page"
          aria-current-label="Current page"
          :selected.sync="selected"
          :s-row-selectable="showMovie()"
        >
          <b-table-column field="id" label="ID" sortable v-slot="movieList">
            {{ movieList.row.id }}
          </b-table-column>
          <b-table-column
            field="title"
            label="タイトル"
            sortable
            v-slot="movieList"
          >
            {{ movieList.row.title }}
          </b-table-column>
          <b-table-column
            field="director"
            label="監督"
            sortable
            v-slot="movieList"
          >
            {{ movieList.row.director }}</b-table-column
          >
          <b-table-column
            field="viewing_at"
            label="視聴日"
            sortable
            v-slot="movieList"
          >
            {{ movieList.row.viewing_at }}
          </b-table-column>
          <b-table-column
            field="release_at"
            label="リリース日"
            sortable
            v-slot="movieList"
          >
            {{ movieList.row.release_at }}
          </b-table-column>
        </b-table>
      </b-tab-item>
    </b-tabs>
  </section>
</template>

<script>
export default {
  props: {
    movieList: {
      required: false,
    },
    count: {
      required: false,
    },
  },
  data() {
    return {
      data: this.movieList,
      order: "",
      size: "",
      isSimple: false,
      isRounded: false,
      hasInput: false,
      prevIcon: "chevron-left",
      nextIcon: "chevron-right",
      inputPosition: "",
      defaultOrder: "asc",
      page: 2,
      perPage: 8,
      loading: false,
      selected: null,
    };
  },
  methods: {
    onSort(field, order) {
      this.$emit("onSort", field, order);
    },
    onPageChange(page) {
      this.$emit("onPageChange", page);
    },
    loadingUntilSyncData() {
      this.loading = true;
    },
    stopLoading() {
      this.loading = false;
    },
    showMovie() {
      if (this.selected == null) {
        return;
      }
      this.$router.push({
        name: 'show-movie',
        path: 'show-movie',
        query: {id: this.selected.id }
      });
      this.selected = null;
    },
  },
};
</script>

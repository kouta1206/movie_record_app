<template>
  <section style="width: 80vw;:">
    <br />
    <b-pagination
      :total="total"
      v-model="current"
      :range-before="rangeBefore"
      :range-after="rangeAfter"
      :order="order"
      :size="size"
      :simple="isSimple"
      :rounded="isRounded"
      :per-page="perPage"
      :icon-prev="prevIcon"
      :icon-next="nextIcon"
      aria-next-label="Next page"
      aria-previous-label="Previous page"
      aria-page-label="Page"
      aria-current-label="Current page"
      :page-input="hasInput"
      :page-input-position="inputPosition"
    >
    </b-pagination>

    <b-tabs>
      <b-tab-item label="Table">
        <b-table
          style="border: 1px solid"
          :data="movieList"
          :columns="columns"
          focusable
        >
        </b-table>
      </b-tab-item>
    </b-tabs>
  </section>
</template>

<script>
export default {
  created() {
    // console.log(...this.movieList)
    // console.log(...this.movieList)
    // this.data = [];
  },
  props: {
    movieList: {
      required: false,
    },
  },
  data() {
    return {
      total: 200,
      current: 10,
      perPage: 10,
      rangeBefore: 3,
      rangeAfter: 1,
      order: "",
      size: "",
      isSimple: false,
      isRounded: false,
      hasInput: false,
      prevIcon: "chevron-left",
      nextIcon: "chevron-right",
      inputPosition: "",
      columns: [
        {
          field: "id",
          label: "ID",
          width: "40",
          numeric: true,
        },
        {
          field: "title",
          label: "タイトル",
        },
        {
          field: "director",
          label: "監督",
        },
        {
          field: "viewing_at",
          label: "視聴日",
          centered: true,
        },
        {
          field: "release_at",
          label: "リリース日",
        },
      ],
    };
  },
};
</script>

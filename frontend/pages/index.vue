<template>
  <div class="container">
    <div class="section header-section over-width-container">
      <div class="header-title">
        <h1>今日から始まる映画がある毎日</h1>
        <h2>見た映画を記録して自分だけのポートフォリオを作成しよう！</h2>
      </div>
    </div>
    <div class="section">
      <div class="is-flex is-justify-content-space-between">
        <div>
          <img
            src="../assets/top-logo1.png"
            ratio="6by4"
            :rounded="rounded"
            style="width: 25vw"
          />
        </div>
        <div>
          <img
            src="../assets/top-logo2.png"
            ratio="6by4"
            :rounded="rounded"
            style="width: 25vw"
          />
        </div>
        <div>
          <img
            src="../assets/top-logo3.png"
            ratio="6by4"
            :rounded="rounded"
            style="width: 25vw"
          />
        </div>
      </div>
    </div>
    <div class="section">
      <carousel :perPage="6">
        <slide>
          <b-image
            src="https://www.themoviedb.org/t/p/w440_and_h660_face/h9gCsCXF4gzhs1ETX8jNxi5XKuR.jpg"
            ratio="6by4"
            style="width: 12vw; height: 300px"
          ></b-image>
        </slide>
        <slide>
          <b-image
            src="https://www.themoviedb.org/t/p/w440_and_h660_face/twUbb6Irktv0VEsJXQWJ3VKyxFX.jpg
"
            ratio="6by4"
            style="width: 12vw; height: 300px"
          ></b-image>
        </slide>
        <slide>
          <b-image
            src="https://www.themoviedb.org/t/p/w440_and_h660_face/8S6bv0xVYU4HojHD61yFF6EmYNK.jpg"
            ratio="6by4"
            style="width: 12vw; height: 300px"
          ></b-image>
        </slide>
        <slide>
          <b-image
            src="https://www.themoviedb.org/t/p/w440_and_h660_face/aN3BAlLEH5hAdZc74w5U8oUXkoq.jpg"
            ratio="6by4"
            style="width: 12vw; height: 300px"
          ></b-image>
        </slide>
        <slide>
          <b-image
            src="https://www.themoviedb.org/t/p/w440_and_h660_face/qi9r5xBgcc9KTxlOLjssEbDgO0J.jpg"
            ratio="6by4"
            style="width: 12vw; height: 300px"
          ></b-image>
        </slide>
        <slide>
          <b-image
            src="https://www.themoviedb.org/t/p/w440_and_h660_face/5v3grtPk3QSdjDP8ggpylA3hgIy.jpg"
            ratio="6by4"
            style="width: 12vw; height: 300px"
          ></b-image>
        </slide>
        <slide>
          <b-image
            src="https://www.themoviedb.org/t/p/w440_and_h660_face/mjcCywlptZo3R6bOTSRiiuxm2q4.jpg"
            ratio="6by4"
            style="width: 12vw; height: 300px"
          ></b-image>
        </slide>
      </carousel>
    </div>
    <footer class="footer over-width-container" style="background-color: black; color: #fff;">
      <div class="content has-text-centered">
        <p>
          <a href="">kouta hirao</a>. The source code is
          here
          <a href="https://github.com/kouta1206/movie_record_app">https://github.com/kouta1206/movie_record_app</a>. The
          website content is licensed
          <a href=""
            >CC BY KOUTA</a
          >.
        </p>
      </div>
    </footer>
  </div>
</template>

<script>
import Vue from "vue";
import { Carousel, Slide } from "vue-carousel";
Vue.component("carousel", Carousel);
Vue.component("slide", Slide);
export default {
  middleware: "logged-in-redirect",
  data() {
    return {
      rounded: true,
      progress: false,
      progressType: "is-primary",
    };
  },
};
</script>

<style>
.over-width-container {
  margin-right: calc(((100vw - 100%) / 2) * -1);
  margin-left: calc(((100vw - 100%) / 2) * -1);
}

.header-section {
  background-image: linear-gradient(
      to right top,
      rgba(19, 84, 122, 0.6),
      rgba(128, 208, 199, 0.9)
    ),
    url(../assets/top-background-image.jpg);
  background-position: center center;
  background-size: cover;
  height: 600px;
}

.header-title > h1 {
  color: #fff;
  text-align: center;
  font-size: 45px;
  margin-bottom: 10px;
}
.header-title {
  margin-top: 200px;
  color: #fff;
  text-align: center;
  font-family: "Times New Roman", Times, serif;
}
</style>

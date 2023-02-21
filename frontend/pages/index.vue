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
          <b-image
            src="https://picsum.photos/600/400"
            ratio="6by4"
            :rounded="rounded"
            style="width: 25vw"
          ></b-image>
        </div>
        <div>
          <b-image
            src="https://picsum.photos/600/400"
            ratio="6by4"
            :rounded="rounded"
            style="width: 25vw"
          ></b-image>
        </div>
        <div>
          <b-image
            src="https://picsum.photos/600/400"
            ratio="6by4"
            :rounded="rounded"
            style="width: 25vw"
          ></b-image>
        </div>
      </div>
    </div>
    <div class="section">
      <div class="example-component">
        <b-field grouped group-multiline>
          <b-field label="Type" label-position="on-border">
            <b-select v-model="progressType" :disabled="!progress">
              <option value="is-primary">is-primary</option>
              <option value="is-info">is-info</option>
              <option value="is-success">is-success</option>
              <option value="is-warning">is-warning</option>
              <option value="is-danger">is-danger</option>
              <option value="is-white">is-white</option>
              <option value="is-light">is-light</option>
              <option value="is-dark">is-dark</option>
            </b-select>
          </b-field>
        </b-field>
      </div>
      <div class="is-flex is-justify-content-space-between">
        <div>
          <b-carousel :progress="progress" :progress-type="progressType">
            <b-carousel-item v-for="(carousel, i) in carousels" :key="i">
              <section :class="`hero is-medium is-${carousel.color}`">
                <div class="hero-body has-text-centered">
                  <h1 class="title">{{ carousel.title }}</h1>
                </div>
              </section>
            </b-carousel-item>
          </b-carousel>
        </div>
        <div>
          <b-carousel :progress="progress" :progress-type="progressType">
            <b-carousel-item v-for="(carousel, i) in carousels" :key="i">
              <section :class="`hero is-medium is-${carousel.color}`">
                <div class="hero-body has-text-centered">
                  <h1 class="title">{{ carousel.title }}</h1>
                </div>
              </section>
            </b-carousel-item>
          </b-carousel>
        </div>
        <div>
          <b-carousel :progress="progress" :progress-type="progressType">
            <b-carousel-item v-for="(carousel, i) in carousels" :key="i">
              <section :class="`hero is-medium is-${carousel.color}`">
                <div class="hero-body has-text-centered">
                  <h1 class="title">{{ carousel.title }}</h1>
                </div>
              </section>
            </b-carousel-item>
          </b-carousel>
        </div>
        <div>
          <b-carousel :progress="progress" :progress-type="progressType">
            <b-carousel-item v-for="(carousel, i) in carousels" :key="i">
              <section :class="`hero is-medium is-${carousel.color}`">
                <div class="hero-body has-text-centered">
                  <h1 class="title">{{ carousel.title }}</h1>
                </div>
              </section>
            </b-carousel-item>
          </b-carousel>
        </div>
      </div>
    </div>
    <footer class="footer over-width-container">
      <div class="content has-text-centered">
        <p>
          <strong>Bulma</strong> by
          <a href="https://jgthms.com">Jeremy Thomas</a>. The source code is
          licensed
          <a href="http://opensource.org/licenses/mit-license.php">MIT</a>. The
          website content is licensed
          <a href="http://creativecommons.org/licenses/by-nc-sa/4.0/"
            >CC BY NC SA 4.0</a
          >.
        </p>
      </div>
    </footer>
  </div>
</template>

<script>
export default {
  data() {
    return {
      rounded: true,
      progress: false,
      progressType: "is-primary",
      carousels: [
        { title: "Slide 1", color: "grey" },
        { title: "Slide 2", color: "dark" },
        { title: "Slide 3", color: "primary" },
        { title: "Slide 4", color: "info" },
      ],
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
  font-family: 'Times New Roman', Times, serif;
}
</style>

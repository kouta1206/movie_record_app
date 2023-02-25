<template>
  <section class="sidebar-layout">
    <b-sidebar
      position="static"
      :fullheight="fullheight"
      :mobile="mobile"
      :expand-on-hover="expandOnHover"
      :reduce="reduce"
      :delay="expandWithDelay ? 500 : null"
      type="is-light"
      open
    >
      <div class="p-1">
        <div class="block"></div>
        <b-menu class="is-custom-mobile">
          <b-menu-list label="Menu">
            <b-menu-item active icon="account" expanded label="映画リスト">
              <b-menu-item
                icon="cellphone-link"
                label="トップページ"
                tag="nuxt-link"
                to="/index-movie"
              ></b-menu-item>
              <b-menu-item
                icon="cellphone-link"
                label="登録映画を検索する"
                tag="nuxt-link"
                to="/search-tmdb"
              ></b-menu-item>
              <b-menu-item
                icon="movie-edit"
                label="映画を登録する"
                tag="nuxt-link"
                to="/record-movie"
              ></b-menu-item>
            </b-menu-item>
            <b-menu-item icon="account" label="飲食リスト(開発中)" disabled>
              <b-menu-item
                icon="account-box"
                label="インデックスページ"
              ></b-menu-item>
              <b-menu-item
                icon="home-account"
                label="飲食店登録する"
              ></b-menu-item>
            </b-menu-item>
            <b-menu-item icon="account" label="本リスト(開発中)" disabled>
              <b-menu-item
                icon="account-box"
                label="インデックスページ"
              ></b-menu-item>
              <b-menu-item
                icon="home-account"
                label="本を登録する"
              ></b-menu-item>
            </b-menu-item>
          </b-menu-list>
          <b-menu-list>
            <b-menu-item label="マイページ" icon="link"></b-menu-item>
          </b-menu-list>
          <b-menu-list label="Actions">
            <b-menu-item
              icon="logout"
              label="ログアウト"
              @click="logout()"
            ></b-menu-item>
          </b-menu-list>
        </b-menu>
      </div>
        <b-loading :is-full-page="isFullPage" v-model="isLoading" :can-cancel="true"></b-loading>
    </b-sidebar>
  </section>
</template>

<script>
export default {
  data() {
    return {
      isLoading: false,
      isFullPage: true,
      expandOnHover: true,
      expandWithDelay: false,
      mobile: "hidden",
      reduce: true,
      fullheight: true,
    };
  },
  methods: {
    async logout() {
      this.isLoading = true;
      await this.$auth.logout();
       this.$router.push({
         redirect: "/login",
        path: "/login"
      });
      this.isLoading = false;
    },
  },
};
</script>
<style lang="scss">
.p-1 {
  padding: 1em;
  height: 93.5vh;
  box-sizing: border-box;
}
.sidebar-page {
  display: flex;
  flex-direction: column;
  width: 100%;
  min-height: 100%;
  // min-height: 100vh;
  .sidebar-layout {
    display: flex;
    flex-direction: row;
    min-height: 100%;
    // min-height: 100vh;
  }
}
@media screen and (max-width: 1023px) {
  .b-sidebar {
    .sidebar-content {
      &.is-mini-mobile {
        &:not(.is-mini-expand),
        &.is-mini-expand:not(:hover):not(.is-mini-delayed) {
          .menu-list {
            li {
              a {
                span:nth-child(2) {
                  display: none;
                }
              }
              ul {
                padding-left: 0;
                li {
                  a {
                    display: inline-block;
                  }
                }
              }
            }
          }
          .menu-label:not(:last-child) {
            margin-bottom: 0;
          }
        }
      }
    }
  }
}
@media screen and (min-width: 1024px) {
  .b-sidebar {
    .sidebar-content {
      &.is-mini {
        &:not(.is-mini-expand),
        &.is-mini-expand:not(:hover):not(.is-mini-delayed) {
          .menu-list {
            li {
              a {
                span:nth-child(2) {
                  display: none;
                }
              }
              ul {
                padding-left: 0;
                li {
                  a {
                    display: inline-block;
                  }
                }
              }
            }
          }
          .menu-label:not(:last-child) {
            margin-bottom: 0;
          }
        }
      }
    }
  }
}
.is-mini-expand {
  .menu-list a {
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
  }
}
</style>

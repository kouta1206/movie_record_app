export const state =  {
  title: null,
  imagePath: null,
  releaseDate: null
}


export const mutations = {
  setTmdbTitle (state, payload) {
    state.title = payload
  },
  setTmdbImagePath (state, payload) {
    state.imagePath = payload
  },
  setTmdbReleaseDate (state, payload) {
    state.releaseDate = payload
  },
}

export const actions = {
  getTmdbTitle ({ commit }, title) {
    commit('setTmdbTitle', title)
  },
  getTmdbImagePath ({ commit }, imagePath) {
    commit('setTmdbImagePath', imagePath)
  },
  getTmdbReleaseDate ({ commit }, releaseDate) {
    commit('setTmdbReleaseDate', releaseDate)
  },
}

export default  {
  state,
  mutations,
  actions
}

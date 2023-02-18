
export const state =  {
  dataExists: false,
  title: null,
  director: null,
  img: null,
  genreName: [],
  starringName: [],
  evaluation: null,
  releaseDate: null,
  viewingDate: null,
  review: null,
}


export const mutations = {
  setMovieTitle (state, payload) {
    state.title = payload
  },
  setMovieDirector (state, payload) {
    state.director = payload
  },
  setMovieImg (state, payload) {
    state.img = payload
  },
  setGenreName (state, payload) {
    state.genreName = [...payload]
    console.log(state.genreName)
  },
  setStarringName (state, payload) {
    state.starringName = [...payload]
  },
  setMovieEvaluation (state, payload) {
    state.evaluation = payload
  },
  setMovieReleaseDate (state, payload) {
    state.releaseDate = payload
  },
  setMovieViewingDate (state, payload) {
    state.viewingDate = payload
  },
  setMovieReview (state, payload) {
    state.review = payload
  },
  setDataExists(state, payload) {
    state.dataExists = payload
  },
}

export default  {
  state,
  mutations,
}
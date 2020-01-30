export const state = () => ({
  message: ''
})

export const getters = {}

export const mutations = {
  setMessage(state, message) {
    state.message = message
  }
}

export const actions = {
  async fetchMessage({ commit }, params = {}) {
    const { message } = await this.$axios.$get('api/hello', { params })
    commit('setMessage', message)
  }
}

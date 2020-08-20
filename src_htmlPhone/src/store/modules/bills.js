import PhoneAPI from './../../PhoneAPI'

const state = {
  bills: [],
  receipts: []
}

const getters = {
  bills: ({ bills }) => bills
}

const actions = {
  payBill (context, {id}) {
    PhoneAPI.payBill(id)
  },
  sendBill (context, {id, number, amount}) {
    PhoneAPI.sendBill(id, number, amount)
  },
  reset ({ commit }) {
    commit('SET_BILLS', [])
    commit('SET_RECEIPTS', [])
  }
}

const mutations = {
  SET_BILLS (state, bills) {
    state.bills = bills
  },
  SET_RECEIPTS (state, receipts) {
    state.receipts = receipts
  }
}

export default {
  state,
  getters,
  actions,
  mutations
}

if (process.env.NODE_ENV !== 'production') {
  // eslint-disable-next-line
  state.bills = [{
    id: 2,
    sender: '336-4557',
    target: '336-4552',
    label: 'Apples',
    amount: 200
  },
  {
    id: 3,
    sender: '336-4557',
    target: '336-4552',
    label: 'Oranges',
    amount: 500
  }]
}

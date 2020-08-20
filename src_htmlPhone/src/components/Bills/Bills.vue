<template>
  <div class="bills">
    <list :list='billsList' :disable="disableList" :title="IntlString('APP_BILLS_BILLS_TITLE')" @back="back" @select='onSelect' @option='onOption'></list>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'

import List from './../List.vue'
import Modal from '@/components/Modal/index.js'

export default {
  components: {
    List
  },
  data () {
    return {
      disableList: false
    }
  },
  computed: {
    ...mapGetters(['IntlString', 'bills', 'useMouse']),
    billsList () { return this.bills.map(b => ({ ...b, display: `${b.label} $${b.amount}` })) }
  },
  methods: {
    ...mapActions(['payBill']),
    onSelect (bill) {
      this.$router.push({ name: 'bills.bills.view', params: { id: bill.id } })
    },
    onOption (bill) {
      if (!bill || !bill.id) return
      this.disableList = true
      Modal.CreateModal({
        choix: [
          {id: 'pay', title: `${this.IntlString('APP_BILLS_PAY')} ($${bill.amount})`, icons: 'fa-circle-o', color: 'green'},
          {id: -1, title: 'Cancel', icons: 'fa-undo'}
        ]
      }).then(selection => {
        if (selection.id === 'pay') {
          this.payBill({ id: bill.id })
        }
        this.disableList = false
      })
    },
    back () {
      if (this.disableList === true) return
      this.$router.push({ name: 'home' })
    }
  },
  created () {
    if (!this.useMouse) {
      this.$bus.$on('keyUpBackspace', this.back)
    }
  },

  beforeDestroy () {
    this.$bus.$off('keyUpBackspace', this.back)
  }
}
</script>

<style scoped>
.bills{
  position: relative;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
}
</style>

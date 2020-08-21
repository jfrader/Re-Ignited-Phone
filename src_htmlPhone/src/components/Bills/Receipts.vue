<template>
  <div class="receipts">
    <list :list='receiptsList' :disable="disableList" :title="IntlString('APP_BILLS_BILLS_TITLE')" @back="back" @select='onSelect'></list>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

import List from './../List.vue'

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
    ...mapGetters(['IntlString', 'receipts', 'useMouse']),
    receiptsList () {
      return [
        {
          id: 'goToBills',
          display: this.IntlString('APP_BILLS_GO_TO_BILLS'),
          icon: '/html/static/img/bills/bill.png'
        },
        ...this.receipts.map(b => ({ ...b, display: `${b.label} $${b.amount}` }))
      ]
    }
  },
  methods: {
    onSelect (receipt) {
      if (receipt.id === 'goToBills') return this.$router.push({ name: 'bills.bills' })
      this.$router.push({ name: 'bills.receipts.view', params: { id: receipt.id } })
    },
    back () {
      if (this.disableList === true) return
      this.$router.push({ name: 'bills.bills' })
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
.receipts{
  position: relative;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
}
</style>

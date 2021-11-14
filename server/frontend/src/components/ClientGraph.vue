<template>
<div class="col-md-12">
  <p>Clients Server Representation</p>
</div>
</template>

<script>
export default {
  name: "ClientGraph",
  data() {
    return {
      networkGraph: ''
    }
  },
  created() {
    this.fetchAll()
  },
  methods: {
    fetchAll() {
      this.fetchGraph()
    },
    fetchGraph() {

    }
  }
}
</script>

<style scoped>

</style>
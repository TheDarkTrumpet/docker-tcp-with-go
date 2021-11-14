<template>
<div class="col-md-12">
  <p>Clients Server Representation</p>
  <network class="network-graph" ref="clients" :nodes="nodes" :edges="edges"> </network>
</div>
</template>

<script>

export default {
  name: "ClientGraph",
  data() {
    return {
      nodes: [
        { id: 1, label: 'Node 1' },
        { id: 2, label: 'Node 2' },
        { id: 3, label: 'Node 3' },
        { id: 4, label: 'Node 4' },
        { id: 5, label: 'Node 5' },
      ],
      edges: [
        { id: 1, from: 1, to: 3 },
        { id: 2, from: 1, to: 2 },
        { id: 3, from: 2, to: 4 },
        { id: 4, from: 2, to: 5 },
        { id: 5, from: 3, to: 3 },
      ],
      options: {
        nodes: {
          shape: 'circle',
        },
        height: 800,
        }
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
.network-graph {
  height: 800px;
}
</style>
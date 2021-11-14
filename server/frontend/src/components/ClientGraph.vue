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
      status: "",
      nodes: [],
      edges: [],
      options: {
        nodes: {
          shape: 'circle',
        },
      }
    }
  },
  created() {
    this.fetchAll()
    this.timer = setInterval(this.fetchAll, 3000)
  },
  methods: {
    fetchAll() {
      this.fetchGraph()
    },
    fetchGraph() {
      fetch("http://localhost:8081/api/getClients")
          .then( async response => {
            const data = await response.json();
            console.log(data)
            if (Object.keys(data).length > 0) {
              console.log("Length is larger than 0")
              this.nodes = data["Nodes"]
              this.edges = data["Edges"]
            } else {
              this.status = "<p>No Logs Received, as of yet</p>"
            }
          }, () => {
            this.status = "<p>Server is unresponsive, did the API endpoint get launched?</p>"
            return
          }).catch( () => { })
    }
  }
}
</script>

<style scoped>
.network-graph {
  height: 600px;
}
</style>
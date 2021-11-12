<template>
  <div class="col-md-12">
    <p class="logs-header">Recent Logs from Server Process</p>
    <div class="logs-body" v-html="Logs">
    </div>
  </div>
</template>

<script>

export default {
  name: "ClientLogs",
  data() {
    return {
      Logs: ''
    }
  },
  created() {
    this.fetchAll()
    this.timer = setInterval(this.fetchAll, 3000)
  },
  methods: {
    fetchAll() {
      this.fetchLogs()
    },
    fetchLogs() {
      this.$http.get("http://localhost:8081/api/getLogs?" + Math.random()).then( response => {
        console.log(response.status)
        if (response.data.length > 0) {
          this.Logs = response.data.map(v => `<p>${v}</p>`).join('\n')
        } else {
          this.Logs = "<p>No Logs Received, as of yet</p>"
        }
      }, () => {
        this.Logs = "<p>Server is unresponsive, did the API endpoint get launched?</p>"
        return
      }).catch(() => {})
    }
  }
}
</script>

<style scoped>
.logs-header {
  font-weight: bold;
  font-size: 14px;
  text-align: left;
  padding-left: 10px;
}
.logs-body {
  text-align: left;
  padding-left: 20px;
}
</style>
<template>
  <div class="col-lg-12 row">
    <b-tabs content-class="mt-3">
      <b-tab title="Network Graph" active>
        <ClientGraph />
      </b-tab>
      <b-tab title="Logs">
        <ClientLogs />
      </b-tab>
    </b-tabs>
  </div>
</template>

<script>
import ClientGraph from "@/components/ClientGraph";
import ClientLogs from "@/components/ClientLogs";

export default {
  name: "ClientInfo",
  components: {
    ClientGraph,
    ClientLogs
  }
}
</script>

<style scoped>
</style>
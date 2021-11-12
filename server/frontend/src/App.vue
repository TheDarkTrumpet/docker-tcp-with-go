<template>
  <div id="app">
    <div class="col-lg-12 row">
      <h1>Client/Server Connection Status Screen</h1>
      <ClientInfo />
    </div>
  </div>
</template>

<script>

import ClientInfo from "@/components/ClientInfo";

export default {
  name: 'App',
  components: {
    ClientInfo
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>

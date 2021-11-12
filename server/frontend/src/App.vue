<template>
  <div id="app">
    <div class="col-lg-12 row">
      <h1>Client/Server Connection Status Screen</h1>
    </div>
    <div class="col-lg-12 row">
      <b-tabs content-class="mt-3">
        <b-tab title="Network Graph" active><p>Network Graph</p></b-tab>
        <b-tab title="Logs"><p>Logs</p></b-tab>
      </b-tabs>
    </div>
  </div>
</template>

<script>
export default {
  name: 'App',
  components: {

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

import Vue from 'vue'
import App from './App.vue'
import {BootstrapVue, IconsPlugin } from "bootstrap-vue"
import { DropdownPlugin, TablePlugin, NavbarPlugin, LayoutPlugin } from 'bootstrap-vue'
import { CardPlugin }  from 'bootstrap-vue'
import VueResource from 'vue-resource'

import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'

Vue.use(BootstrapVue)
Vue.use(IconsPlugin)
Vue.use(DropdownPlugin)
Vue.use(TablePlugin)
Vue.use(NavbarPlugin)
Vue.use(LayoutPlugin)
Vue.use(CardPlugin)
Vue.use(VueResource)


import { Network } from 'vue-visjs'
Vue.component('network', Network)

Vue.config.productionTip = false
Vue.prototype.$apiURL = 'http://localhost:8081/api'

new Vue({
  render: h => h(App),
}).$mount('#app')

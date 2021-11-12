import Vue from 'vue'
import App from './App.vue'
import {BootstrapVue, IconsPlugin } from "bootstrap-vue"
import { DropdownPlugin, TablePlugin, NavbarPlugin, LayoutPlugin } from 'bootstrap-vue'
import { CardPlugin }  from 'bootstrap-vue'
import VueResource from 'vue-resource'

Vue.config.productionTip = false

Vue.use(BootstrapVue)
Vue.use(IconsPlugin)
Vue.use(DropdownPlugin)
Vue.use(TablePlugin)
Vue.use(NavbarPlugin)
Vue.use(LayoutPlugin)
Vue.use(CardPlugin)
Vue.use(VueResource)

new Vue({
  render: h => h(App),
}).$mount('#app')

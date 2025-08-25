import './assets/main.scss'

import { createApp } from 'vue'
import App from './App.vue'
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'
import { library } from '@fortawesome/fontawesome-svg-core'
import { fas } from '@fortawesome/free-solid-svg-icons'
import FloatingVue from 'floating-vue'

library.add(fas)

createApp(App).use(FloatingVue).component('fas', FontAwesomeIcon).mount('#app')

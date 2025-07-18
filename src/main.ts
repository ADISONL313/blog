import { createPinia } from 'pinia'
import { createApp } from 'vue'
import '@/assets/css/cssConfig.css'
import '@wangeditor/editor/dist/css/style.css'
import piniaPluginPersistedstate from 'pinia-plugin-persistedstate';
import App from './App.vue'
import router from './router'
import ElementPlus from 'element-plus'
// 如果您正在使用CDN引入，请删除下面一行。
import * as ElementPlusIconsVue from '@element-plus/icons-vue'
import 'element-plus/dist/index.css'
const pinia = createPinia()
pinia.use(piniaPluginPersistedstate)
// main.ts


const app = createApp(App)

for (const [key, component] of Object.entries(ElementPlusIconsVue)) {
    app.component(key, component)
}
app.use(createPinia())
app.use(router)
app.use(ElementPlus)
app.mount('#app')

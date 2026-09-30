import { createRouter, createWebHistory } from 'vue-router'
import ShortenerView from '@/views/ShortenerView.vue'
import DashboardView from '@/views/DashboardView.vue'

const router = createRouter({
  history: createWebHistory('/'),
  routes: [
    { path: '/', name: 'shortener', component: ShortenerView },
    { path: '/dashboard', name: 'dashboard', component: DashboardView },
  ],
})

export default router

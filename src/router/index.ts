import { createRouter, createWebHistory } from 'vue-router'
import homeView from '@/views/universal/homeView.vue'
const mail = sessionStorage.getItem('mail')
const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      redirect: '/home',
    },
    {
      path: '/signIn',
      name: 'signIn',
      component: () => import('@/views/normalUser/sign/signInView.vue'),
    },
    {
      path: '/signUp',
      name: 'signUp',
      component: () => import('@/views/normalUser/sign/signUpView.vue'),
    }, {
      path: '/adminSignIn',
      component: () => import('@/components/administrator/sign/adminSiginInComponent.vue')
    },
    {
      path: '/home',
      name: 'home',
      redirect: sessionStorage.getItem('mail') === 'admin' ? '/home/charts' : '/home/blogList',
      component: homeView,
      children: [
        {
          path: 'blogList',
          component: () => import('@/views/normalUser/blog/blogListView.vue'),
        },
        {
          path: 'userCenter',
          component: () => import('@/views/normalUser/user/userCenterView.vue'),
        },
        {
          path: 'releaseBlog',
          name: 'releaseBlog',
          component: () => import('@/components/normalUser/blog/realeseBlogComponent.vue'),
        },
        {
          path: 'adminBlog',
          name: 'adminBlog',
          component: () => import('@/views/universal/adminBlogView.vue')
        },
        {
          path: 'updateBlog',
          name: 'updateBlog',
          component: () => import('@/views/universal/updateBlogView.vue')
        },
        {
          path: 'blogDetail',
          component: () => import('@/views/normalUser/blog/blogDetailView.vue')
        },
        {
          path: 'adminCategory',
          component: () => import('@/views/administrator/category/adminCategoryView.vue')
        },
        {
          path: 'adminTag',
          component: () => import('@/views/administrator/tag/adminTagView.vue')
        },
        {
          path: 'adminComment',
          component: () => import('@/views/administrator/blog/adminCommentView.vue')
        },
        {
          path: 'adminDraft',
          component: () => import('@/views/normalUser/blog/adminDraftView.vue')
        },
        {
          path: 'blogViewRecord',
          component: () => import('@/views/normalUser/blog/adminBlogViewRecordView.vue')
        },
        {
          path: 'adminLike',
          component: () => import('@/views/normalUser/blog/adminLikeView.vue')
        },
        {
          path: 'adminLog',
          component: () => import('@/views/administrator/log/adminLogView.vue')
        },
        {
          path: 'charts',
          component: () => import('@/views/administrator/charts/chartsView.vue')
        },
        {
          path: 'message',
          component: () => import('@/views/universal/messageCenterView.vue')
        },
        {
          path: 'about',
          component: () => import('@/components/universal/aboutMyWeb.vue')
        }
      ]
    }
  ],
})
const publicRotes = ['/home', '/signUp', '/signIn', '/home/blogList', '/adminSignIn', '/home/blogDetail', '/home/about']
router.beforeEach((to, from, next) => {
  const isLoggedIn = sessionStorage.getItem('token') !== null;
  if (!isLoggedIn && !publicRotes.includes(to.path)) {
    alert('请登录')
    next('/signIn');
  } else {
    next();
  }
})
export default router

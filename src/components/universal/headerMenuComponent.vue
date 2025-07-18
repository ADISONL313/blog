<template>
    <el-menu v-if="mail !== 'admin'" :default-active="activeIndex" class="neomorphic-header el-menu-demo"
        mode="horizontal" :ellipsis="false" @select="handleSelect" text-color="#303133" active-text-color="#000000">

        <el-menu-item index="0">
            <h2 @click="router.push('/home/blogList')">blog</h2>
        </el-menu-item>
        <el-menu-item index="1" @click="router.push('/home/message')">消息中心</el-menu-item>
        <el-menu-item index="2" @click="router.push('/home/releaseBlog')">写博客</el-menu-item>
        <el-menu-item index="3" @click="router.push('/home/adminLike')">我的喜欢</el-menu-item>
        <el-menu-item index="4" @click="router.push('/home/blogViewRecord')">浏览记录</el-menu-item>
        <el-menu-item index="5" @click="router.push('/home/admincomment')">我的评论</el-menu-item>
        <el-menu-item index="6" @click="router.push('/home/adminDraft')">草稿箱</el-menu-item>
        <el-menu-item index="7" @click="router.push('/home/adminBlog')">我的博客</el-menu-item>
        <el-menu-item index="8" @click="router.push('/home/userCenter')">{{ nickname }}</el-menu-item>
        <el-menu-item index="9" @click="router.push('/home/about')">关于网站</el-menu-item>
    </el-menu>

    <el-menu v-if="mail === 'admin'" style="background-color: #909399;" :default-active="activeIndex"
        class="neomorphic-header el-menu-demo" mode="horizontal" :ellipsis="false" @select="handleSelect"
        text-color="#303133" active-text-color="#000000">

        <el-menu-item index="0" @click="router.push('/home/charts')">
            <h2>blog</h2>
        </el-menu-item>
        <el-menu-item index="1" @click="router.push('/home/admincomment')">评论管理</el-menu-item>
        <el-menu-item index="2" @click="router.push('/home/adminCategory')">分类管理</el-menu-item>
        <el-menu-item index="3" @click="router.push('/home/adminTag')">标签管理</el-menu-item>
        <el-menu-item index="5" @click="router.push('/home/adminBlog')">博客管理</el-menu-item>
        <el-menu-item index="6" @click="router.push('/home/adminLog')">日志管理</el-menu-item>
        <el-menu-item index="7" @click="router.push('/home/userCenter')">{{ nickname }}</el-menu-item>
        <el-menu-item index="9" @click="router.push('/home/about')">关于网站</el-menu-item>
    </el-menu>
</template>

<script lang="ts" setup>
// 保持原有TS代码不变
import { getBlogRecommendAPI } from '@/api/getAPI'
import { onMounted, ref } from 'vue'
const nickname = sessionStorage.getItem('nickname')
const activeIndex = ref('0')
const handleSelect = (key: string, keyPath: string[]) => {
    console.log(key, keyPath)
}
const mail = sessionStorage.getItem('mail')
import { useRouter } from 'vue-router'
const router = useRouter()
</script>
<style scoped>
/* 毛玻璃菜单（保持原有透明度和模糊度） */
.neomorphic-header {
    background: rgba(255, 255, 255, 0.1);
    backdrop-filter: blur(2px);
}

/* 优化选中状态颜色（核心修改部分） */
.neomorphic-header .is-active {
    /* 深灰色选中色（比背景色深约30%） */
    color: rgba(0, 0, 0, 0.6) !important;
    font-weight: 500;
    /* 轻微加粗 */
    text-shadow:
        0 0 1px rgba(0, 0, 0, 0.2),
        /* 极微弱外发光 */
        0 1px 1px rgba(255, 255, 255, 0.7);
    /* 保留内发光 */
    background: transparent;
    /* 取消背景色 */
}

/* 其他样式保持原有优化 */
/* 优化文字阴影（更柔和） */
.neomorphic-header h2,
.neomorphic-header .el-menu-item {
    text-shadow:
        0 0 4px #606266,
        0 1px 1px #3a3b3e;
}

/* 鼠标悬停效果（弱化背景变化，强化光影） */
.neomorphic-header .el-menu-item:not(.is-active):hover {
    color: #000000;
    text-shadow:
        0 0 4px #606266,
        0 1px 1px #909399;
    background: transparent;
}

.el-menu-item {
    font-size: large;
    font-weight: bolder;
}

h2 {
    font-size: larger;
    font-weight: bolder;
}

/* 动画曲线优化 */
.neomorphic-header h2,
.neomorphic-header .el-menu-item {
    transition: all 0.3s ease-out;
}

.el-menu--horizontal>.el-menu-item:nth-child(1) {
    margin-right: auto;
    border-bottom: none;
}

.el-menu--horizontal.el-menu {
    border: none;
}

.el-menu--horizontal .el-menu-item:not(.is-disabled):focus,
.el-menu--horizontal .el-menu-item:not(.is-disabled):hover {
    background: rgba(255, 255, 255, 0.1);
    backdrop-filter: blur(10px);
}
</style>
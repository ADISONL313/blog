<template>
    <div class="zhezhao">
        <div class="blog-container" v-for="blog in blogList">
            <div class="blog-item" @click="goDetail(blog)">
                <div class="blog-userInfo">
                    <el-row>
                        <el-col :span="12" class="user-head">
                            <img class="user-photo"
                                :src="'http://47.108.29.91:9000/bloguser/' + blog.userId + '/' + blog.photo" /><span
                                class="user-nickname">{{ blog.nickname }}</span>
                        </el-col>
                        <el-col :span="12" style="text-align: right;" class="blog-createdAt"><el-icon>
                                <Timer />
                            </el-icon>{{ blog.createdAt }}</el-col>
                    </el-row>
                </div>
                <div class="blog-title">{{ blog.title }}</div>
                <div class="blog-summary">{{ blog.summary }}</div>
                <div class="tag-list">
                    <el-tag v-for="tag in blog.tags" :style="`background-color:${tag.color};`">{{ tag.name
                    }}</el-tag>
                </div>
                <div class="blog-info">
                    <el-row>
                        <el-col :span="12" class="blog-likes">❤{{ blog.likes }}</el-col>
                        <el-col :span="12" class="blog-views"><el-icon>
                                <Pointer />
                            </el-icon>{{ blog.views }}</el-col>
                    </el-row>
                </div>
                <div class="book-marker">
                    <el-icon style="color: white;">
                        <ToiletPaper />
                    </el-icon>{{ blog.name }}
                </div>
            </div>
        </div>

        <div class="search-container">
            <el-form @submit.prevent>
                <el-form-item>
                    <input class="transparentInput" style="width: 40vh;" @change="search" v-model="searchKey"
                        placeholder="搜索标题/内容/分类/标签">

                    </input>
                </el-form-item>
            </el-form>
        </div>
    </div>

</template>
<script lang="ts" setup>
import likeComponent from './likeComponent.vue';
import { ref, onMounted } from 'vue'
import { getBlogAPI, getBlogRecommendAPI } from '@/api/getAPI';
interface BlogTag {
    name: string;
    color: string;
}
interface Blog {
    userId: string | number;
    photo: string;
    nickname: string;
    createdAt: string;
    title: string;
    summary: string;
    tags: BlogTag[];
    likes: number;
    views: number;
    name: string;
    blogId: string | number;
}
const blogList = ref<Blog[]>([])
const baseUrl = 'http://47.108.29.91:9000/blog/'

const setBlogList = async (data: any) => {
    const res = await getBlogAPI(data)
    blogList.value = res
    console.log(res)
}
onMounted(async () => {
    const mail = sessionStorage.getItem('mail')
    if (mail !== null) {
        blogList.value = await getBlogRecommendAPI(mail + '')
    } else {
        await setBlogList({ status: 1 })
    }
})
import { useRouter } from 'vue-router';
const router = useRouter()
import { useBlogStore } from '@/stores/blogStore';
import { storeToRefs } from 'pinia';
import { addBlogViewRecordAPI, getUserBehaviorAPI, likeBlogAPI } from '@/api/postAPI';
const blogStore = useBlogStore()
const { blog } = storeToRefs(blogStore)
const goDetail = (blogData: any) => {
    const isLoggedIn = sessionStorage.getItem('token') !== null;
    blog.value = blogData
    console.log(isLoggedIn)
    if (isLoggedIn) {
        addBlogViewRecordAPI({
            mail: sessionStorage.getItem('mail'),
            blogId: blogData.blogId
        })
    }
    if (sessionStorage.getItem('mail') !== null) {
        getUserBehaviorAPI({ mail: sessionStorage.getItem('mail'), blogId: blogData.blogId })

    }
    router.push({
        path: '/home/blogDetail',
        query: {
            blogId: blogData.blogId
        }
    })
}
const searchKey = ref('')
const search = async () => {
    await setBlogList({ searchKey: searchKey.value, status: '1' })
}
</script>
<style scoped>
:root {
    --container-padding-mobile: 40px;
    --container-padding-tablet: 80px;
    --container-padding-desktop: 120px;
    --container-padding-large: 160px;
}

/* 全局容器样式 */
.search-container {
    padding: 20px;
    background: rgba(255, 255, 255, 0);
    border-bottom: 1px solid #e9ecef;
    margin-bottom: 24px;
    position: fixed;
    top: 60px;
    left: 0;
    right: 0;
    justify-items: left;
    border: none;
}

.transparentInput {
    /* 基础样式 */
    width: 40vh;
    height: 48px;
    /* 明确高度，提升点击区域 */
    background: rgba(0, 0, 0, 0.1);
    /* 半透明背景 */
    border: 2px solid #303133;
    /* 规范边框写法顺序 */
    border-radius: 10px;
    /* 圆角设计 */

    /* 文字与间距 */
    color: #303133;
    /* 文字颜色 */
    padding: 0 16px 0 48px;
    /* 左内边距预留图标空间 */
    font-size: large;
    font-weight: bolder;
    line-height: 1;
    /* 垂直居中 */

    /* 视觉增强 */
    box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.05);
    /* 内阴影提升立体感 */
    transition: all 0.3s ease;
    /* 过渡动画 */

    /* 移除默认样式 */
    outline: none;
    /* 移除聚焦外发光 */
    appearance: none;
    /* 清除浏览器默认样式 */
}

/* 聚焦状态 */
.transparentInput:focus {
    border: #000000 3px solid;
    /* 聚焦时边框变色 */
    background: rgba(0, 0, 0, 0.15);
    /* 背景加深 */
    box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.1);
    /* 外发光效果 */
}

/*  placeholder 样式 */
.transparentInput::placeholder {
    color: #C0C4CC;
    /* 浅色占位文字 */
    font-size: 15px;
}

/* 移动端适配 */
@media (max-width: 768px) {
    .transparentInput {
        width: 80vw;
        /* 移动端宽度适配 */
        height: 40px;
        font-size: 14px;
        border-radius: 20px;
    }
}


.blog-container {
    padding: 0 40px;
    /* 初始两侧间距 */
    max-width: 1440px;
    /* 最大内容宽度 */
    margin: 0 auto;
    /* 居中显示 */
}

/* 博客条目样式 */
.blog-item {
    max-width: 1100px;
    /* 限制卡片最大宽度，避免过宽 */
    margin: 0 auto 24px;
    background: #ffffff;
    border-radius: 12px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
    margin-bottom: 24px;
    padding: 24px;
    transition: transform 0.2s ease;
    position: relative;
    /* 鼠标悬停动画 */

}

.blog-item:hover {
    transform: translateY(-4px);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.book-marker {
    /* 基础样式 */
    background-color: #606266;
    /* 主色蓝色，与图标颜色统一 */
    color: #ffffff;
    /* 白色文字 */
    font-size: 0.875rem;
    /* 14px，适配卡片文字层级 */
    font-weight: 500;
    /* 中等粗细，避免过于厚重 */
    padding: 4px 12px;
    /* 增加水平内边距，提升呼吸感 */
    border-radius: 5px;
    /* 更大圆角，匹配卡片弧度 */

    /* 定位与对齐 */
    position: absolute;
    top: -12px;
    /* 上移距离减小，避免脱离卡片视觉范围 */
    left: -12px;
    /* 左侧间距与卡片内边距一致，保持对齐 */
    z-index: 1;
    /* 确保悬浮在卡片上方 */

    /* 视觉增强 */
    box-shadow: 0 2px 4px rgba(74, 144, 226, 0.2);
    /* 柔和投影，增强浮层感 */
    transition: transform 0.2s ease;
    /* 鼠标悬停动画 */

    /* 交互反馈（可选） */
}

.book-marker:hover {
    transform: scale(1.05);
    /* 悬停时轻微放大 */
}

/* 多分类颜色方案（可根据需求扩展） */
.book-marker.category-tech {
    background-color: #21b387;
}

/* 科技绿 */
.book-marker.category-ent {
    background-color: #ff6b6b;
}

/* 娱乐红 */
.book-marker.category-life {
    background-color: #906dd8;
}

/* 生活紫 */
.user-head {
    display: flex;
}

/* 用户信息区域 */
.blog-userInfo {
    border-bottom: 1px solid #f0f0f0;
    padding-bottom: 10px;
}

.user-photo {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    /* 更标准的圆形头像 */
    object-fit: cover;
    /* 图片裁剪方式 */
    border: 2px solid #ffffff;
    box-shadow: 0 0 4px rgba(0, 0, 0, 0.1);
}

.user-nickname {
    font-size: 1.125rem;
    /* 18px */
    font-weight: 500;
    color: #2c3e50;
    line-height: 30px;
    margin: 5px;
    /* 移除冗余margin */
}

.blog-createdAt {

    font-size: 0.875rem;
    /* 14px */
    color: #7f8c8d;
    text-align: right;
    line-height: 30px;
    /* 图标与文字间距 */
}

.el-icon {
    font-size: 1.125rem;
    /* 图标大小适配 */
    color: #3498db;
}

/* 标题与摘要区域 */
.blog-title {
    font-size: 1.25rem;
    /* 20px */
    font-weight: 600;
    color: #2c3e50;
    margin-bottom: 12px;
    line-height: 1.4;
}

.blog-summary {
    font-size: 0.9375rem;
    /* 15px */
    color: #555;
    line-height: 1.6;
    text-indent: 0;
    /* 移除传统缩进，改用段落间距 */
    margin-bottom: 20px;
}

.tag-list {
    display: flex;
    flex-wrap: wrap;
    /* 标签换行 */
    gap: 8px;
    /* 标签间距 */
    margin: 12px 0;
    /* 上下间距 */
}

.el-tag {
    /* 基础样式 */
    font-size: 0.875rem;
    /* 14px */
    font-weight: 500;
    padding: 4px 12px;
    /* 大圆角设计 */
    white-space: nowrap;
    /* 防止标签内容换行 */
    transition: transform 0.2s ease;
    /* 悬停动画 */

    /* 视觉增强 */
    box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
    color: white;
    /* 轻微投影 */
}

.el-tag:hover {
    transform: scale(1.03);
    /* 悬停微缩放 */
}

/* 数据信息区域 */
.blog-info {
    padding-top: 10px;
    border-top: 1px solid #f0f0f0;
}

.blog-likes,
.blog-views {
    /* 图标与文字间距 */
    font-size: 0.9375rem;
    color: #7f8c8d;
}

.blog-views {
    text-align: right;
}

.blog-likes .el-icon {
    color: #e74c3c;
    /* 红心颜色 */
}

.blog-views .el-icon {
    color: #34495e;
    /* 浏览图标颜色 */
}

/* 响应式适配 */
@media (max-width: 768px) {
    .blog-userInfo {
        flex-direction: column;
        align-items: flex-start;
        gap: 12px;
        padding-bottom: 12px;
    }

    .el-col {
        flex-basis: 100% !important;
        /* 移动端堆叠显示 */
    }
}

@media (min-width: 768px) {
    .blog-container {
        padding: 0 var(--container-padding-tablet);
    }
}

@media (min-width: 1024px) {
    .blog-container {
        padding: 0 var(--container-padding-desktop);
    }
}

@media (min-width: 1440px) {
    .blog-container {
        padding: 0 var(--container-padding-large);
    }
}

.zhezhao {
    padding-bottom: 2vh;
    background: radial-gradient(circle at center,
            #909399,
            /* 主色，浅灰 */
            #F0F2F5,
            /* 米白，#F0F2F5 */
            #E9EBF3);
    /* 从中心开始，浅蓝色到白色的径向渐变 */

    background-size: 200% 200%;

    animation: gradientAnimation 10s ease infinite;
}

@keyframes gradientAnimation {
    0% {
        background-position: 0% 50%;
    }

    50% {
        background-position: 100% 50%;
    }

    100% {
        background-position: 0% 50%;
    }
}
</style>
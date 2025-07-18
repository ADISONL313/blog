<template>
    <div class="blog-container">
        <div class="blog-user">
            <h3>作者</h3>
            <div class="head-item">
                <img class="user-photo"
                    :src="`http://47.108.29.91:9000/bloguser/${thisBlog?.userId}/${thisBlog?.photo}`" />
            </div>
            <div class="blog-nickname">
                {{ thisBlog?.nickname }}
            </div>
            <div class="blog-createdAt">
                {{ thisBlog?.createdAt }}
            </div>
        </div>
        <div class="blog-item">
            <h1 class="blog-title">{{ thisBlog?.title }}</h1>
            <h2 class="blog-summary">{{ thisBlog?.summary }}</h2>
            <div class="markdown-content" ref="markdownContainer">
                <div v-html="codeLight" class="markdown-body"></div>
            </div>
        </div>
        <div class="blog-type">
            <div class="blog-category">
                {{ thisBlog?.name }}
            </div>
            <div class="blog-customTags">
                <el-tag style="background-color: #303133;" v-for="tag in thisBlog?.customTags.split(',')">{{ tag
                    }}</el-tag>
            </div>
            <div class="blog-tagList">
                <el-tag v-for="tag in thisBlog?.tags" :style="`background-color: ${tag.color};`">{{ tag.name }}</el-tag>
            </div>
        </div>
    </div>
    <div v-if="mail !== null">
        <likeComponent :blogId="thisBlog?.blogId" :likes="thisBlog?.likes" />
    </div>
</template>
<script setup lang="ts">
import likeComponent from './likeComponent.vue';
import { getBlogAPI } from '@/api/getAPI';
import { nextTick, onMounted, onUnmounted, ref } from 'vue';
import { useRoute } from 'vue-router';
const route = useRoute()
const mail = sessionStorage.getItem('mail')
interface Tag {
    color: string
    description: string
    name: string
    tagId: string
}
interface Blog {
    blogId: string
    categoryId: string
    comments: number
    content: string
    createdAt: string
    customTags: string
    images: string
    likes: number
    mail: string
    name: string
    nickname: string
    publishedAt: string
    status: number
    summary: string
    title: string
    views: string
    userId: string
    photo: string
    tags: Tag[]
}


import { Marked } from 'marked';
import { markedHighlight } from 'marked-highlight';
import hljs from 'highlight.js';
// 引入markdown样式
import 'highlight.js/styles/atom-one-dark.css';
const marked = new Marked(
    markedHighlight({
        langPrefix: 'hljs language-',
        highlight(code, lang) {
            const language = hljs.getLanguage(lang) ? lang : 'shell';
            return hljs.highlight(code, { language }).value;
        },
    })
);
const codeLight = ref('')

const markdownContainer = ref<HTMLElement | null>(null);

const thisBlog = ref<Blog>()
onMounted(async () => {
    const res = await getBlogAPI({ blogId: route.query.blogId })
    thisBlog.value = res[0]
    codeLight.value = await marked.parse(thisBlog.value?.content || '');
    await nextTick()
    if (markdownContainer.value) {
        const codeBlocks = markdownContainer.value.querySelectorAll('pre code');

        codeBlocks.forEach((block) => {
            const codeBlock = block as HTMLElement;
            // 确保每个代码块都有language-*类
            if (![...codeBlock.classList].some(cls => cls.startsWith('language-'))) {
                codeBlock.classList.add('language-text');
            }

            // 应用高亮
            hljs.highlightElement(codeBlock);
        });
    }
})
</script>
<style scoped>
.markdown-content {

    /* 确保代码块有足够的样式 */
    pre {
        padding: 1rem;
        border-radius: 0.5rem;
        overflow-x: auto;
        margin: 1rem 0;
        background-color: #282c34;
        /* 与atom-one-dark主题一致的背景色 */
    }

    code {
        font-family: 'Fira Code', 'Consolas', 'Monaco', monospace !important;
    }
}

.blog-container {
    display: flex;
    flex-direction: column;
    align-items: center;
    padding-top: 70px;
    position: relative;
    min-height: 100vh;
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

.blog-user {
    position: fixed;
    left: 1%;
    top: 10vh;
    /* 调整顶部位置 */
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    gap: 10px;
    /* 增加子元素间距 */
    background-color: #f9f9f9;
    /* 添加背景色 */
    padding: 15px;
    /* 添加内边距 */
    border-radius: 10px;
    /* 添加圆角 */
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    /* 添加阴影 */
}

.head-item {
    display: flex;
    align-items: center;
}

.user-photo {
    width: 60px;
    height: 60px;
    border-radius: 50%;
    margin-right: 10px;
    /* 增加与昵称的间距 */
}

.blog-nickname {
    font-size: 1.2rem;
    font-weight: bold;
}

.blog-createdAt {
    font-size: 0.9rem;
    color: #666;
}

.blog-item {
    max-width: 950px;
    box-shadow: 1px 2px 4px #606266;
    width: 100%;
    background-color: #fff;
    /* 添加背景色 */
    padding: 20px;
    /* 添加内边距 */
    border-radius: 10px;
    /* 添加圆角 */
    margin-bottom: 20px;
    /* 增加底部间距 */
}

.blog-title {
    font-size: 1.8rem;
    margin-bottom: 15px;
    /* 增加底部间距 */
}

.blog-summary {
    font-size: 1.2rem;
    margin-bottom: 20px;
    /* 增加底部间距 */
}

.blog-content {
    font-size: 1rem;
    line-height: 1.6;

    /* 增加行高 */
}

.blog-type {
    position: fixed;
    left: 1%;
    top: 35vh;
    /* 调整顶部位置 */
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    gap: 10px;
    /* 增加子元素间距 */
    background-color: #f9f9f9;
    /* 添加背景色 */
    padding: 15px;
    /* 添加内边距 */
    border-radius: 10px;
    /* 添加圆角 */
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    /* 添加阴影 */
}

.blog-category {
    font-size: 1.2rem;
    font-weight: bold;
}

.blog-tagList {
    display: flex;
    flex-wrap: wrap;
    gap: 5px;
    /* 增加标签间距 */
}

.blog-customTags {
    display: flex;
    flex-wrap: wrap;
    gap: 5px;
}

.el-tag {
    font-size: 0.9rem;
    padding: 5px 10px;
    color: white;
    /* 增加标签圆角 */
}
</style>
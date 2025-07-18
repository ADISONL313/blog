<template>
    <div v-if="freshSon">
        <div v-for="(tree, index) in threadTreeList" :key="index" class="comment-item">
            <div @click="handleAnswer(tree)">
                <div class="comment-userInfo">
                    <el-row>
                        <el-col class="user-item" :span="12">
                            <img class="user-photo"
                                :src="`http://47.108.29.91:9000/bloguser/${tree.userId}/${tree.photo}`" />
                            <span class="user-name">{{ tree.nickname }}</span>
                        </el-col>
                        <el-col class="comment-time" :span="12">{{ tree.commentTime }}</el-col>
                    </el-row>
                </div>
                <div class="blog-comment">
                    {{ tree.content }}
                </div>
            </div>
            <el-collapse v-if="tree.children && tree.children.length > 0">
                <el-collapse-item title="更多评论">
                    <div>
                        <thread-commpent v-if="tree.children && tree.children.length > 0" :threadTree="tree.children"
                            :key="index" />
                    </div>
                </el-collapse-item>
            </el-collapse>
        </div>
    </div>

</template>
<script setup lang='ts'>
import { useRoute } from 'vue-router'
const route = useRoute()
interface BlogComment {
    mail: string
    content: string
    commentId: string
    nickname: string
    blogId: string
    parentCommentId: string
    commentTime: string
    parentNickname: string
    userId: string
    photo: string
    children?: BlogComment[]
}
import { useRouter } from 'vue-router'
const router = useRouter()
import { onMounted, ref, watch, type PropType } from 'vue'

const props = defineProps({
    threadTree: {
        type: Array as PropType<BlogComment[]>,
        required: true
    }
})
const threadTreeList = ref<BlogComment[]>([])
onMounted(() => {
    if (props.threadTree !== null) {
        threadTreeList.value = props.threadTree
    }
})


import { useUniversalStore } from '@/stores/universalStore';
import { storeToRefs } from 'pinia'
const universalStore = useUniversalStore()
const { drawer, commentLevel } = storeToRefs(universalStore)

import { useBlogCommentStore } from '@/stores/commentStore';
import { fr } from 'element-plus/es/locales.mjs'
const blogCommentStore = useBlogCommentStore()
const { submitBlogComment } = storeToRefs(blogCommentStore)

const handleAnswer = (tree: any) => {
    const isLoggedIn = sessionStorage.getItem('token') !== null;
    if (!isLoggedIn) {
        router.push('/signIn')
        return
    }
    console.log(tree)
    submitBlogComment.value = tree
    commentLevel.value = 'last'
    drawer.value = true
}
const freshSon = ref(true)
watch(() => props.threadTree, (newValue) => {
    if (newValue) {
        threadTreeList.value = newValue;
    }
}, {
    immediate: true // 立即执行一次回调
});
</script>
<style scoped>
/* 评论项 */
.comment-item {
    cursor: pointer;
    background-color: #fff;
    border-radius: 8px;
    margin-bottom: 16px;
    padding: 16px;
    transition: all 0.3s ease;
    width: 100%;

    &:hover {
        box-shadow: 0 4px 16px rgba(0, 0, 0, 0.12);
        transform: translateY(-2px);
    }
}

.user-item {
    display: flex;
}

.user-photo {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    object-fit: cover;
    margin-right: 12px;
    border: 2px solid #f5f7fa;
    transition: transform 0.3s ease;

    &:hover {
        transform: scale(1.1);
    }
}

.user-name {
    font-size: 16px;
    font-weight: 500;
    color: #303133;
    margin-right: 8px;
    line-height: 40px;
}

.comment-time {
    font-size: 14px;
    line-height: 40px;
    text-align: right;
    color: #909399;
}

/* 评论内容 */
.blog-comment {
    font-size: 16px;
    line-height: 1.6;
    color: #606266;
    margin-bottom: 12px;
    padding: 0 12px;
    white-space: pre-wrap;
}

/* 回复按钮 */
.reply-btn {
    color: #409eff;
    font-size: 14px;
    cursor: pointer;
    transition: all 0.2s ease;
    display: inline-flex;
    align-items: center;

    &:hover {
        color: #66b1ff;
        text-decoration: underline;
    }

    .el-icon {
        margin-right: 4px;
    }
}

/* 评论抽屉 */
.el-drawer.btt {
    width: 100% !important;
    max-width: 600px;
    margin: 0 auto;
    border-radius: 12px 12px 0 0;
    box-shadow: 0 -4px 16px rgba(0, 0, 0, 0.08);
}

/* 评论输入框 */
.el-input__inner {
    border-radius: 8px;
    min-height: 120px;
    resize: none;
    font-size: 16px;
}

/* 评论按钮 */
.comment-btn {
    position: fixed;
    bottom: 30px;
    right: 30px;
    z-index: 100;
    border-radius: 50%;
    width: 56px;
    height: 56px;
    display: flex;
    align-items: center;
    justify-content: center;
    box-shadow: 0 4px 16px rgba(64, 158, 255, 0.4);
    transition: all 0.3s ease;

    &:hover {
        transform: scale(1.1);
        box-shadow: 0 6px 20px rgba(64, 158, 255, 0.5);
    }

    .el-icon {
        margin-right: 0;
        font-size: 20px;
    }
}

/* 回复层级缩进 */
.thread-level-1 {
    margin-left: 40px;
}

.thread-level-2 {
    margin-left: 80px;
}

.thread-level-3 {
    margin-left: 120px;
}

/* 加载动画 */
.loading-shimmer {
    background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
    background-size: 200% 100%;
    animation: shimmer 1.5s infinite;
}

@keyframes shimmer {
    0% {
        background-position: -200% 0;
    }

    100% {
        background-position: 200% 0;
    }
}

/* 响应式设计 */
@media (max-width: 768px) {
    .comment-container {
        padding: 12px;
    }

    .comment-item {
        padding: 12px;
        border-radius: 6px;
    }

    .user-photo {
        width: 40px;
        height: 40px;
    }

    .user-name {
        font-size: 14px;
    }

    .comment-time {
        font-size: 12px;
    }

    .blog-comment {
        font-size: 14px;
        padding: 0;
    }

    .reply-btn {
        font-size: 12px;
    }

    .comment-btn {
        bottom: 20px;
        right: 20px;
        width: 48px;
        height: 48px;
    }

    .thread-level-1 {
        margin-left: 20px;
    }

    .thread-level-2 {
        margin-left: 40px;
    }

    .thread-level-3 {
        margin-left: 60px;
    }
}
</style>

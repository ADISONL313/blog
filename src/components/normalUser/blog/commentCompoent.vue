<template>
    <div class="comment-container">
        <div v-for="(tree, index) in commetTree" :key="index" class="comment-item">
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
            <el-collapse v-if="tree.children.length > 0">
                <el-collapse-item title="更多评论">
                    <div>
                        <thread-commpent :threadTree="tree.children" :key="index" />
                    </div>
                </el-collapse-item>
            </el-collapse>
        </div>
        <el-button class="btn-comment" type="primary" @click="handleSend">
            <el-icon style="font-size: 40px;font-weight: bolder;">
                <ChatDotRound />
            </el-icon>
        </el-button>
        <el-drawer @closed="handleClose" v-model="drawer" direction="btt" title="I am the title" :with-header="false">
            <span
                v-if="submitBlogComment.mail !== '' && submitBlogComment.mail !== null && typeof (submitBlogComment.mail) !== 'undefined'">
                回复给@{{ submitBlogComment.mail }}
            </span>
            <el-form>
                <el-form-item>
                    <el-input type="textarea" v-model="inputContent" placeholder="发表您的评论"></el-input>
                </el-form-item>
                <div style="width: 100%;text-align: right;">
                    <el-button class="btn-send" type="primary" @click="handleComment">发送</el-button>
                </div>
            </el-form>
        </el-drawer>
    </div>
</template>
<script setup lang="ts">
import threadCommpent from './threadCommpent.vue';
import { getCommentAPI } from '@/api/getAPI';
import { getUserBehaviorAPI, sendBlogCommentAPI } from '@/api/postAPI';
import { ElMessage } from 'element-plus';
import { storeToRefs } from 'pinia';
import { onMounted, ref, watch } from 'vue';
import { useUniversalStore } from '@/stores/universalStore';
const universalStore = useUniversalStore()
const { drawer, commentLevel } = storeToRefs(universalStore)
import { useRouter } from 'vue-router';
const router = useRouter()
import { useRoute } from 'vue-router';
const route = useRoute()
const inputContent = ref('')
//处理评论数据
interface BlogComment {
    mail: string
    content: string
    commentId: string
    nickname: string
    blogId: string
    parentCommentId: string
    commentTime: string,
    parentNickname: string
    photo: string
    blogTitle: string
    userId: string
}
type TreeNode = BlogComment & {
    children: TreeNode[];
};

const commetTree = ref()
const mail = sessionStorage.getItem('mail')
import { useBlogCommentStore } from '@/stores/commentStore';
const blogCommentStore = useBlogCommentStore()
const { submitBlogComment } = storeToRefs(blogCommentStore)
//构建评论树
const buildCommentTree = (comments: BlogComment[]): TreeNode[] => {
    const commentMap = new Map<string, TreeNode>()
    const rootNodes: TreeNode[] = [];
    comments.forEach(comment => {
        const node: TreeNode = { ...comment, children: [] };
        commentMap.set(comment.commentId, node);
    });

    // 构建树结构
    comments.forEach(comment => {
        const node = commentMap.get(comment.commentId)!;

        // 如果parentId存在且在映射中能找到，则将当前节点添加为父节点的子节点
        if (comment.parentCommentId && commentMap.has(comment.parentCommentId)) {
            const parentNode = commentMap.get(comment.parentCommentId)!;
            parentNode.children.push(node);
        } else {
            // 否则作为根节点
            rootNodes.push(node);
        }
    });

    // 对根节点和每个子节点按时间戳排序
    const sortNodes = (nodes: TreeNode[]): TreeNode[] => {
        return nodes
            .sort((a, b) => new Date(a.commentTime).getTime() - new Date(b.commentTime).getTime())
            .map(node => ({ ...node, children: sortNodes(node.children) }));
    }

    return sortNodes(rootNodes);
}

const setCommentList = async () => {
    const res = await getCommentAPI({ blogId: route.query.blogId })
    commetTree.value = buildCommentTree(res)
    console.log(commetTree)
}
onMounted(async () => {
    await setCommentList()
})
//评论方法
const handleSend = () => {
    const isLoggedIn = sessionStorage.getItem('token') !== null;
    if (!isLoggedIn) {
        router.push('/signIn')
        return
    }
    console.log(submitBlogComment.value.mail)
    commentLevel.value = 'top'
    drawer.value = true
}
const handleAnswer = (comment: any) => {
    const isLoggedIn = sessionStorage.getItem('token') !== null;
    if (!isLoggedIn) {
        router.push('/signIn')
        return
    }
    commentLevel.value = 'last'
    submitBlogComment.value = comment
    drawer.value = true
}
const handleComment = async () => {
    console.log(commentLevel.value)
    if (inputContent.value === '' || inputContent.value === null) {
        ElMessage.error("请填写评论")
        return
    }
    submitBlogComment.value.blogId = route.query.blogId + ''
    submitBlogComment.value.mail = sessionStorage.getItem('mail') + ''

    if (commentLevel.value === 'top') {
        sendBlogCommentAPI({
            content: inputContent.value,
            mail: sessionStorage.getItem('mail'),
            blogId: route.query.blogId + ''
        })
    } else {
        console.log(submitBlogComment.value)
        sendBlogCommentAPI({
            content: inputContent.value,
            mail: sessionStorage.getItem('mail'),
            blogId: route.query.blogId + '',
            parentCommentId: submitBlogComment.value.commentId
        })
    }
    getUserBehaviorAPI({ mail: mail, blogId: route.query.blogId })
    drawer.value = false
    await setCommentList()
}
const handleClose = async () => {
    inputContent.value = ''
    blogCommentStore.clear()
    await setCommentList()
}
watch(commetTree, (newData) => {
    if (newData) {
        commetTree.value = newData
    }
}, {
    immediate: true
})
</script>
<style scoped>
/* 评论容器 */
.comment-container {
    display: flex;
    flex-direction: column;
    align-items: center;
    margin: 0 auto;
    padding: 20px;
    background-color: #E4E7ED;
}

/* 评论项 */
.comment-item {
    cursor: pointer;
    max-width: 950px;
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
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

.btn-send {
    background-color: #606266;
    border-color: #606266;
    color: white;
    border-radius: 5px;
    padding: 10px 20px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
    transition: all 0.3s ease;
}

.btn-comment {
    position: fixed;
    right: 5%;
    top: 35vh;
    background-color: #606266;
    border-color: #606266;
    color: white;
    border-radius: 5px;
    padding: 10px 20px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
    transition: all 0.3s ease;
    border-radius: 50%;
    /* 更大圆角 */
    width: 75px;
    height: 75px;
    padding: 12px 24px;
    /* 增加内边距 */
}

.btn-comment:hover {
    background-color: #4a4c50;
    /* 悬停时深灰 */
    border-color: #4a4c50;
    color: #ffffff;
    box-shadow: 0 6px 16px rgba(0, 0, 0, 0.2);
    /* 加深投影 */
    transform: translateY(-2px);
    /* 轻微上移 */
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
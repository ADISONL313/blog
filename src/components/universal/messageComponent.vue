<!-- src/components/Notification.vue -->
<template>
    <div class="message-container">
        <!-- 搜索栏 -->
        <el-form class="search-bar" style="position: static; margin-bottom: 24px;" @submit.prevent>
            <input v-model="messageType" placeholder="输入消息类型" @change="handleSerch" class="transparentInput" />
        </el-form>

        <!-- 消息列表 -->
        <div class="message-list">
            <div v-for="message in messageList" :key="message.messageId" class="message-card"
                :class="{ 'unread': !message.isRead }">
                <!-- 消息头部 -->
                <div class="message-header">
                    <div class="message-content">{{ message.messageContent }}</div>
                    <div class="message-meta">
                        <span>{{ message.messageTime }}</span>
                        <span class="read-status">{{ message.isRead ? "已读" : "未读" }}</span>
                    </div>
                </div>

                <!-- 操作按钮 -->
                <div class="message-actions">
                    <el-button class="I-knew" size="small" @click="handleKnew(message.messageId)"
                        :disabled="message.isRead">
                        {{ message.isRead ? "已知晓" : "我已知晓" }}
                    </el-button>
                    <el-button type="danger" size="small" @click="handleDel(message.messageId)" class="delete-btn">
                        删除
                    </el-button>
                </div>
            </div>
        </div>
    </div>

</template>
<script setup lang="ts">
import { deleteMessageAPI } from '@/api/deleteAPI';
import { getMessageAPI, readMessageAPI } from '@/api/getAPI';
import { onMounted, ref } from 'vue';
interface Message {
    messageId: string;
    messageContent: string;
    messageTime: string;
    isRead: boolean;
    // Add other properties if needed
}
const messageType = ref('')
const messageList = ref<Message[]>([])
const setMessageList = async () => {
    messageList.value = await getMessageAPI(messageType.value)
}
onMounted(async () => {
    await setMessageList()
})
const handleSerch = async () => {
    await setMessageList()
}
const handleDel = async (messageId: string) => {
    deleteMessageAPI(messageId)
    await setMessageList()
    await setMessageList()
    await setMessageList()
}
const handleKnew = async (messageId: any) => {
    readMessageAPI(messageId)
    await setMessageList()
    await setMessageList()
    await setMessageList()
}
</script>
<style scoped>
.message-container {
    min-height: 100vh;
    padding-bottom: 2vh;
    justify-items: center;
    padding-top: 70px;
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

.search-bar {
    max-width: 1000px;
    margin: 0 auto 32px;
    margin-top: 20px;
}

.search-icon {
    color: #909399;
    font-size: 1.2em;
    margin-right: 8px;
}

.transparentInput {
    /* 基础样式 */
    width: 100%;
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

.message-list {
    max-width: 1000px;
    margin: 0 auto;
}

.message-card {
    max-width: 100%;
    margin-bottom: 20px;
    padding: 24px;
    border-radius: 16px;
    box-shadow: 0 6px 18px rgba(0, 0, 0, 0.08);
    transition: all 0.3s ease;
    position: relative;

    /* 未读消息样式 */
    &.unread {
        border-left: 4px solid #303133;
        /* 左侧蓝色标记 */
        background-color: #f6f9ff;
    }

    &:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
    }
}

.message-header {
    margin-bottom: 24px;
}

.message-content {
    font-size: 1.125rem;
    line-height: 1.6;
    color: #303133;
}

.message-meta {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: 12px;
    font-size: 0.875rem;
    color: #606266;
}

.read-status {
    font-weight: 500;
    color: #409eff;
    /* 未读状态蓝色 */
}

.message-actions {
    display: flex;
    gap: 12px;
    justify-content: flex-end;
}

.I-knew {
    background-color: #606266;
    border-color: #606266;
    color: white;
    border-radius: 5px;
    padding: 10px 20px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
    transition: all 0.3s ease;
}

/* 响应式设计 */
@media (max-width: 768px) {
    .message-container {
        padding: 20px;
    }

    .message-card {
        padding: 16px;
        border-radius: 12px;
    }

    .message-content {
        font-size: 1rem;
    }

    .message-actions {
        flex-direction: column;
        align-items: flex-start;
        gap: 8px;
    }
}
</style>
<template>
    <div class="like-container">
        <div v-for="record in recordList" :key="record.blogId" class="like-card">
            <div class="like-header">
                <div class="like-title">{{ record.blogTitle }}</div>
                <div class="like-time">{{ record.viewTime }}</div>
            </div>
            <div class="like-option">
                <el-button type="danger" size="small" @click="handleDel(record.viewRecordId)" class="delete-btn">
                    删除
                </el-button>
                <el-button type="primary" size="small" @click="router.push({
                    path: '/home/blogDetail',
                    query: { blogId: record.blogId }
                })" class="browse-btn">
                    浏览
                </el-button>
            </div>
        </div>
    </div>
</template>
<script setup lang="ts">
import { useRouter } from 'vue-router';
import { deleteBlogViewRecordAPI } from '@/api/deleteAPI';
import { getBlogViewRecordAPI } from '@/api/getAPI';
import { onMounted, ref } from 'vue';
const router = useRouter()
const recordList = ref()
const mail = sessionStorage.getItem('mail')
const setRecordList = async () => {
    recordList.value = await getBlogViewRecordAPI(mail === 'admin' ? {} : { mail: mail + '' })
}
onMounted(async () => {
    await setRecordList()
})
const handleDel = async (viewRecordId: string) => {
    deleteBlogViewRecordAPI(viewRecordId)
    await setRecordList()
    await setRecordList()
    await setRecordList()
}
</script>
<style scoped>
.like-container {
    min-height: 100vh;
    padding-bottom: 2vh;
    justify-items: center;
    padding-top: 60px;
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

.like-card {
    margin-top: 20px;
    width: 100%;
    max-width: 1000px;
    background: #fff;
    border-radius: 12px;
    box-shadow: 0 4px 16px rgba(0, 0, 0, 0.05);
    padding: 24px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    transition: transform 0.3s ease;
}

.like-header {
    display: flex;
    flex-direction: column;
    gap: 8px;
}

.like-title {
    font-size: 1.125rem;
    font-weight: 500;
    color: #303133;
}

.like-time {
    font-size: 0.875rem;
    color: #606266;
}

.like-option {
    display: flex;
    gap: 12px;
}

.delete-btn {
    color: #ff4949;
    border-color: #ffecec;
    background-color: #fff3f3;
    padding: 4px 12px;
}

.browse-btn {

    background-color: #606266;
    border: none;
    color: white;
    border-radius: 5px;
    padding: 10px 20px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
    transition: all 0.3s ease;

    &:hover {
        background-color: #535558;
        transform: translateY(-1px);
    }
}

.like-card:hover {
    transform: translateY(-4px);
    box-shadow: 0 6px 24px rgba(0, 0, 0, 0.1);
}

/* 响应式适配 */
@media (max-width: 768px) {
    .like-card {
        padding: 16px;
        flex-direction: column;
        align-items: flex-start;
        gap: 16px;
    }

    .like-option {
        margin-top: 16px;
    }
}
</style>
<template>
    <el-button class="like-btn" :type="btnType" @click="handleLike">❤{{ thisLike }}</el-button>
</template>
<script setup lang="ts">
import { getBlogLikesAPI } from '@/api/getAPI';
import { getUserBehaviorAPI, likeBlogAPI } from '@/api/postAPI';
import { onMounted, ref } from 'vue';

const props = defineProps({
    blogId: String,
    likes: Number
})
const thisLike = ref(props.likes)
const btnType = ref('')
onMounted(async () => {
    const res = await getBlogLikesAPI({ mail: sessionStorage.getItem('mail'), blogId: props.blogId })
    if (res.length === 0) {
        btnType.value = ''
    } else {
        btnType.value = 'danger'
    }
})
const handleLike = async () => {
    const res = await likeBlogAPI({ blogId: props.blogId, mail: sessionStorage.getItem('mail') })
    thisLike.value = res.data
    if (res.message === '取消成功') {
        btnType.value = ''
    } else {
        btnType.value = 'danger'
        getUserBehaviorAPI({ mail: sessionStorage.getItem('mail'), blogId: props.blogId })
    }
}
</script>
<style scoped>
.like-btn {
    position: fixed;
    right: 5%;
    top: 20vh;
    z-index: 100;
    border-radius: 50%;
    border: none;
    width: 75px;
    height: 75px;
    padding: 12px 24px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 20px;
    box-shadow: 0 4px 16px rgba(255, 73, 73, 0.3);
    transition: all 0.3s ease;
    animation: pulse 2s infinite;
}

.like-btn:hover {
    color: rgb(196, 86.4, 86.4);
    background-color: rgb(253, 225.6, 225.6);
    transform: scale(1.1);
    box-shadow: 0 6px 20px rgba(255, 73, 73, 0.4);
}

.like-btn:active {
    transform: scale(0.95);
}

@keyframes pulse {
    0% {
        box-shadow: 0 0 0 0 rgba(255, 73, 73, 0.4);
    }

    70% {
        box-shadow: 0 0 0 10px rgba(255, 73, 73, 0);
    }

    100% {
        box-shadow: 0 0 0 0 rgba(255, 73, 73, 0);
    }
}

.like-btn .el-icon {
    margin-right: 0;
    font-size: 20px;
}

.like-btn .el-button__content {
    display: flex;
    align-items: center;
    justify-content: center;
}

/* 点赞动画效果 */
.like-btn.liked {
    animation: like 0.5s ease-in-out;
}

@keyframes like {
    0% {
        transform: scale(1);
    }

    50% {
        transform: scale(1.3);
    }

    100% {
        transform: scale(1);
    }
}
</style>
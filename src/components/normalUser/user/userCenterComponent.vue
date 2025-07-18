<template>
    <div class="user-containerl">
        <div class="user-baseInfo">
            <!-- 新增波动背景容器 -->
            <div class="wave-circle"></div>

            <div class="center-name">个人中心</div>
            <div class="nickname">{{ userData?.nickname }}</div>
            <div class="gender">性别：{{ userData?.gender }}</div>
            <div class="mail">{{ userData?.mail }}</div>

            <div class="user-introduce">
                {{ userData?.introduce }}
            </div>
        </div>
        <div class="image">
            <el-image style="width: 100%;height: 100%;" fit="cover"
                :preview-src-list="[`http://47.108.29.91:9000/bloguser/${userData?.userId}/${userData?.photo}`]"
                :src="`http://47.108.29.91:9000/bloguser/${userData?.userId}/${userData?.photo}`" />
        </div>
    </div>
</template>

<script setup lang="ts">
// 脚本部分无需修改
import { getUserAPI } from '@/api/postAPI';
import { onMounted, ref } from 'vue';
interface PersonalForm {
    userId: string
    password: string
    confirmPassword: string,
    nickname: string,
    gender: string,
    introduce: string
    photo: string
    mail: string
}
const userData = ref<PersonalForm>()
onMounted(async () => {
    const res = await getUserAPI({ mail: sessionStorage.getItem('mail'), nickname: null })
    if (res[0] !== null) {
        userData.value = res[0]
    }
})
</script>

<style scoped>
.user-containerl {
    /* 原有样式不变 */
    display: flex;
    overflow: hidden;
    max-width: 1000px;
    min-height: 30vh;
    margin: 0 auto 24px;
    background: #ffffff;
    border-radius: 12px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
    transition: transform 0.2s ease;
    position: relative;
}

.user-baseInfo {
    background-color: #909399;
    /* 调整为相对定位，作为波动背景的容器 */
    padding-left: 6vh;
    flex: 0 0 55%;
    padding-right: 3vh;
    padding-bottom: 2vh;
    padding-top: 2vh;
    position: relative;
    /* 新增定位 */
    z-index: 1;
    /* 确保内容层在背景之上 */
}

/* 新增波动圆圈背景样式 */
.wave-circle {
    /* 原有定位样式 */
    position: absolute;
    top: 50%;
    left: 70%;
    transform: translate(-50%, -50%);
    width: 300px;
    height: 300px;
    background: #303133;
    border-radius: 50%;
    opacity: 0.8;
    z-index: -1;
    border: 5px solid black;
    /* 背景层层级低于文字 */

    /* 动画调整 */
    animation: waveAnimation 25s infinite ease-in-out;
    /* 过渡时间延长至3秒，使用缓动曲线 */
}

/* 动画关键帧优化 */
@keyframes waveAnimation {
    0% {
        border-radius: 50% 50% 50% 50%;
        /* 标准圆形 */
    }

    25% {
        border-radius: 70% 30% 60% 40% / 30% 70% 40% 60%;
        /* 强不规则椭圆 */
        transform: translate(-50%, -50%) rotate(5deg);
        /* 轻微旋转增加动态 */
    }

    50% {
        border-radius: 80% 20% 70% 30% / 20% 80% 30% 70%;
        /* 最大波动幅度 */
        transform: translate(-50%, -50%) rotate(-10deg);
        /* 反向旋转 */
    }

    75% {
        border-radius: 70% 30% 60% 40% / 30% 70% 40% 60%;
        /* 对称回退 */
        transform: translate(-50%, -50%) rotate(5deg);
        /* 回退旋转角度 */
    }

    100% {
        border-radius: 50% 50% 50% 50%;
        /* 回归圆形 */
    }
}

/* 原有其他样式不变 */
.center-name {
    padding-left: 1vh;
}

.nickname {
    font-size: 100px;
    font-weight: bold;
    color: #C0C4CC;
}

.gender {
    font-size: 60px;
}

.mail {
    font-size: 70px;
    font-weight: bold;
}

.image {
    flex: 0 0 45%;
}
</style>
<template>
    <div class="login-container">
        <!-- 左侧：登录表单区域（35%宽度） -->
        <div class="form-column">
            <div>
                <signUpComponent />
            </div>
        </div>

        <!-- 右侧：视频展示区域（65%宽度，100%高度） -->
        <div class="video-column">
            <div class="video-wrapper">
                <video src="../../../assets/video/8320163-uhd_2560_1440_25fps.mp4" autoplay loop muted
                    plays-inline></video>
                <div class="quote-container">
                    <p class="quote-text" @mouseenter="handleHover" @mouseleave="handleLeave">
                        每个新的开始，都是从前一个结束而来。
                    </p>
                </div>
            </div>
        </div>
    </div>
</template>
<script setup lang="ts">
import signUpComponent from '@/components/normalUser/sign/signUpComponent.vue';
import { ref } from 'vue';

const isHover = ref(false);
const handleHover = () => (isHover.value = true);
const handleLeave = () => (isHover.value = false);
</script>

<style scoped>
.login-container {
    display: flex;
    min-height: 100vh;
    background: #f0f2f5;
    overflow: hidden;
}

/* 调整左右比例：35% + 65% */
.form-column {
    flex: 0 0 35%;
    /* 固定35%宽度，不随内容缩放 */
    background: #A8ABB2;
    backdrop-filter: blur(12px);
    display: flex;
    justify-content: center;
    align-items: center;
}

.video-column {
    flex: 0 0 65%;
    /* 固定65%宽度 */
    position: relative;
    height: 100vh;
    /* 强制占满视口高度 */
    overflow: hidden;
}

/* 左侧表单卡片样式（保持不变） */

/* 右侧视频样式（高度铺满优化） */
.video-wrapper {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    /* 占满父容器高度 */
}

video {
    width: 100%;
    height: 100%;
    object-fit: cover;
    /* 保持比例铺满容器 */
    filter: brightness(0.8);
}

/* 响应式调整（比例固定，小屏幕自动换行） */
@media (max-width: 1024px) {
    .login-container {
        flex-direction: column;
        padding: 2rem;
    }

    .form-column,
    .video-column {
        flex: 0 0 auto;
        width: 100%;
        min-height: 50vh;
    }

    .video-column {
        height: auto;
    }
}

/* 管理员按钮样式（保持不变） */
.admin-btn {
    margin-top: 1.5rem;
    padding: 0.8rem 2rem;
    border-radius: 24px;
    font-weight: 500;
    transition: transform 0.2s ease;

    &:hover {
        transform: translateX(4px);
    }

    &:focus {
        outline: none;
    }
}

/* 视频遮罩（增强对比度） */
.video-column::after {
    content: "";
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: linear-gradient(135deg, rgba(0, 0, 0, 0.5), transparent);
}

.quote-container {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    text-align: center;
    z-index: 10;
    color: white;
    transition: all 0.3s ease;
}

.quote-text {
    font-size: 40px;
    font-weight: 500;
    padding: 12px 24px;
    background: rgba(0, 0, 0, 0.7);
    border-radius: 8px;
    backdrop-filter: blur(4px);
    transform: scale(1);
    opacity: 1;
    transition: all 0.3s ease;
}

/* 悬停动画 */
.quote-text:hover,
.is-hover .quote-text {
    transform: scale(1.05);
    opacity: 1;
}

/* 响应式调整 */
@media (max-width: 768px) {
    .quote-text {
        font-size: 1rem;
        padding: 8px 16px;
    }
}
</style>
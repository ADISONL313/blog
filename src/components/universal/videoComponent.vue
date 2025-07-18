<template>
    <div class="video-container">
        <video src="../../assets/video/12933382_3840_2160_50fps.mp4" autoplay loop muted plays-inline
            class="fullscreen-video">
            <p>您的浏览器不支持视频播放</p>
        </video>

        <el-tooltip effect="dark" content="点击退出登录" placement="bottom">
            <!-- 文字容器 -->
            <div class="text-container" @click="logOut">
                <p class="poem-line first-line">海内存知己，</p>
                <p class="poem-line second-line">天涯若比邻。</p>
            </div>
        </el-tooltip>
    </div>
</template>
<script setup lang="ts">
import { useRouter } from 'vue-router';
const router = useRouter()
const logOut = () => {
    router.push('/signIn')
    sessionStorage.clear()
}
</script>
<style scoped>
.video-container {
    position: relative;
    /* 为文字容器提供定位基准 */
    width: 100%;
    height: 100vh;
    overflow: hidden;
}

.fullscreen-video {
    width: 100%;
    height: 100%;
    object-fit: cover;
    display: block;
}


/* 文字容器样式 */
.text-container {
    cursor: pointer;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    /* 水平垂直居中 */
    text-align: center;
    /* 文字粗细 */
}

/* 分段错位样式 */
.poem-line {
    /* 行间距 */
    transition: transform 0.3s ease;
    /* 动画过渡 */
}

.first-line {
    transform: translateX(-60px);
    /* 第一段向左偏移20px */
}

.second-line {
    transform: translateX(60px);
    /* 第二段向右偏移20px */
}

p {
    background: rgba(255, 255, 255, 0.1);
    backdrop-filter: blur(10px);
    font-size: 70px;
    color: #303133;
    font-weight: bolder;
    margin: 0;
    padding: 5px;
    border-radius: 10px;
}

/* 鼠标悬停时取消偏移（可选交互效果） */
.text-container:hover .poem-line {
    transform: translateX(0);
}
</style>
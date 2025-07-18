<template>
    <div class="common-layout">
        <el-container>
            <!-- 添加固定定位类名 -->
            <el-header class="fixed-header" ref="backToTop">
                <headerMenu />
            </el-header>
            <el-main>
                <RouterView />
            </el-main>
        </el-container>
    </div>
    <el-backtop :bottom="100">
        <div style="
        height: 100%;
        width: 100%;
        background-color:#303133;
        box-shadow: var(--el-box-shadow-lighter);
        text-align: center;
        line-height: 45px;
        border-radius: 50%;
        color:#C0C4CC;
      ">
            <el-icon>
                <Top />
            </el-icon>
        </div>
    </el-backtop>
</template>

<script setup lang="ts">
import HeaderMenu from '@/components/universal/headerMenuComponent.vue';
import { ref } from 'vue';
const backToTop = ref(null)
const back = (top: any) => {
    const targetSection = eval(top);
    if (targetSection.value) {
        targetSection.value.scrollIntoView({ behavior: 'smooth' });
    }
}
</script>

<style scoped>
/* 固定头部样式 */
.fixed-header {
    border: none;
    position: fixed !important;
    /* 强制固定定位 */
    top: 0;
    left: 0;
    right: 0;
    z-index: 999;
    /* 轻微阴影 */
    /* 以下样式继承原有清除内外边距逻辑 */
    margin: 0 !important;
    padding: 0 !important;
}

/* 确保 Main 内容不被头部遮挡 */
.el-main {
    min-height: 100vh !important;
    /* 撑满视口高度 */
    padding-top: 64px !important;
    /* 预留头部高度（需根据实际头部高度调整） */
}

/* 原有容器样式保持不变 */
.el-container {
    margin: 0 !important;
    padding: 0 !important;
}

.el-header,
.el-main {
    padding: 0 !important;
    margin: 0 !important;
}
</style>
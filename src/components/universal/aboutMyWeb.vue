<template>
    <div class="about-container">
        <h1>关于该网站</h1>
        <el-timeline style="max-width: 600px">
            <el-timeline-item timestamp="前端" placement="top">
                <el-card>
                    <h3>vue3</h3>
                    <h3>pinia</h3>
                    <h3>element-plus</h3>
                    <h3>axios</h3>
                </el-card>
            </el-timeline-item>
            <el-timeline-item timestamp="后端" placement="top">
                <el-card>
                    <h3>spring boot</h3>
                    <h3>mybatis-plus</h3>
                    <h3>MinIO</h3>
                    <h3>redis</h3>
                </el-card>
            </el-timeline-item>
        </el-timeline>
    </div>
</template>
<style scoped>
.about-container {
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
</style>
<template>
    <div class="user-container">
        <userCenterComponent />
        <updatePersonalInfoComponent />
    </div>
</template>
<script setup lang="ts">
import userCenterComponent from '@/components/normalUser/user/userCenterComponent.vue';
import updatePersonalInfoComponent from '@/components/normalUser/user/updatePersonalInfoComponent.vue';
</script>
<style scoped>
.user-container {
    justify-items: center;
    padding-top: 70px;
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
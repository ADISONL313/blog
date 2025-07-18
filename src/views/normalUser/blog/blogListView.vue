<template>
    <div style="position: absolute;top: 0;left: 0;right: 0;bottom: 0;">
        <videoComponent />
        <blogListComponent />
    </div>
</template>
<script setup lang="ts">
import videoComponent from '@/components/universal/videoComponent.vue';
import blogListComponent from '@/components/normalUser/blog/blogListComponent.vue';
</script>
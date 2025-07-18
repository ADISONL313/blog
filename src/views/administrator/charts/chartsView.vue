<template>
    <el-row :gutter="0" style="margin-top: 60px;padding: 2vh;">
        <el-col :span="12" style="padding-right: 1vh;">
            <statusBarComponent />
        </el-col>
        <el-col :span="12" style="padding-left: 1vh;">
            <tagPieComponent />
        </el-col>
    </el-row>
    <categoryPieComponent />
</template>
<script setup lang="ts">
import categoryPieComponent from '@/components/administrator/charts/categoryPieComponent.vue';
import tagPieComponent from '@/components/administrator/charts/tagPieComponent.vue';
import statusBarComponent from '@/components/administrator/charts/statusBarComponent.vue';
import commentTree from '@/components/administrator/charts/commentTree.vue';
</script>
<template>
    <div>
        <el-input placeholder="标签名" v-model="name">
            <template #append>
                <el-button type="primary" @click="search">搜索</el-button>
            </template>
        </el-input>
    </div>
    <div class="tag-item">
        <el-tag v-for="tag in chooseTagList" @click="chooseThis(tag)"
            :style="'background-color:' + tag.color + ';color:white;' + 'cursor:pointer'" :key="tag.tagId" size="small">
            {{ tag.name }}
        </el-tag>
    </div>
</template>
<script setup lang="ts">
import { onMounted, ref } from 'vue'
import { getTagAPI } from '@/api/getAPI'
import { useUniversalStore } from '@/stores/universalStore'
import { storeToRefs } from 'pinia'
const universalStore = useUniversalStore()
const { tagList } = storeToRefs(universalStore)
const name = ref('')
const chooseTagList = ref()

onMounted(async () => {
    chooseTagList.value = await getTagAPI('')
})
const search = async () => {
    chooseTagList.value = await getTagAPI(name.value)
}
const chooseThis = (tag: any) => {
    if (tagList.value.length < 3) {
        if (!tagList.value.some((t: any) => t.tagId === tag.tagId)) {
            tagList.value.push(tag)
        }
    }
}
</script>
<style scoped>
/* 标签列表容器 */
.tag-item {
    display: flex;
    flex-wrap: wrap;
    /* 每行4列，最小宽度80px */
    gap: 8px;
    /* 标签间距 */
    padding: 16px;
}

/* 标签样式 */
.el-tag {
    transition: transform 0.2s ease;

    /* 自定义动画 */
    &:hover {
        transform: scale(1.03);
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
    }
}

/* 响应式适配 */
@media (max-width: 768px) {
    .el-input {
        max-width: 90%;
    }

    .el-tag {
        font-size: 12px;
        padding: 4px 12px;
        border-radius: 14px;
    }
}
</style>
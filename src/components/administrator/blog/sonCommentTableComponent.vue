<template>
    <el-table v-if="sonList?.length !== 0" :data="sonList">
        <el-table-column type="expand">
            <template #default="scope">
                <son-comment-table-component :key="scope.row.index" :childData="scope.row.children" />
            </template>
        </el-table-column>
        <el-table-column prop="mail" label="评论账号" />
        <el-table-column prop="nickname" label="头像/昵称">
            <template #default="scope">
                <img style="width: 20px;height: 20px;"
                    :src="'http://47.108.29.91:9000/bloguser/' + scope.row.userId + '/' + scope.row.photo" />{{
                        scope.row.nickname }} </template>
        </el-table-column>
        <el-table-column prop="commentTime" label="评论时间" />
        <el-table-column prop="content" label="评论内容" />

        <el-table-column label="操作">
            <template #default="scope">
                <el-button type="danger" @click="handleDel(scope.row)">删除</el-button>
            </template>
        </el-table-column>
    </el-table>
</template>
<script setup lang="ts">
import { defineProps, onMounted, ref, watch } from 'vue';
const aaa = ref('1111')
const props = defineProps({
    childData: Array
});
import { useUniversalStore } from '@/stores/universalStore';
import { useBlogCommentStore } from '@/stores/commentStore';
import { storeToRefs } from 'pinia';
const universalStore = useUniversalStore()
const blogCommentStore = useBlogCommentStore()
const { submitBlogComment } = storeToRefs(blogCommentStore)
const { drawer } = storeToRefs(universalStore)
const sonList = ref()
onMounted(() => {
    if (props.childData) {
        sonList.value = props.childData
    }
})
const handleDel = (commentId: any) => {
    submitBlogComment.value = commentId
    drawer.value = true
}
watch(() => props.childData, (newData) => {
    if (newData) {
        sonList.value = newData
    }
}, {
    immediate: true
})
</script>
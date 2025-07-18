<template>
    <el-form :inline="true" @submit.prevent>
        <el-form-item>
            <el-input style="width: 40vh;" @change="search" v-model="searchKey" placeholder="输入标题/内容/分类/标签"></el-input>
        </el-form-item>
    </el-form>
    <el-table :data="blogList" style="width: 100%">
        <el-table-column prop="title" label="题目" />
        <el-table-column prop="mail" label="撰写用户" />
        <el-table-column prop="nickname" label="昵称" />
        <el-table-column prop="likes" label="喜欢数" width="70" />
        <el-table-column prop="comments" label="评论数" width="70" />
        <el-table-column prop="views" label="点击量" width="70" />
        <el-table-column prop="name" label="分类" width="70" />
        <el-table-column prop="customTags" label="自定义标签">
            <template #default="scope">
                <el-tag v-for="tag in scope.row.customTags.split(',')">{{ tag }}</el-tag>
            </template>
        </el-table-column>
        <el-table-column prop="tags" label="系统标签">
            <template #default="scope">
                <el-tag v-for="tag in scope.row.tags" :style="'background-color:' + tag.color + ';' + 'color:black;'">{{
                    tag.name }}</el-tag>
            </template>
        </el-table-column>
        <el-table-column prop="createdAt" label="创建时间" />
        <el-table-column prop="pulishedAt" label="审核时间" />
        <el-table-column prop="status" label="审核状态">
            <template #default="scope">
                草稿
            </template>
        </el-table-column>
        <el-table-column label="操作">
            <template #default="scope">
                <el-button type="danger" size="small" @click="handleDelBlog(scope.row.blogId)">删除</el-button>
                <el-button type="primary" size="small" @click="goDetail(scope.row)">详情</el-button>
            </template>
        </el-table-column>
    </el-table>
</template>
<script setup lang="ts">
import { onMounted, ref } from 'vue';
import { useRouter } from 'vue-router';
import { getBlogAPI } from '@/api/getAPI';
import { deleteBlogAPI } from '@/api/deleteAPI';
const router = useRouter()
const blogList = ref()
const setBlogList = async (data: any) => {
    const res = await getBlogAPI(data)
    blogList.value = res
    console.log(res)
}
const mail = sessionStorage.getItem('mail')
onMounted(async () => {
    console.log(mail)
    await setBlogList({ mail: mail, status: 3 })
})
const searchKey = ref('')
const search = async () => {
    await setBlogList({ mail: mail, searchKey: searchKey.value, status: 3 })
}
const handleDelBlog = async (blogId: string) => {
    const res = await deleteBlogAPI(blogId, sessionStorage.getItem('mail') + '')
    if (res === '成功') {
        await setBlogList({ mail: mail, status: 3 })
    }
}
import { useBlogStore } from '@/stores/blogStore';
import { storeToRefs } from 'pinia';
const blogStore = useBlogStore()
const { blog } = storeToRefs(blogStore)
const goDetail = (blogData: any) => {
    blog.value = blogData
    router.push({
        path: '/home/releaseBlog',
        query: {
            updateState: "update"
        }
    })
}
</script>
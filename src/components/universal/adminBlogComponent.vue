<template>
    <el-form :inline="true" @submit.prevent>
        <el-form-item>
            <el-input style="width: 40vh;" @change="search" v-model="searchKey" placeholder="输入标题/内容/分类/标签"></el-input>
        </el-form-item>
        <el-form-item>
            <el-select @change="search" style="width: 20vh;" placeholder="请选择审核状态" v-model="status">
                <el-option label="审核中" :value="0"></el-option>
                <el-option label="审核通过" :value="1"></el-option>
                <el-option label="已驳回" :value="2"></el-option>
            </el-select>
        </el-form-item>
    </el-form>
    <el-table :data="blogList.slice((currentPage - 1) * 10, currentPage * 10)" style="width: 100%">
        <el-table-column prop="title" label="题目" />
        <el-table-column prop="mail" label="撰写用户" />
        <el-table-column prop="nickname" label="昵称" />
        <el-table-column prop="likes" label="喜欢数" width="70" />
        <el-table-column prop="comments" label="评论数" width="70" />
        <el-table-column prop="views" label="点击量" width="70" />
        <el-table-column prop="name" label="分类" width="70" />
        <el-table-column prop="customTags" label="自定义标签">
            <template #default="scope">
                <el-tag style="background-color: #303133;color: white;"
                    v-for="tag in scope.row.customTags.split(',')">{{
                        tag
                    }}</el-tag>
            </template>
        </el-table-column>
        <el-table-column prop="tags" label="系统标签">
            <template #default="scope">
                <el-tag v-for="tag in scope.row.tags" :style="'background-color:' + tag.color + ';' + 'color:white;'">{{
                    tag.name }}</el-tag>
            </template>
        </el-table-column>
        <el-table-column prop="createdAt" label="创建时间" />
        <el-table-column prop="publishedAt" label="审核时间" />
        <el-table-column prop="status" label="审核状态">
            <template #default="scope">
                {{ scope.row.status === 0 ? "审核中" : scope.row.status === 1 ? "审核通过" : scope.row.status === 2 ? "已驳回"
                    :
                    "草稿" }}
            </template>
        </el-table-column>
        <el-table-column label="操作">
            <template #default="scope">
                <el-button type="danger" size="small" @click="handleDelBlog(scope.row.blogId)">删除</el-button>
                <el-button type="primary" size="small" @click="goDetail(scope.row)">详情</el-button>
            </template>
        </el-table-column>
    </el-table>
    <page-component />
</template>
<script setup lang="ts">
import pageComponent from './pageComponent.vue';
import { onMounted, ref } from 'vue';
import { useRouter } from 'vue-router';
import { getBlogAPI } from '@/api/getAPI';
import { deleteBlogAPI } from '@/api/deleteAPI';
import { useUniversalStore } from '@/stores/universalStore'
import { storeToRefs } from 'pinia'
const universalStore = useUniversalStore()
const { pageSize, currentPage, total, pageCount } = storeToRefs(universalStore)
const router = useRouter()
const blogList = ref([])
const setBlogList = async (data: any) => {
    const res = await getBlogAPI(data)
    blogList.value = res
    total.value = res.length
    pageCount.value = Math.ceil(res.length / 10)
    console.log(res)
}
const mail = sessionStorage.getItem('mail')
onMounted(async () => {
    console.log(mail)
    await setBlogList(mail === 'admin' ? { outStatus: 'out' } : { mail: mail, outStatus: 'out' })
})
const searchKey = ref('')
const status = ref('')
const search = async () => {
    await setBlogList(mail === 'admin' ? { searchKey: searchKey.value, status: status.value } : { mail: mail, searchKey: searchKey.value, status: status.value })
}
const handleDelBlog = async (blogId: string) => {
    const res = await deleteBlogAPI(blogId, sessionStorage.getItem('mail') + '')
    if (res === '成功') {
        await setBlogList(mail === 'admin' ? { outStatus: 'out' } : { mail: mail, outStatus: 'out' })
    }
}
import { useBlogStore } from '@/stores/blogStore';
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
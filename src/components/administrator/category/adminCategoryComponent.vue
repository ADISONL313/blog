<template>
    <el-form :inline="true" @submit.prevent>
        <el-form-item>
            <el-input style="width: 40vh;" @change="search" v-model="searchName" placeholder="输入标题/内容/分类/标签"></el-input>
        </el-form-item>
    </el-form>
    <el-table :data="categoryList.slice((currentPage - 1) * 10, currentPage * 10)" style="width: 100%">
        <el-table-column prop="name" label="分类名" />
        <el-table-column prop="description" label="分类描述" />
        <el-table-column prop="blogCount" label="使用次数" />
        <el-table-column label="操作">
            <template #default="scope">
                <el-button type="primary" size="small" @click="handleChange(scope.row)">修改</el-button>
                <el-button type="danger" size="small" @click="handleDel(scope.row)">删除</el-button>
            </template>
        </el-table-column>
    </el-table>
    <pageComponent />
    <el-drawer @close="handlesFresh" v-model="drawer" title="修改标签" direction="ltr" size="30%">
        <addCategoryComponent :categoryData="categoryData" />
    </el-drawer>
    <el-dialog v-model="dialog" title="提示" width="500" @closed="handlesFresh">
        <span v-if="blogCount > 0">{{ blogCount }}个blog正在使用该分类，确定将会删除这些博客！</span>
        <span v-else>确定要删除吗？</span>
        <template #footer>
            <div class="dialog-footer">
                <el-button type="danger" @click="handleDelData">
                    确定
                </el-button>
                <el-button @click="dialog = false">取消</el-button>
            </div>
        </template>
    </el-dialog>
</template>
<script setup lang="ts">
import pageComponent from '@/components/universal/pageComponent.vue';
import addCategoryComponent from './addCategoryComponent.vue';
import { countCategoryAPI, getCategoryAPI } from '@/api/getAPI';
import { onMounted, ref, reactive, watch, onUpdated } from 'vue';
import { ElMessage, ElMessageBox, type FormInstance, type FormRules } from 'element-plus'
import { updateCategoryAPI } from '@/api/postAPI';
import { delCategoryAPI } from '@/api/deleteAPI';

import { useUniversalStore } from '@/stores/universalStore'
import { storeToRefs } from 'pinia'
const universalStore = useUniversalStore()
const { pageSize, currentPage, total, pageCount, freshKey } = storeToRefs(universalStore)
interface Category {
    categoryId: string
    name: string,
    description: string
    blogCount: string
}
import type { Ref } from 'vue'
const categoryList: Ref<Category[]> = ref([])
const setCategory = async (name: any) => {
    const res = await countCategoryAPI(name)
    console.log(res)
    pageCount.value = Math.ceil(res.length / 10)
    categoryList.value = await res
    total.value = res.length
    console.log(categoryList.value)
}
onMounted(async () => {
    await setCategory('')
    console.log(categoryList.value)
})
const searchName = ref('')
const search = async () => {
    await setCategory(searchName.value)
}
const drawer = ref(false)

const categoryData = ref()
const handleChange = (category: any) => {
    categoryData.value = category
    drawer.value = true
}
const handlesFresh = async () => {
    await setCategory('')
}
const dialog = ref(false)
const blogCount = ref(0)
const handleDel = (category: any) => {
    categoryData.value = category
    blogCount.value = category.blogCount
    dialog.value = true
}
const handleDelData = async () => {
    dialog.value = false
    freshKey.value = true
    delCategoryAPI(categoryData.value.categoryId)
}
watch(freshKey, async () => {
    if (freshKey.value === true) {
        await setCategory('')
        await setCategory('')
        await setCategory('')
    }
    freshKey.value = false
})
</script>

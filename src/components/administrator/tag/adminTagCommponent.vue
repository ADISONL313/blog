<template>
    <el-form :inline="true" @submit.prevent>
        <el-form-item>
            <el-input style="width: 40vh;" @change="search" v-model="searchName" placeholder="输入标题/内容/分类/标签"></el-input>
        </el-form-item>
    </el-form>
    <el-table :data="tagList.slice((currentPage - 1) * 10, currentPage * 10)" style="width: 100%">
        <el-table-column prop="name" label="标签名" />
        <el-table-column prop="description" label="标签描述" />
        <el-table-column prop="description" label="标签颜色">
            <template #default="scope">
                <div :style="'background-color:' + scope.row.color + ';' + 'width:5vh;height:2vh'"> </div>
            </template>
        </el-table-column>
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
        <addTagCompnent :tagData="tagData" />
    </el-drawer>
    <el-dialog v-model="dialog" title="提示" width="500" @closed="handlesFresh">
        <span v-if="blogCount > 0">{{ blogCount }}个blog正在使用该tag，确定将会取消该标签与blog的关联！</span>
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
import { countTagAPI } from '@/api/getAPI';
import { onMounted, ref, reactive, watch } from 'vue';
import { ElMessageBox, type FormInstance, type FormRules } from 'element-plus'
import { updateCategoryAPI } from '@/api/postAPI';
import { delCategoryAPI, deleteTagAPI } from '@/api/deleteAPI';
import addTagCompnent from './addTagCompnent.vue';
interface Tag {
    tagId: string
    name: string,
    description: string
    color: string
    blogCount: number
}
const tagList = ref([])
import { useUniversalStore } from '@/stores/universalStore'
import { storeToRefs } from 'pinia'
const universalStore = useUniversalStore()

const { pageSize, currentPage, total, pageCount, freshKey } = storeToRefs(universalStore)
const setTag = async (name: any) => {
    const res = await countTagAPI(name)
    tagList.value = await res
    total.value = res.length
    pageCount.value = Math.ceil(res.length / 10)
}

onMounted(async () => {
    await setTag('')
})
const searchName = ref('')
const search = async () => {
    await setTag(searchName.value)
}
const drawer = ref(false)
const tagFormData = reactive<Tag>({
    tagId: '',
    name: '',
    description: '',
    color: '',
    blogCount: 0
})

const rules = reactive<FormRules<Tag>>({
    name: [
        { required: true, message: '请输入名称', trigger: 'blur' }
    ]
})

const tagData = ref()
const handleChange = (tag: any) => {
    tagData.value = tag
    drawer.value = true
}
const handlesFresh = async () => {
    await setTag('')
}
const dialog = ref(false)
const blogCount = ref(0)
const handleDel = (tag: any) => {
    tagFormData.tagId = tag.tagId
    blogCount.value = tag.blogCount
    dialog.value = true
}
const handleDelData = async () => {
    dialog.value = false
    deleteTagAPI(tagFormData.tagId)
}


watch(freshKey, async () => {
    if (freshKey.value === true) {
        await setTag('')
        await setTag('')
    }
    freshKey.value = false
})
</script>

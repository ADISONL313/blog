<template>
    <el-form ref="ruleFormRef" :model="categoryFormData" :rules="rules">
        <el-form-item prop="name">
            <el-input placeholder="分类名" v-model="categoryFormData.name" />
        </el-form-item>
        <el-form-item prop="description">
            <el-input placeholder="分类描述" type="textarea" v-model="categoryFormData.description" />
        </el-form-item>
        <el-form-item>
            <el-button type="primary" @click="handleCategory(ruleFormRef as any)">添加</el-button>
        </el-form-item>
    </el-form>
</template>

<script lang="ts" setup>
import { onMounted, reactive, ref, watch } from 'vue'
import { addCategoryAPI, updateCategoryAPI } from '@/api/postAPI'
import type { FormInstance, FormRules } from 'element-plus'
import { useRouter } from 'vue-router'
const router = useRouter()
interface CategoryForm {
    categoryId: string
    name: string
    description: string
}
import type { PropType } from 'vue'
const props = defineProps({
    categoryData: {
        type: Object as PropType<CategoryForm>
    }
})
const ruleFormRef = ref<FormInstance | null>(null)
const categoryFormData = reactive<CategoryForm>({
    categoryId: '',
    name: '',
    description: '',
})
onMounted(() => {
    if (typeof (props.categoryData) !== 'undefined') {
        Object.assign(categoryFormData, props.categoryData)
    }
})
const rules = reactive<FormRules<CategoryForm>>({
    name: [
        { required: true, message: '请输入分类名', trigger: 'blur' }
    ]
})
import { useUniversalStore } from '@/stores/universalStore'
import { storeToRefs } from 'pinia'
const universalStore = useUniversalStore()
const { freshKey } = storeToRefs(universalStore)

const emit = defineEmits(['isFresh'])
const handleCategory = async (formEl: FormInstance | undefined) => {
    if (!formEl) return
    await formEl.validate(async (valid, fields) => {
        if (valid) {
            console.log(props.categoryData)
            if (typeof (props.categoryData) !== 'undefined') {
                console.log(2222)
                updateCategoryAPI(categoryFormData)
            } else {
                console.log(1111)
                addCategoryAPI(categoryFormData)
            }
            freshKey.value = true
        } else {
            console.log('error submit!', fields)
        }
    })
}
watch(() => props.categoryData, (newData) => {
    if (newData) {
        Object.assign(categoryFormData, newData)
    }
})
</script>
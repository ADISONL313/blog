<template>
    <el-form ref="ruleFormRef" :model="tagFormData" :rules="rules">
        <el-form-item prop="name">
            <el-input placeholder="标签名" v-model="tagFormData.name" />
        </el-form-item>
        <el-form-item prop="color">
            <el-color-picker v-model="tagFormData.color" />{{ tagFormData.color }}
        </el-form-item>
        <el-form-item prop="description">
            <el-input placeholder="标签描述" type="textarea" v-model="tagFormData.description" />
        </el-form-item>
        <el-form-item>
            <el-button type="primary" @click="handleTag(ruleFormRef as any)">添加</el-button>
        </el-form-item>
    </el-form>
</template>

<script lang="ts" setup>
import { onMounted, reactive, ref, watch } from 'vue'
import { addTagAPI, updateTagAPI } from '@/api/postAPI'
import type { FormInstance, FormRules } from 'element-plus'
import { useRouter } from 'vue-router'
const router = useRouter()
interface TagForm {
    tagId: string
    name: string
    color: string
    description: string
}

import type { PropType } from 'vue'
const props = defineProps({
    tagData: {
        type: Object as PropType<TagForm>
    }
})
import { useUniversalStore } from '@/stores/universalStore'
import { storeToRefs } from 'pinia'
const universalStore = useUniversalStore()
const { freshKey } = storeToRefs(universalStore)
const ruleFormRef = ref<FormInstance | null>(null)
const tagFormData = reactive<TagForm>({
    tagId: '',
    name: '',
    color: '',
    description: '',
})
onMounted(() => {
    if (typeof (props.tagData) !== 'undefined') {
        tagFormData.name = props.tagData.name
        tagFormData.tagId = props.tagData.tagId
        tagFormData.color = props.tagData.color
        tagFormData.description = props.tagData.description
    }
})
const rules = reactive<FormRules<TagForm>>({
    name: [
        { required: true, message: '请输入分类名', trigger: 'blur' }
    ],
    color: [
        { required: true, message: '请选择分类颜色', trigger: 'blur' }
    ],
})
const handleTag = async (formEl: FormInstance | undefined) => {
    if (!formEl) return
    await formEl.validate(async (valid, fields) => {
        if (valid) {
            if (typeof (props.tagData) !== 'undefined') {
                updateTagAPI(tagFormData)
            } else {
                addTagAPI(tagFormData)
            }
            freshKey.value = true
        } else {
            console.log('error submit!', fields)
        }
    })
}
watch(() => props.tagData, (newData) => {
    if (newData) {
        tagFormData.tagId = newData.tagId
        tagFormData.name = newData.name
        tagFormData.color = newData.color
        tagFormData.description = newData.description
    }
})
</script>
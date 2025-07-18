<template>
    <div class="release-container">

        <el-form ref="ruleFormRef" :model="blogFormData" :rules="rules">
            <el-form-item
                v-if="mail !== 'admin' && route.query.updateState === 'update' && typeof (rejectReason) !== 'undefined'">
                <div class="reject-div">驳回原因：{{ blog.rejectReason }}
                </div>
            </el-form-item>
            <el-form-item prop="title">
                <el-input type="textarea" placeholder="标题" v-model="blogFormData.title" />
            </el-form-item>
            <el-form-item prop="summary">
                <el-input placeholder="摘要" type="textarea" v-model="blogFormData.summary" />
            </el-form-item>
            <el-form-item prop="categoryId">
                <el-select v-model="blogFormData.categoryId" placeholder="请选择分类" clearable>
                    <el-option v-for="item in categoryList" :key="item.categoryId" :label="item.name"
                        :value="item.categoryId"></el-option>
                </el-select>
            </el-form-item>
            <el-form-item v-if="blogFormData.customTags !== ''">
                <el-tag v-for="tag in blogFormData.customTags.split(',')"
                    style="background-color: #303133;color: white">
                    {{ tag }}
                </el-tag>
            </el-form-item>
            <el-form-item prop="customTags">
                <el-input placeholder="自定义标签" v-model="blogFormData.customTags" />
            </el-form-item>
            <el-form-item prop="tagList" v-if="tagList.length > 0">
                <div v-for="tag in tagList">
                    <el-tag @click="delTag(tag)"
                        :style="'background-color:' + tag.color + ';color:white;' + 'cursor:pointer'" :key="tag.tagId"
                        size="small" class="tag-item">
                        {{ tag.name }}×
                    </el-tag>
                </div>
            </el-form-item>
            <el-form-item>
                <chooseTagComponent />
            </el-form-item>
            <el-form-item prop="content">
                <div style="border: 1px solid #ccc">
                    <Toolbar style="border-bottom: 1px solid #ccc" :editor="editorRef" :defaultConfig="toolbarConfig"
                        mode="default" />
                    <Editor style="height: 500px; overflow-y: hidden;" v-model="blogFormData.content"
                        :defaultConfig="editorConfig" mode="default" @onCreated="handleCreated" />
                </div>
            </el-form-item>
            <div style="text-align: center;">

                <el-button class="btn-zc" v-if="mail !== 'admin'" type="warning"
                    @click="Temporarily = true; yinChang = false; handleRealese(ruleFormRef as any)">暂存</el-button>
                <el-button type="primary" v-if="yinChang" class="btn-wc"
                    @click="handleRealese(ruleFormRef as any)">完成</el-button>
            </div>
        </el-form>
        <el-form v-if="mail === 'admin' && route.query.updateState === 'update'"
            style="width: 30vh;position: fixed;right: 5%;top: 15%;">
            <el-form-item>
                <el-input type="textarea" v-model="rejectReason" placeholder="驳回原因"></el-input>
            </el-form-item>
            <div style="text-align: right;">

                <el-button type="danger" @click="handleReject">驳回</el-button>
            </div>
        </el-form>
    </div>

</template>

<script lang="ts" setup>
const Temporarily = ref(false)
import chooseTagComponent from '@/components/normalUser/tag/chooseTagComponent.vue'
import { reactive, onBeforeUnmount, ref, shallowRef, onMounted, getCurrentInstance } from 'vue'
import { ElMessage, type FormInstance, type FormRules } from 'element-plus'
import { realeseBlogAPI, rejectBlogAPI, updateBlogAPI, uploadImageUrlAPI } from '@/api/postAPI'

import { deleteBlogImagesAPI } from '@/api/deleteAPI'
import { useRouter } from 'vue-router'
//路由参数
import { useRoute } from 'vue-router'
const route = useRoute()
//获取分类
import { getCategoryAPI } from '@/api/getAPI'
interface Category {
    categoryId: string
    name: string
}
const categoryList = ref<Category[]>([])
const yinChang = ref(true)
//wangEditor
import '@wangeditor/editor/dist/css/style.css'
// 引入 css
import { Editor, Toolbar } from '@wangeditor/editor-for-vue'
import type { IEditorConfig } from '@wangeditor/editor'
const router = useRouter()

const rejectReason = ref('')
import { useUniversalStore } from '@/stores/universalStore'
import { storeToRefs } from 'pinia'
const universalStore = useUniversalStore()
const { tagList } = storeToRefs(universalStore)
interface BlogForm {
    blogId: string
    mail: string
    customTags: string
    title: string
    summary: string
    content: string
    status: number
    views: number
    likes: number
    comments: number
    createdAt: string
    publishedAt: string
    categoryId: string
    images: string
    tagList: any[]
}

const editorRef = shallowRef()
const toolbarConfig = {}
const editorConfig: Partial<IEditorConfig> = {
    placeholder: '请输入',                   // JS 语法
    MENU_CONF: {},
}
import { v4 } from 'uuid'
const blogId = v4()
type InsertFnType = (url: string, alt: string, href: string) => void;
// 确保 MENU_CONF 已定义
if (!editorConfig.MENU_CONF) {
    editorConfig.MENU_CONF = {};
}
editorConfig.MENU_CONF['uploadImage'] = {
    customUpload: async (files: any, insertFn: InsertFnType) => {
        const fileArray = Array.isArray(files) ? files : [files];
        for (const file of fileArray) {
            try {
                const formData = new FormData();
                formData.append('file', file);
                formData.append('fileId', blogId)
                formData.append('mail', sessionStorage.getItem('mail') + '')
                // 这里假设你有一个上传图片到 MinIO 的 API
                const res = await uploadImageUrlAPI(formData);
                const imageUrl = res.data; // 假设响应中包含图片的 URL
                insertFn(imageUrl, '', '');
            } catch (error) {
                console.error('图片上传失败:', error);
            }
        }
    },
}

// 组件销毁时，也及时销毁编辑器
onBeforeUnmount(() => {
    const editor = editorRef.value
    if (editor == null) return
    editor.destroy()
})

const handleCreated = (editor: any) => {
    editorRef.value = editor // 记录 editor 实例，重要！
}

//表单验证

const ruleFormRef = ref<FormInstance | null>(null)
const blogFormData = reactive<BlogForm>({
    blogId: '',
    title: '',
    summary: '',
    content: '',
    mail: '',
    status: 0,
    views: 0,
    likes: 0,
    comments: 0,//评论数
    createdAt: '',
    publishedAt: '',
    categoryId: '',
    customTags: '',
    images: '',
    tagList: tagList.value
})

//导入blog pinia对象
import { useBlogStore } from '@/stores/blogStore'
import { getCurrentTimeFormatted } from '@/utils/utils'
import { server } from 'typescript'
const blogStore = useBlogStore()
const { blog } = storeToRefs(blogStore);
onMounted(async () => {
    const res = await getCategoryAPI('')
    categoryList.value = res
    if (route.query.updateState === 'update') {
        if (blog.value !== null) {
            Object.assign(blogFormData, blog.value)
            tagList.value = blog.value.tags
            blogFormData.tagList = blog.value.tags
            rejectReason.value = blog.value.rejectReason
        }
    }
})
const rules = reactive<FormRules<BlogForm>>({
    title: [
        { required: true, message: '请输入标题', trigger: 'blur' }
    ],
    summary: [
        { required: true, message: '请输入摘要', trigger: 'blur' }
    ],
    content: [
        { required: true, message: '请输入内容', trigger: 'blur' }
    ],
    customTags: [
        {
            pattern: /^([^,]*\,){0,2}[^,]*$/,
            message: '自定义标签最多两个，用英文逗号隔开',
            trigger: 'blur'
        }
    ],
})
const mail = sessionStorage.getItem('mail')
const handleRealese = async (formEl: FormInstance | undefined) => {
    if (!formEl) return
    await formEl.validate(async (valid, fields) => {
        if (valid) {
            const formData = new FormData()
            if (route.query.updateState === 'update') {
                formData.append('blogId', blogFormData.blogId)
            } else {
                formData.append('blogId', blogId)
            }
            formData.append('mail', route.query.updateState === 'update' ? blogFormData.mail : mail + '')
            formData.append('title', blogFormData.title)
            formData.append('summary', blogFormData.summary)
            formData.append('content', blogFormData.content)
            if (mail !== 'admin' && Temporarily.value === true) {
                formData.append('status', 3 + '')
            } else if (mail !== 'admin' && Temporarily.value === false) {
                formData.append('status', 0 + '')
            } else {
                formData.append('status', 1 + '')
            }

            formData.append('views', blogFormData.views.toString())
            formData.append('likes', blogFormData.likes.toString())
            formData.append('comments', blogFormData.comments.toString())
            formData.append('createdAt', blogFormData.createdAt)
            formData.append('categoryId', blogFormData.categoryId)
            formData.append('customTags', blogFormData.customTags)
            formData.append('images', blogFormData.images)
            formData.append('tagList', JSON.stringify(tagList.value))
            if (tagList.value.length === 0) {
                ElMessage.error("请选择系统标签")
                return
            }
            if (route.query.updateState === 'update') {
                updateBlogAPI(formData)
            } else {
                realeseBlogAPI(formData)
            }
        } else {
            console.log('error submit!', fields)
        }
    })
}
const delTag = (tag: any) => {
    console.log(tag)
    // 根据 tagId 删除指定的 tag
    const index = tagList.value.findIndex((t: any) => t.tagId === tag.tagId)
    if (index !== -1) {
        tagList.value.splice(index, 1)
    }
}
//驳回方法
const handleReject = () => {
    if (rejectReason.value === '' || rejectReason.value === null || typeof (rejectReason.value) === 'undefined') {
        ElMessage.error('请填写驳回原因')
        return
    }
    rejectBlogAPI({ blogId: blog.value.blogId, rejectReason: rejectReason.value })
}
</script>
<style scoped>
.el-form {
    max-width: 1100px;
    /* 限制卡片最大宽度，避免过宽 */
    margin: 0 auto 24px;
    background: #ffffff;
    border-radius: 12px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
    padding: 20px;
    transition: transform 0.2s ease;
    position: relative;
}

.reject-div {
    font-size: larger;
    font-weight: 900;
}

.btn-wc {
    background-color: #606266;
    border-color: #606266;
    color: white;
    border-radius: 5px;
    padding: 10px 20px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
    transition: all 0.3s ease;
}

.btn-zc {
    background-color: #C0C4CC;
    border: 2px solid #606266;
    color: white;
    border-radius: 5px;
    padding: 10px 20px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
    transition: all 0.3s ease;
}

.release-container {
    padding-bottom: 2vh;
    min-height: 100vh;
    justify-items: center;
    padding-top: 70px;
    background: radial-gradient(circle at center,
            #909399,
            /* 主色，浅灰 */
            #F0F2F5,
            /* 米白，#F0F2F5 */
            #E9EBF3);
    /* 从中心开始，浅蓝色到白色的径向渐变 */

    background-size: 200% 200%;

    animation: gradientAnimation 10s ease infinite;
}

@keyframes gradientAnimation {
    0% {
        background-position: 0% 50%;
    }

    50% {
        background-position: 100% 50%;
    }

    100% {
        background-position: 0% 50%;
    }
}
</style>
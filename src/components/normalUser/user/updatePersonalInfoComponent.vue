<template>
    <el-form ref="ruleFormRef" :model="personalFormData" :rules="rules" class="personal-form">
        <el-form-item prop="mail" class="form-item-mail">
            {{ mail }}
        </el-form-item>

        <el-form-item prop="avatar" class="avatar-container">
            <el-upload :drag="true" class="avatar-uploader" :auto-upload="false" :show-file-list="false"
                :on-success="handleAvatarSuccess" :before-upload="beforeAvatarUpload" :on-change="handleFileChange">
                <div class="avatar-preview" v-if="imageUrl">
                    <img :src="imageUrl" class="avatar" />
                </div>
                <div class="avatar-placeholder" v-else>
                    <el-icon class="avatar-uploader-icon">
                        <Plus />
                    </el-icon>
                    <p>点击或拖拽上传头像</p>
                    <span>支持JPG格式，不超过2MB</span>
                </div>
            </el-upload>
        </el-form-item>

        <el-form-item prop="nickname" class="form-item">
            <el-input placeholder="请输入昵称" v-model="personalFormData.nickname" :disabled="!mail" />
        </el-form-item>

        <el-form-item prop="gender" class="form-item">
            <el-select placeholder="请选择性别" v-model="personalFormData.gender" :disabled="!mail">
                <el-option label="保密" value="保密"></el-option>
                <el-option label="男" value="男"></el-option>
                <el-option label="男" value="男"></el-option>
            </el-select>
        </el-form-item>

        <el-form-item prop="introduce" class="form-item">
            <el-input type="textarea" placeholder="个人介绍" v-model="personalFormData.introduce" :disabled="!mail"
                :rows="3" />
        </el-form-item>

        <el-form-item prop="password" class="form-item">
            <el-input placeholder="密码" v-model="personalFormData.password" show-password :disabled="!mail" />
        </el-form-item>

        <el-form-item prop="confirmPassword" class="form-item">
            <el-input placeholder="确认密码" v-model="personalFormData.confirmPassword" show-password :disabled="!mail" />
        </el-form-item>

        <el-form-item class="form-item-submit">
            <el-button type="primary" @click="handlePersonalInfo(personalFormData as any)">修改</el-button>
        </el-form-item>
    </el-form>
</template>

<script lang="ts" setup>
import { getUserAPI } from '@/api/postAPI'
import { onMounted, reactive, ref } from 'vue'
import type { FormInstance, FormRules } from 'element-plus'
import { updatePersonalInfoAPI } from '@/api/postAPI'
const mail = sessionStorage.getItem('mail')
//上传头像
import { ElMessage } from 'element-plus'
import { Plus } from '@element-plus/icons-vue'
import type { UploadProps } from 'element-plus'
let uploadFile: File | null = null
const imageUrl = ref('')
const handleAvatarSuccess: UploadProps['onSuccess'] = (
    response,
    uploadFile
) => {
    imageUrl.value = URL.createObjectURL(uploadFile.raw!)
    console.log(imageUrl.value)
}

const beforeAvatarUpload: UploadProps['beforeUpload'] = (rawFile) => {
    if (rawFile.type !== 'image/jpeg') {
        ElMessage.error('Avatar picture must be JPG format!')
        return false
    } else if (rawFile.size / 1024 / 1024 > 2) {
        ElMessage.error('Avatar picture size can not exceed 2MB!')
        return false
    }
    return true
}
const isUP = ref(false)
const handleFileChange = (file: { raw: File }) => {
    const reader = new FileReader();
    reader.onload = (e) => {
        imageUrl.value = e.target?.result as string; // 将文件内容转为 DataURL 预览
    };
    reader.readAsDataURL(file.raw); // 读取文件为 Base64 格式
    uploadFile = file.raw
    isUP.value = true
};
//表单验证
interface PersonalForm {
    userId: string
    password: string
    confirmPassword: string,
    nickname: string,
    gender: string,
    introduce: string
}
const genderItem = [
    { label: "保密", value: "保密" },
    { label: "男", value: "男" },
    { label: "女", value: "女" },
]
const ruleFormRef = ref<FormInstance | null>(null)
const personalFormData = reactive<PersonalForm>({
    userId: '',
    password: '',
    confirmPassword: '',
    nickname: '',
    gender: "",
    introduce: ''
})
onMounted(async () => {
    const res = await getUserAPI({ mail: mail, nickname: null })
    console.log(res)
    if (res[0] !== null) {
        if (res[0].photo !== '') {
            imageUrl.value = 'http://47.108.29.91:9000/bloguser/' + res[0].userId + '/' + res[0].photo
        }
        personalFormData.nickname = res[0].nickname
        personalFormData.gender = res[0].gender
        personalFormData.introduce = res[0].introduce
        personalFormData.userId = res[0].userId
    }
})
const rules = reactive<FormRules<PersonalForm>>({
    nickname: [
        { required: true, message: '请输入昵称', trigger: 'blur' },
    ],
    gender: [
        { required: true, message: '请选择性别', trigger: 'blur' },
    ],
    password: [
        { min: 6, message: '密码长度不能小于 6 个字符', trigger: 'blur' }
    ],
    confirmPassword: [
        {
            validator: (rule: any, value: string, callback: (error?: Error) => void) => {
                if (value !== personalFormData.password) {
                    callback(new Error('两次输入的密码不一致'));
                } else {
                    callback();
                }
            },
            trigger: 'blur'
        }
    ]
})
const handlePersonalInfo = async (formEl: FormInstance | undefined) => {
    if (!formEl) return
    const formData = new FormData()
    if (uploadFile) {
        if (isUP.value) {

            formData.append('file', uploadFile)
        }
    }
    console.log(uploadFile?.name)
    formData.append('userId', personalFormData.userId)
    formData.append('nickname', personalFormData.nickname)
    formData.append('gender', personalFormData.gender)
    if (personalFormData.password !== '' && personalFormData.password !== null) {
        formData.append('password', personalFormData.confirmPassword)
    }
    formData.append('introduce', personalFormData.introduce)
    console.log(personalFormData)
    updatePersonalInfoAPI(formData)
    sessionStorage.setItem('nickname', personalFormData.nickname)
}   
</script>
<style scoped>
.personal-form {
    max-width: 1000px;
    margin: 0 auto;
    padding: 32px;
    background: #fff;
    border-radius: 16px;
    box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
}

.form-item-mail {
    margin-bottom: 24px;
    padding-bottom: 16px;
    border-bottom: 1px solid #e4e7ed;
    font-size: 1.125rem;
    color: #303133;
}

.avatar-container {
    margin-bottom: 32px;
    text-align: center;
}

.avatar-uploader {
    width: 100%;
    max-width: 240px;
    margin: 0 auto;
}

.avatar-preview {
    position: relative;
    width: 160px;
    height: 160px;
    margin: 0 auto 24px;
    border-radius: 50%;
    overflow: hidden;
    box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
}

.avatar {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.3s ease;
}

.avatar-preview:hover .avatar {
    transform: scale(1.05);
}

.avatar-edit-btn {
    position: absolute;
    right: 8px;
    bottom: 8px;
    width: 32px;
    height: 32px;
    background: #fff;
    border-radius: 50%;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    display: flex;
    align-items: center;
    justify-content: center;
    color: #409eff;
    cursor: pointer;
}

.avatar-placeholder {
    padding: 24px;
    border: 2px dashed #e4e7ed;
    border-radius: 12px;
    cursor: pointer;
    transition: all 0.3s ease;
}

.avatar-placeholder:hover {
    border-color: #409eff;
    background: #f6f9ff;
}

.avatar-uploader-icon {
    font-size: 32px;
    color: #909399;
    margin-bottom: 8px;
}

.avatar-placeholder p {
    font-size: 1rem;
    color: #606266;
    margin-bottom: 4px;
}

.avatar-placeholder span {
    font-size: 0.875rem;
    color: #909399;
}

.form-item {
    margin-bottom: 24px;
}

.el-input,
.el-select {
    --el-input-border-radius: 12px;
    --el-input-hover-border-color: #409eff;
    --el-input-focus-border-color: #409eff;
}

.form-item-submit {
    text-align: center;
    margin-top: 32px;
}

.el-button[type="primary"] {
    width: 100%;
    max-width: 200px;
    padding: 12px 24px;
    border-radius: 24px;
    font-size: 1rem;
    box-shadow: 0 4px 16px rgba(64, 158, 255, 0.2);
    transition: all 0.3s ease;
}

.el-button[type="primary"]:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 24px rgba(64, 158, 255, 0.3);
}
</style>
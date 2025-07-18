<template>
    <el-form ref="ruleFormRef" :model="signUpForm" :rules="rules" class="modern-form">
        <el-form-item prop="mail">
            <el-input placeholder="邮箱" v-model="signUpForm.mail" class="input-style" />
        </el-form-item>
        <el-form-item prop="password">
            <el-input placeholder="密码" v-model="signUpForm.password" show-password class="input-style" />
        </el-form-item>
        <el-form-item prop="confirmPassword">
            <el-input placeholder="确认密码" v-model="signUpForm.confirmPassword" show-password class="input-style" />
        </el-form-item>
        <el-form-item class="button-item">
            <el-button type="primary" class="primary-btn" @click="handleSignUp(ruleFormRef as any)">注册</el-button>
        </el-form-item>
    </el-form>
</template>

<script lang="ts" setup>
import { reactive, ref } from 'vue'
import { userSignUpAPI } from '@/api/postAPI'
import type { FormInstance, FormRules } from 'element-plus'
interface SignUpForm {
    mail: string
    password: string
    confirmPassword: string
}

const ruleFormRef = ref<FormInstance | null>(null)
const signUpForm = reactive<SignUpForm>({
    mail: '',
    password: '',
    confirmPassword: ''
})

const rules = reactive<FormRules<SignUpForm>>({
    mail: [
        { required: true, message: '请输入邮箱', trigger: 'blur' },
        {
            pattern: /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/,
            message: '邮箱格式错误',
            trigger: 'blur'
        }
    ],
    password: [
        { required: true, message: '请输入密码', trigger: 'blur' },
        { min: 6, message: '密码长度不能小于 6 个字符', trigger: 'blur' }
    ],
    confirmPassword: [
        { required: true, message: '请再次输入密码', trigger: 'blur' },
        {
            validator: (rule, value, callback) => {
                if (value !== signUpForm.password) {
                    callback(new Error('两次输入的密码不一致'));
                } else {
                    callback();
                }
            },
            trigger: 'blur'
        }
    ]
})
const handleSignUp = async (formEl: FormInstance | undefined) => {
    if (!formEl) return
    await formEl.validate((valid, fields) => {
        if (valid) {
            console.log(signUpForm)
            userSignUpAPI(signUpForm)
        } else {
            console.log('error submit!', fields)
        }
    })
}
</script>
<style scoped>
.modern-form {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(12px);
    width: 480px;
    /* 增加宽度 */
    max-width: 100%;
    /* 小屏幕自适应 */
    padding: 3rem 4rem;
    /* 增加内边距 */
    border-radius: 20px;
    /* 更大圆角 */
    box-shadow: 0 12px 32px rgba(0, 0, 0, 0.1);
    /* 更强投影 */
}

.form-item {
    margin-bottom: 1.5rem;
}

.input-style {
    border: none;
    border-radius: 12px;
    background: rgba(255, 255, 255, 0.9);
    box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.05);
    font-size: 1rem;
    transition: all 0.3s ease;

    &:focus {
        box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.1), 0 0 0 3px rgba(64, 158, 255, 0.2);
        outline: none;
    }
}

.el-input__inner {
    padding: 12px 16px;
    color: #333;
}

.link-item {
    text-align: center;
    margin: 1rem 0;
    font-size: 0.9rem;
    color: #666;
}

.register-link {
    color: #409eff;
    text-decoration: none;
    font-weight: 500;
    transition: color 0.3s ease;

    &:hover {
        color: #2c6cb0;
        text-decoration: underline;
    }
}

.primary-btn {
    width: 100%;
    padding: 14px 32px;
    /* 增加按钮内边距 */
    /* 更大圆角 */
    font-size: 1.1rem;
    /* 更大字体 */
    background: #606266;
    /* 深灰色按钮颜色 */
    box-shadow: 0 4px 12px rgba(96, 98, 102, 0.2);
    /* 配套阴影 */
    border: none;

    min-height: 56px;

    &:hover {
        transform: translateY(-2px);
        /* 更大悬停位移 */
        box-shadow: 0 8px 24px rgba(96, 98, 102, 0.3);
        background: #4a4c4f;
        /* 悬停时更深颜色 */
    }
}

.input-style {
    font-size: 1.05rem;
    min-height: 56px;
    /* 更高输入框 */
}

.el-input__inner {
    padding: 16px 24px;
    /* 更大内边距 */
}

/* 图标样式 */
.el-icon {
    margin-left: 8px;
    font-size: 1.1rem;
    vertical-align: middle;
}
</style>
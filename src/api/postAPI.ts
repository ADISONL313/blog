import { ElMessage } from "element-plus"
import { post } from "./axiosConfig"
export const userSignUpAPI = (user: any) => {
    post('/user/signUp', user).then((res) => {
        ElMessage(res.message)
    })
}
export const userSignInAPI = async (user: any) => {
    const res = await post('/user/signIn', user)
    ElMessage(res.message)
    return res
}
export const addCategoryAPI = async (category: any) => {
    const res = await post('/category/addCategory', category)
    ElMessage(res.message)
}
export const addTagAPI = async (tag: any) => {
    console.log(tag)
    const res = await post('/tag/addTag', tag)
    ElMessage(res.message)
}
export const realeseBlogAPI = (formData: any) => {
    post('/releaseBlog', formData).then((res) => {
        ElMessage(res.message)
    })
}
export const getUserAPI = async (user: any) => {
    const res = await post('/user/getUser', user)
    return res.data
}
export const updatePersonalInfoAPI = (formData: any) => {
    post('/user/updatePersonalInfo', formData).then((res) => {
        ElMessage(res.message)
    })
}
export const updateBlogAPI = (formData: any) => {
    post('/updateBlog', formData).then((res) => {
        ElMessage(res.message)
    })
}
export const addBlogViewRecordAPI = (blogViewRecord: any) => {
    post('/blogRecord/addBlogViewRecord', blogViewRecord).then((res) => {
        console.log(res.message)
    })
}
export const sendBlogCommentAPI = (blogComment: any) => {
    post('/blogComment/sendBlogComment', blogComment).then((res) => {
        console.log(res.message)
    })
}
export const answerCommentAPI = (blogComment: any) => {
    post('/blogComment/answerComment').then((res) => {
        console.log(res.message)
    })
}
export const rejectBlogAPI = (data: any) => {
    post('/rejectBlog', data).then((res) => {
        ElMessage(res.message)
    })
}
export const updateCategoryAPI = (data: any) => {
    post('/category/updateCategory', data).then((res) => {
        ElMessage(res.message)
    })
}
export const updateTagAPI = (data: any) => {
    post('/tag/updateTag', data).then((res) => {
        ElMessage(res.message)
    })
}
export const likeBlogAPI = async (data: any) => {
    const res = await post('/like/likeBlog', data)
    return res
}
export const getUserBehaviorAPI = (data: any) => {
    post('/recommend/behavior', data).then((res) => {
        console.log("收集用户行为" + res.message)
    })
}
export const uploadImageUrlAPI = async (data: any) => {
    const res = await post('/uploadBlogImg', data);
    return res
}
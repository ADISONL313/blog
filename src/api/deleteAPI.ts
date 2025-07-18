import { ElMessage } from "element-plus"
import { deleteRemove } from "./axiosConfig"

export const deleteBlogAPI = async (blogId: string, mail: string) => {
    const res = await deleteRemove(`/deleteBlog?blogId=${blogId}&mail=${mail}`)
    ElMessage(res.message)
    return res.message
}
export const deleteBlogImagesAPI = (fileName: string, blogId: string) => {
    deleteRemove(`/deleteBlogImages?fileName=${fileName}&blogId=${blogId}`).then((res) => {
        ElMessage(res.message)
    })
}
export const delCategoryAPI = (categoryId: string) => {
    deleteRemove(`/category/delCategory?categoryId=${categoryId}`).then((res) => {
        ElMessage(res.message)
    })
}
export const deleteTagAPI = (tagId: string) => {
    deleteRemove(`/tag/deleteTag?tagId=${tagId}`).then((res) => {
        ElMessage(res.message)
    })
}
export const deleteCommentAPI = (commentId: string, mail: string) => {
    deleteRemove(`/blogComment/deleteComment?commentId=${commentId}&mail=${mail}`,).then((res) => {
        ElMessage(res.message)
    })
}
export const deleteBlogViewRecordAPI = (blogViewRecordId: string) => {
    deleteRemove(`/blogRecord/deleteBlogViewRecord?blogViewRecordId=${blogViewRecordId}`).then((res) => {
        ElMessage(res.message)
    })
}
export const deleteMessageAPI = (messageId: string) => {
    deleteRemove(`/message/deleteMessage?messageId=${messageId}`).then((res => {
        ElMessage(res.message)
    }))
}
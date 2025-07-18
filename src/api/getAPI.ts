import { ElMessage } from "element-plus"
import { get } from "./axiosConfig"

export const getCategoryAPI = async (name: string) => {
    const res = await get('/category/getCategory', { name: name })
    return res.data
}
export const getTagAPI = async (name: string) => {
    const res = await get('/tag/getTag', { name: name })
    console.log(res)
    return res.data
}
export const getBlogAPI = async (data: any) => {
    const res = await get('/getBlog', data)
    return res.data
}
export const getCommentAPI = async (data: any) => {
    const res = await get('/blogComment/getComment', data)
    return res.data
}
export const countCategoryAPI = async (name: string) => {
    const res = await get('/category/countCategory', { name: name })
    return res.data
}
export const countTagAPI = async (name: string) => {
    const res = await get('/tag/countTag', { name: name })
    return res.data
}
export const getBlogViewRecordAPI = async (mail: any) => {
    const res = await get('/blogRecord/getBlogViewRecord', mail)
    return res.data
}
export const getBlogLikesAPI = async (data: any) => {
    const res = await get('/like/getBlogLikes', data)
    return res.data
}
export const getBlogRecommendAPI = async (mail: string) => {
    const url = `/recommend/personalized?mail=${mail}`
    const res = await get(url)
    return res.data
}
export const getLogAPI = async (operationType: string) => {
    const res = await get('/Log/getLog', { operationType: operationType });
    return res.data
}
export const getBlogStatusCountAPI = async () => {
    const res = await get('/blogStatusCount')
    return res.data
}
export const getMessageAPI = async (messageType: string) => {
    const res = await get('/message/getMessage', { receiverEmail: sessionStorage.getItem('mail') + '', messageType: messageType })
    return res.data
}
export const readMessageAPI = (messageId: string) => {
    get('/message/readMessage', { messageId: messageId }).then((res) => {
        ElMessage(res.message)
    })
}
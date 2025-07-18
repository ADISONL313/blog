import { ref, computed } from 'vue'
import { defineStore } from 'pinia'
interface Tag {
    tagId: string
    name: string
    color: string
}
interface Blog {
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
    tags: any[]
    rejectReason: string
}
export const useBlogStore = defineStore('blog', {
    state: () => ({
        blog: {} as Blog
    }),
    actions: {
        clear() {
            this.blog = {
                blogId: '',
                mail: '',
                customTags: '',
                title: '',
                summary: '',
                content: '',
                status: 0,
                views: 0,
                likes: 0,
                comments: 0,
                createdAt: '',
                publishedAt: '',
                categoryId: '',
                images: '',
                tags: [],
                rejectReason: ''
            }
        }
    }
})

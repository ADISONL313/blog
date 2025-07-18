import { ref, computed } from 'vue'
import { defineStore } from 'pinia'
interface BlogComment {
    mail: string
    content: string
    blogId: string
    commentTime: string
    parentCommentId: string
    commentId: string
}
export const useBlogCommentStore = defineStore('blogComment', {
    state: () => ({
        submitBlogComment: {} as BlogComment
    }),
    actions: {
        clear() {
            this.submitBlogComment = {
                mail: '',
                content: '',
                blogId: '',
                commentTime: '',
                parentCommentId: '',
                commentId: ''
            }
        }
    }
})

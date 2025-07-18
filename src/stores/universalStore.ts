import { ref, computed } from 'vue'
import { defineStore } from 'pinia'

interface Tag {
    tagId: string
    name: string
    color: string
}
export const useUniversalStore = defineStore('universal', {
    state: () => ({
        tagList: [] as Tag[],
        drawer: false,
        commentLevel: 'top',
        freshKey: false,
        dataKey: '',
        currentPage: 1,
        pageSize: 10,
        total: 0,
        pageCount: 0
    }),
    actions: {
        clear() {
            this.tagList = []
            this.drawer = false
            this.commentLevel = 'top'
            this.freshKey = false
            this.dataKey = ''
            this.currentPage = 1
            this.pageSize = 10
            this.total = 0
            this.pageCount = 0
        }
    },
    persist: {
        key: 'drawer',
        storage: sessionStorage,
        paths: ['drawer', 'commentLevel', 'pageSize', 'currentPage']
    } as {
        key: string;
        storage: Storage;
        paths: string[];
    }
})

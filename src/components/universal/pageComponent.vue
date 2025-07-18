<template>
    <div style="width: 100%;justify-items: center;margin-top: 2vh;">
        <el-pagination v-model:current-page="currentPage" v-model:page-size="pageSize"
            :page-sizes="[100, 200, 300, 400]" layout="total, sizes, prev, pager, next, jumper" :page-count="pageCount"
            :total="total" @size-change="handleSizeChange" @current-change="handleCurrentChange" />
    </div>
</template>
<script setup lang="ts">
import { useUniversalStore } from '@/stores/universalStore'
import { storeToRefs } from 'pinia'
const universalStore = useUniversalStore()
const { pageSize, currentPage, total, pageCount } = storeToRefs(universalStore)
const handleSizeChange = (val: number) => {
    console.log(`${val} items per page`)
}
const handleCurrentChange = (val: number) => {
    console.log(`current page: ${val}`)
}
</script>
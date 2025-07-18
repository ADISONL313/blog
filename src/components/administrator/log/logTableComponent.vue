<template>
    <el-form :inline="true" @submit.prevent>
        <el-form-item>
            <el-input style="width: 40vh;" @change="handleSearch" v-model="operationType"
                placeholder="输入操作类型"></el-input>
        </el-form-item>
    </el-form>
    <el-table :data="logList.slice((currentPage - 1) * 10, currentPage * 10)">
        <el-table-column prop="mail" label="操作用户"></el-table-column>
        <el-table-column prop="operationType" label="操作类型"></el-table-column>
        <el-table-column prop="operationTime" label="操作时间"></el-table-column>
        <el-table-column prop="operationIp" label="操作IP"></el-table-column>
        <el-table-column prop="operationDescription" label="操作描述"></el-table-column>
        <el-table-column prop="operationResult" label="操作结果">
        </el-table-column>
        <el-table-column prop="errorMessage" label="操作提示"></el-table-column>
        <el-table-column label="操作">
            <template #default="scope">
                <el-button type="primary" size="small"
                    @click="dialog = true; operationData = scope.row.operationData">查看</el-button>
            </template>
        </el-table-column>
    </el-table>
    <page-component />
    <el-dialog v-model="dialog" title="操作数据" width="800">
        {{ operationData }}
    </el-dialog>

</template>
<script setup lang="ts">
import pageComponent from '@/components/universal/pageComponent.vue';
import { getLogAPI } from '@/api/getAPI';
import { onMounted, ref } from 'vue';
import { useUniversalStore } from '@/stores/universalStore'
import { storeToRefs } from 'pinia'
const universalStore = useUniversalStore()

const { pageSize, currentPage, total, pageCount, freshKey } = storeToRefs(universalStore)
const logList = ref([])
const operationData = ref('')
const operationType = ref('')
const dialog = ref(false)
const setLogList = async (operationType: string) => {
    logList.value = await getLogAPI(operationType)
    total.value = logList.value.length
    pageCount.value = Math.ceil(logList.value.length / 10)
}
onMounted(async () => {
    await setLogList('')
})
const handleSearch = async () => {
    await setLogList(operationType.value)
}
</script>
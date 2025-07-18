<template>
    <div class="char-card">
        <div ref="tagPie" style="width: 100%;min-height: 400px;"></div>
    </div>
</template>
<script setup lang="ts">
import { countTagAPI } from '@/api/getAPI';
import * as echarts from 'echarts';
import { onMounted, ref } from 'vue';
interface Tag {
    name: string
    blogCount: number
    description: string
    tagId: string
}
interface TagCount {
    name: string
    value: number
}
let option
const tagPie = ref()
const tagList = ref<Tag[]>([])
const tagCount = ref<TagCount[]>([])
const tagName = ref<string[]>([])
onMounted(async () => {
    tagList.value = await countTagAPI('')
    tagCount.value = tagList.value.map(item => ({
        name: item.name,
        value: item.blogCount
    }))
    tagName.value = tagList.value.map(item => item.name)
    let tagEl = tagPie.value
    let myChart = echarts.init(tagEl)

    option = {
        title: {
            text: '标签使用量统计',
            left: 'center'
        },
        tooltip: {
            trigger: 'item',
            formatter: '{a} <br/>{b} : {c} ({d}%)'
        },
        legend: {
            type: 'scroll',
            orient: 'vertical',
            right: 10,
            top: 20,
            bottom: 20,
            data: tagName.value
        },
        series: [
            {
                name: '标签名：',
                type: 'pie',
                radius: '55%',
                center: ['40%', '50%'],
                emphasis: {
                    itemStyle: {
                        shadowBlur: 10,
                        shadowOffsetX: 0,
                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                    }
                },
                data: tagCount.value
            }
        ]
    };

    option && myChart.setOption(option);
})


</script>
<style scoped>
.char-card {
    background: #ffffff;
    border-radius: 12px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
    margin-bottom: 24px;
    padding: 24px;
    transition: transform 0.2s ease;
    position: relative;
}
</style>
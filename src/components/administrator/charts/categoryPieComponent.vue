<template>
    <div class="char-card">
        <div ref="categoryChart" style="min-height: 600px;width: 100%;"></div>
    </div>
</template>

<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue';
import * as echarts from 'echarts';
import { countCategoryAPI } from '@/api/getAPI';
interface Category {
    name: string
    blogCount: number
    description: string
    categoryId: string
}
interface ChartCategory {
    value: number
    name: string
}
const categoryChart = ref()
const categoryList = ref<Category[]>([])
const chartCategory = ref<ChartCategory[]>([])
let option
onMounted(async () => {
    categoryList.value = await countCategoryAPI('')
    chartCategory.value = categoryList.value.map(item => ({
        name: item.name,
        value: item.blogCount
    }))
    let categoryEl = categoryChart.value
    let myChart = echarts.init(categoryEl)

    option = {
        title: {
            text: '分类使用数量统计',
            left: 'center'
        },
        tooltip: {
            trigger: 'item',
            formatter: '{a} <br/>{b} : {c} ({d}%)'
        },
        legend: {
            top: 'bottom'
        },
        toolbox: {
            show: true,
            feature: {
                mark: { show: true },
                dataView: { show: true, readOnly: false },
                restore: { show: true },
                saveAsImage: { show: true }
            }
        },
        series: [
            {
                name: '分类使用数量统计',
                type: 'pie',
                radius: [50, 250],
                center: ['50%', '50%'],
                roseType: 'area',
                itemStyle: {
                    borderRadius: 8
                },
                data: chartCategory.value
            }
        ]
    };

    option && myChart.setOption(option);
})
// type EChartsOption = echarts.EChartsOption;

// var chartDom = document.getElementById('main')!;
// var myChart = echarts.init(chartDom);
// var option: EChartsOption;



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
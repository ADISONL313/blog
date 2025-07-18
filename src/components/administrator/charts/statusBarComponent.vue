<template>
    <div class="char-card">
        <div ref="bar" style="width: 100%;height: 400px;"></div>
    </div>
</template>
<script setup lang="ts">
import { getBlogStatusCountAPI } from '@/api/getAPI';
import { onMounted, ref } from 'vue';
import * as echarts from 'echarts';
interface Bar {
    waitPass: number
    unPass: number
    passed: number
    caogao: number
}
const barList = ref<Bar>()
let option
const bar = ref()
onMounted(async () => {
    barList.value = await getBlogStatusCountAPI()
    console.log(barList.value)

    let chartDom = bar.value;
    let myChart = echarts.init(chartDom);

    option = {
        title: {
            text: "博客状态统计",
            left: 'center'
        },
        xAxis: {
            type: 'category',
            data: ['未审核', '已通过', '已驳回', '草稿']
        },
        yAxis: {
            type: 'value'
        },
        series: [
            {
                data: [barList.value?.waitPass, barList.value?.passed, barList.value?.unPass, barList.value?.caogao],
                type: 'bar'
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
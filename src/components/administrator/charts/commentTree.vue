<template>
    <div class="char-card">
        <div ref="commentTree" style="width: 100%;height: 700px;"></div>
    </div>
</template>
<script setup lang="ts">
import * as echarts from 'echarts';
import { getCommentAPI } from '@/api/getAPI';
import { onMounted, ref } from 'vue';
interface BlogComment {
    mail: string;
    content: string;
    commentId: string;
    nickname: string;
    blogId: string;
    parentCommentId: string;
    commentTime: string;
    parentNickname: string;
    blogTitle: string;
    photo: string;
    userId: string;
}

type EChartTreeNode = {
    name: string;       // 节点名称（原nickname）
    value: string;      // 节点值（原content）
    mail: string;       // 保留原字段
    commentId: string;  // 保留原字段
    blogId: string;     // 保留原字段
    commentTime: string;// 保留原字段
    blogTitle: string;  // 博客标题
    photo: string;      // 用户头像
    userId: string;     // 用户ID
    children: EChartTreeNode[]; // 子节点
};

const buildCommentTree = (comments: BlogComment[]): EChartTreeNode => {
    // 根节点名称可自定义（如博客标题或固定名称）
    const root: EChartTreeNode = {
        name: "评论树", // 根节点名称
        value: "",
        mail: "",
        commentId: "",
        blogId: "",
        commentTime: "",
        blogTitle: "",
        photo: "",
        userId: "",
        children: []
    };

    const commentMap = new Map<string, EChartTreeNode>();

    // 第一步：创建节点并映射到 Map（兼容 ECharts 格式）
    comments.forEach(comment => {
        const node: EChartTreeNode = {
            name: comment.nickname,
            value: comment.content, // 若 content 是数字字符串，需转为 number
            mail: comment.mail,
            commentId: comment.commentId,
            blogId: comment.blogId,
            commentTime: comment.commentTime,
            blogTitle: comment.blogTitle,
            photo: comment.photo,
            userId: comment.userId,
            children: []
        };
        commentMap.set(comment.commentId, node);
    });

    // 第二步：构建树结构（挂载到根节点的 children）
    comments.forEach(comment => {
        const node = commentMap.get(comment.commentId)!;
        if (comment.parentCommentId) {
            const parentNode = commentMap.get(comment.parentCommentId)!;
            parentNode.children.push(node);
        } else {
            root.children.push(node); // 根节点的子节点为顶级评论
        }
    });

    // 第三步：按时间排序（与原逻辑一致）
    const sortNodes = (nodes: EChartTreeNode[]): EChartTreeNode[] => {
        return nodes.sort((a, b) =>
            new Date(a.commentTime).getTime() - new Date(b.commentTime).getTime()
        ).map(node => ({
            ...node,
            children: node.children.length > 0 ? sortNodes(node.children) : [] // 无子节点时为 []
        }));
    };

    root.children = sortNodes(root.children);
    return root; // 返回根对象而非数组
};
const commentList = ref<BlogComment[]>([])
const treeData = ref<EChartTreeNode[]>([])
const commentTree = ref()
let option
onMounted(async () => {
    commentList.value = await getCommentAPI('')
    treeData.value = [buildCommentTree(commentList.value)]
    let treeEl = commentTree.value
    let myChart = echarts.init(treeEl)
    option = {
        title: {
            text: "网站评论树",
            left: 'center'
        },
        tooltip: {
            trigger: 'item',
            triggerOn: 'mousemove'
        },
        series: [
            {
                type: 'tree',
                data: treeData.value,
                top: '18%',
                bottom: '14%',
                layout: 'radial',
                symbol: 'emptyCircle',
                symbolSize: 7,
                initialTreeDepth: 3,
                animationDurationUpdate: 750,
                emphasis: {
                    focus: 'descendant'
                }
            }
        ]
    }

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
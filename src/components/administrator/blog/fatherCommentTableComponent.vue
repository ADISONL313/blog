<template>
    <el-table :data="commentTree.slice((currentPage - 1) * 10, currentPage * 10)">
        <el-table-column type="expand">
            <template #default="scope">
                <sonCommentTableComponent :childData="scope.row.children" />
            </template>
        </el-table-column>
        <el-table-column prop="blogTitle" label="评论所属文章" />
        <el-table-column prop="mail" label="评论账号" />
        <el-table-column prop="nickname" label="头像/昵称">
            <template #default="scope">
                <img style="width: 20px;height: 20px;"
                    :src="'http://47.108.29.91:9000/bloguser/' + scope.row.userId + '/' + scope.row.photo" />{{
                        scope.row.nickname }} </template>
        </el-table-column>
        <el-table-column prop="commentTime" label="评论时间" />
        <el-table-column prop="content" label="评论内容" />
        <el-table-column label="操作">
            <template #default="scope">
                <el-button type="danger" @click="delThis(scope.row)">删除</el-button>
            </template>
        </el-table-column>
    </el-table>
    <pageComponent />
    <el-dialog v-model="drawer" title="删除评论" width="800" @closed="handleFresh">
        <span>确定要删除吗?</span>
        <template #footer>
            <div class="dialog-footer">
                <el-button type="danger" @click="handleDelComment">
                    确定
                </el-button>
                <el-button @click="drawer = false">取消</el-button>
            </div>
        </template>
    </el-dialog>
</template>
<script setup lang="ts">
import pageComponent from '@/components/universal/pageComponent.vue';
import { deleteCommentAPI } from '@/api/deleteAPI';
import sonCommentTableComponent from './sonCommentTableComponent.vue';
import { getCommentAPI } from '@/api/getAPI';
import { onMounted, ref } from 'vue';
interface BlogComment {
    mail: string
    content: string
    commentId: string
    nickname: string
    blogId: string
    parentCommentId: string
    commentTime: string
    parentNickname: string
    blogTitle: string
    photo: string
    userId: string
}
type TreeNode = BlogComment & {
    children: TreeNode[];
};

//构建评论树
const buildCommentTree = (comments: BlogComment[]): TreeNode[] => {
    const commentMap = new Map<string, TreeNode>()
    const rootNodes: TreeNode[] = [];
    comments.forEach(comment => {
        const node: TreeNode = { ...comment, children: [] };
        commentMap.set(comment.commentId, node);
    });

    // 构建树结构
    comments.forEach(comment => {
        const node = commentMap.get(comment.commentId)!;

        // 如果parentId存在且在映射中能找到，则将当前节点添加为父节点的子节点
        if (comment.parentCommentId && commentMap.has(comment.parentCommentId)) {
            const parentNode = commentMap.get(comment.parentCommentId)!;
            parentNode.children.push(node);
        } else {
            // 否则作为根节点
            rootNodes.push(node);
        }
    });

    // 对根节点和每个子节点按时间戳排序
    const sortNodes = (nodes: TreeNode[]): TreeNode[] => {
        return nodes
            .sort((a, b) => new Date(a.commentTime).getTime() - new Date(b.commentTime).getTime())
            .map(node => ({ ...node, children: sortNodes(node.children) }));
    }

    return sortNodes(rootNodes);
}
const mail = sessionStorage.getItem('mail')
const commentTree = ref<TreeNode[]>([])
import { useUniversalStore } from '@/stores/universalStore'
import { storeToRefs } from 'pinia'
const universalStore = useUniversalStore()
const { pageSize, currentPage, total, pageCount, drawer } = storeToRefs(universalStore)
const setCommenTree = async () => {
    const res = await getCommentAPI(mail === 'admin' ? {} : { mail: mail })
    commentTree.value = buildCommentTree(res)
    pageCount.value = Math.ceil(commentTree.value.length / 10)
    total.value = commentTree.value.length
    console.log(commentTree.value)
}
onMounted(async () => {
    await setCommenTree()
})
import { useBlogCommentStore } from '@/stores/commentStore';
const blogCommentStore = useBlogCommentStore()
const { submitBlogComment } = storeToRefs(blogCommentStore)

const delThis = async (comment: any) => {
    submitBlogComment.value = comment
    drawer.value = true
}
const handleDelComment = () => {
    console.log(submitBlogComment.value.commentId)
    deleteCommentAPI(submitBlogComment.value.commentId, sessionStorage.getItem('mail') + '')
    drawer.value = false
}
const handleFresh = async () => {
    await setCommenTree()
}
</script>
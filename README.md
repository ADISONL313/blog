# blog
基于sprigboot的blog web
#一个简单的blog网站
#功能模块
  #管理员
    用户管理、标签管理、分类管理、blog管理、用户管理、数据统计
  #普通用户
    发布博客、修改博客、个人中心、智能推荐、评论树（多级评论）
#通过redis缓存用户行为结合推荐算法实现每个用户专属的博客推荐。
#开发环境
#后端
springboot3.4.0
java21
mybatis-plus
MinIO
redis
mysql 8+
#前端
vue3
pinia
echarts
nodeJS 18+
添加包依赖请先执行npm install
然后用npm run dev 启动

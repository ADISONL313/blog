-- MySQL dump 10.13  Distrib 8.0.37, for Win64 (x86_64)
--
-- Host: localhost    Database: blog
-- ------------------------------------------------------
-- Server version	8.0.37

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `blog`
--

DROP TABLE IF EXISTS `blog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blog` (
  `blog_id` varchar(255) NOT NULL COMMENT '博客ID',
  `mail` varchar(255) NOT NULL COMMENT '作者邮箱',
  `title` text NOT NULL COMMENT '博客标题',
  `content` text NOT NULL COMMENT '博客内容',
  `summary` text COMMENT '博客摘要',
  `category_id` varchar(255) DEFAULT NULL COMMENT '分类ID',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '状态：0-草稿，1-已发布，2-已删除',
  `views` int NOT NULL DEFAULT '0' COMMENT '浏览量',
  `likes` int NOT NULL DEFAULT '0' COMMENT '点赞数',
  `comments` int NOT NULL DEFAULT '0' COMMENT '评论数',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `published_at` datetime DEFAULT NULL COMMENT '发布时间',
  `custom_tags` varchar(255) DEFAULT NULL COMMENT '自定义标签，逗号分隔',
  `images` varchar(255) DEFAULT NULL COMMENT '博客封面图片URL',
  `reject_reason` text COMMENT '驳回原因',
  PRIMARY KEY (`blog_id`),
  KEY `idx_mail` (`mail`),
  KEY `idx_category` (`category_id`),
  KEY `idx_status` (`status`),
  KEY `idx_created_at` (`created_at`),
  CONSTRAINT `blog_ibfk_1` FOREIGN KEY (`mail`) REFERENCES `user` (`mail`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog`
--

LOCK TABLES `blog` WRITE;
/*!40000 ALTER TABLE `blog` DISABLE KEYS */;
INSERT INTO `blog` VALUES ('383de3b3-1d33-4275-8d19-eba751a5debd','Adison@dev.com','1','<p>111</p>','231','35d313bd-4908-4fbb-bcaa-083f8433825e',0,0,0,0,'2025-05-20 19:22:04',NULL,'11','',NULL),('39d1cdbf-775d-40d8-8ccb-6841799cc03c','Adison@dev.com','《使命召唤 21》游玩体验：战火重燃，全新征程','<p><span style=\"font-size: 24px;\"><strong>剧情：深入复杂的冷战阴谋​</strong></span></p><p>《黑色行动 6》的剧情延续了该系列一贯的紧张刺激风格，将玩家带回到了 1991 年的海湾战争时期。玩家扮演的 CIA 特工 “凯斯”，在这个动荡的时代背景下，卷入了一场错综复杂的阴谋之中。游戏开场，便是一场紧张刺激的营救行动，玩家需要和队友们一起，在枪林弹雨中解救叛变的伊拉克国防部长赛义德・阿拉维。然而，事情远没有那么简单，在行动过程中，玩家小队遭遇了神秘私人军事组织 “万神殿” 的袭击，这群装备精良、训练有素的敌人，给玩家带来了极大的挑战。​</p><p>随着剧情的推进，玩家会发现 CIA 内部似乎也存在着 “内鬼”，前作中的经典角色阿德勒，竟然在关键时刻倒戈，一枪击毙了玩家保护的 VIP。这一情节的反转，瞬间让玩家陷入了迷茫与困惑之中，也让整个故事变得更加扑朔迷离。为了揭开事件的真相，玩家不得不与小队成员一起选择 “叛逃”，开始了一段充满未知与危险的调查之旅。​</p><p><img src=\"http://47.108.29.91:9000/blog/39d1cdbf-775d-40d8-8ccb-6841799cc03c/4ecbfc5d-6ff1-4e44-a8d7-fd886e871a95.jpg\" alt=\"\" data-href=\"\" style=\"\"/></p><p>在剧情模式中，游戏还引入了 “安全屋” 系统。安全屋不仅是玩家在任务间隙的休息场所，更是一个充满解谜元素的地方。玩家可以在安全屋内与小队成员交流，获取情报，还能通过解谜任务寻找隐藏的宝物。这些解谜任务难度适中，既不会让玩家感到过于困难而放弃，也不会过于简单而失去乐趣。例如，在安全屋的一个角落，可能隐藏着一个需要特定密码才能打开的箱子，而密码的线索则隐藏在房间内的各种物品和文件之中，玩家需要仔细观察、思考，才能解开谜题，获得奖励。这种解谜元素的加入，为传统的射击游戏剧情模式增添了一份别样的乐趣，让玩家在紧张刺激的战斗之余，也能体验到探索和解谜的成就感。 </p><p><span style=\"font-size: 24px;\"><strong>特色玩法：全向移动带来新体验​</strong></span></p><p>《使命召唤 21》最引人注目的特色玩法之一，当属全新加入的 “全向移动” 功能。这个功能允许玩家在面部朝向不变的情况下，自由地向前后左右四个方向奔跑和做出战术动作，极大地提升了角色的机动性。在实际游戏过程中，这种全向移动的操作方式给我带来了一种前所未有的新鲜感。以往在射击游戏中，角色的移动方向往往受到一定限制，而 “全向移动” 打破了这种束缚，让我能够更加灵活地应对各种复杂的战斗场景。​</p><p>例如，在一场激烈的对战中，我可以利用全向移动迅速侧身躲避敌人的攻击，同时还能保持枪口对准敌人，进行反击。或者在需要快速转移阵地时，直接向后奔跑，而无需像以往那样先转身再移动，大大节省了时间，提高了生存几率。不过，这种全新的移动机制也并非完美无缺。由于其操作方式与传统 FPS 游戏有所不同，需要一定的时间来适应。在刚开始游玩时，我经常会因为操作失误而陷入尴尬的境地，比如在紧张的战斗中，误按了全向移动的按键，导致角色朝着错误的方向移动，从而错失战机。但随着游戏时间的增加，逐渐熟悉了这种操作方式后，我开始真正体会到它的魅力所在。 </p><p><span style=\"font-size: 24px;\"><strong>武器系统：丰富多样，各有千秋​</strong></span></p><p>《使命召唤》系列的武器系统一直以来都备受玩家喜爱，《使命召唤 21》也不例外。本作中，武器种类繁多，涵盖了手枪、冲锋枪、步枪、机枪等各种类型，而且其中不乏一些首次出现在 COD 系列中的新武器。​</p><p>手枪方面，以 USP 为原型的 “GS45” 成为了西方阵营角色的标配手枪，它虽然弹匣容量被缩减到了 10 发，但在稳定性和射击精度上表现出色。而伊拉克军队和犯罪分子则使用马卡洛夫 PM 手枪，这种手枪以其可靠性和强大的近距离杀伤力而闻名。此外，斯捷奇金 APS 冲锋手枪的加入，也为喜欢手枪冲锋的玩家提供了更多选择。​</p><p>冲锋枪在游戏中扮演着重要的角色，智利 FAMAE SAF 冲锋枪就是本作的标志性武器之一。它独特的外观和较高的射速，使其在近距离战斗中具有很强的压制力，无论是犯罪组织还是 “万神殿” 士兵都对其青睐有加。值得一提的是，SAF 冲锋枪实际上是 1993 年才设计出来的，在游戏中属于 “穿越” 武器，这也为游戏增添了一份别样的趣味。除了 SAF 冲锋枪，PP-90M1 冲锋枪在《现代战争 3》之后首次回归，它那独特的螺旋弹筒设计，让人一眼就能认出它。</p><p>步枪种类同样丰富，经典的 AR-18 自动步枪和西班牙 CETME-L 自动步枪首次加入，为玩家提供了更多的选择。AR-18 虽然没有被大量国家采购，但它的设计思路影响了众多经典武器。CETME-L 作为西班牙军队的制式步枪，在游戏中也展现出了其独特的性能。当然，游戏中也少不了玩家们熟悉的 “XM4” 步枪，不过这里的 XM4 并非现实中的 XM4 或 M4，而是 M4 定型之前美军特种部队常用的柯尔特 723 卡宾枪。​</p><p>此外，游戏中还加入了一些极为冷门的武器，如 AR-10 机枪型、PU-21 轻机枪、格伦德尔 P-30 手枪、R-31 卡宾枪等等。这些武器有的是罕见的实验武器，有的是冷门的民用枪支，它们的加入，极大地丰富了游戏的武器库，满足了不同玩家对于武器的个性化需求。而且，游戏中的武器模型制作精美，细节处理非常到位，每一把武器都仿佛是一件艺术品，让人爱不释手。无论是武器的外观质感，还是射击时的音效和后坐力反馈，都给玩家带来了非常逼真的体验，仿佛真的置身于战场之中，手持各种先进武器与敌人展开激烈对抗。​</p><p><span style=\"font-size: 24px;\"><strong>多人游戏：激烈对战，乐趣无穷​</strong></span></p><p>多人游戏模式一直是《使命召唤》系列的核心玩法之一，《使命召唤 21》也不例外。在多人游戏中，玩家将在 16 张精心设计的新地图上与其他玩家展开激烈对战，其中包括 12 张核心 6v6 地图和 4 张可以 2v2 或 6v6 玩的 Strike 地图。这些地图风格各异，有的是繁华的商业街，有的是废弃的工厂，还有的是充满异域风情的小镇。每一张地图都有着独特的地形和建筑布局，为玩家提供了丰富多样的战术选择。​</p><p>例如，在 “列车坟场” 这张地图中，地图结构紧凑复杂，到处都是废弃的列车车厢和集装箱，玩家可以利用这些障碍物进行隐蔽和伏击，也可以通过灵活的走位和团队配合，突破敌人的防线。而在 “商业街” 地图中，由于地图面积较大，玩家需要更加注重团队协作和战略规划，合理分配兵力，控制重要据点，才能在战斗中取得优势。​</p><p><img src=\"http://47.108.29.91:9000/blog/39d1cdbf-775d-40d8-8ccb-6841799cc03c/740360d6-305b-44a1-bd82-2b45c0d838d4.jpg\" alt=\"\" data-href=\"\" style=\"\"/></p><p>除了多样化的地图，游戏还回归了传统的声望系统。玩家在游戏中通过完成各种任务、击杀敌人、获得胜利等方式获取经验值，提升等级。随着等级的提升，玩家可以解锁更多的武器、装备和技能，从而根据自己的游戏风格和喜好进行个性化的搭配。这种声望系统的回归，让玩家在游戏中有了明确的目标和成长感，激励着玩家不断地投入到游戏中，提升自己的实力。 【配图 4：展示一张多人游戏中激烈对战的截图，画面中玩家们在地图中穿梭，枪火纷飞，充满紧张感】​</p><p><span style=\"font-size: 24px;\"><strong>总结：瑕不掩瑜的射击佳作​</strong></span></p><p>总的来说，《使命召唤 21：黑色行动 6》给我带来了一段非常精彩的游戏体验。它在剧情、特色玩法、武器系统和多人游戏等方面都有着出色的表现，为玩家呈现了一个紧张刺激、丰富多彩的战争世界。虽然在游戏过程中，也存在一些小问题，比如武器平衡性方面，“胡狼” 冲锋枪在游戏初期表现过于强势，影响了部分游戏体验；地图设计上，个别地图存在地形不合理或面积过大过小等问题。但这些小瑕疵并不能掩盖游戏的光芒，相信随着游戏的不断更新和优化，这些问题都将得到妥善解决。​</p><p>如果你是一名射击游戏爱好者，那么《使命召唤 21》绝对值得你一试。它将带你重回战火纷飞的年代，体验一场紧张刺激、充满挑战的射击盛宴，让你在游戏中感受到战争的残酷与热血，同时也能享受到团队协作和胜利带来的喜悦。快来加入这场全新的使命召唤之旅吧，拿起武器，与队友们一起并肩作战，书写属于自己的战争传奇！​<br></p>','​\r\n​\r\n​\r\n​\r\n​\r\n当《使命召唤》系列的第 21 部作品 ——《使命召唤 21：黑色行动 6》呈现在玩家面前时，它无疑再次点燃了玩家们对射击游戏的热情。作为该系列的忠实粉丝，我迫不及待地投身其中，开启了一场惊心动魄的游戏之旅，现在就来和大家分享一下我的游玩体验。','68b9e4b2-df52-4599-a777-03b608d05322',1,1,0,0,'2025-05-20 12:09:23','2025-05-20 12:14:54','cod,call of duty,使命召唤21','',NULL),('4b5ce4de-e8cc-4560-a359-47a9ef7ac2a7','Adison@dev.com','22','<p>111</p>','313','35d313bd-4908-4fbb-bcaa-083f8433825e',3,0,0,0,'2025-05-20 19:23:22',NULL,'111','',NULL),('54a40fad-2a21-4512-9280-5994111f7228','Adison@dev.com','《霍乱时期的爱情》：跨越时光的爱之百态','<p><span style=\"font-size: 29px;\"><strong>前言</strong></span></p><p>故事起始于一场青涩的邂逅。年轻的邮电局学徒阿里萨，在送信途中，偶然间瞥见了窗前的费尔明娜，那惊鸿一瞥，宛如一道闪电，瞬间击中了他的心，从此，爱情的种子便在他心底生根发芽。为了能多见费尔明娜几面，阿里萨每日清晨都会坐在花园长椅上假装看书，期待着她的路过；他还拉起小提琴，试图用悠扬的琴声吸引她的注意。终于，他鼓起勇气，提笔给费尔明娜写信，就这样，一封封饱含深情的信件在两人之间传递，他们沉浸在纸笔传情的甜蜜之中，将彼此视为爱情的美好象征。 ​</p><p>然而，这段美好的感情遭到了费尔明娜父亲的强烈反对。父亲为了让女儿忘却阿里萨，带着她回到家乡，这一别就是大半年。当费尔明娜再次回到熟悉的地方，再次见到阿里萨时，她却突然感到失望。曾经那个在她心中无比美好的幻影，在现实面前瞬间破碎。她惊慌地发现，自己长久以来所坚守的爱情，或许只是一场自我编织的梦，好奇心作祟下的爱情伪装被彻底撕开。此时的她，毅然决然地选择与阿里萨分手，转身投入了乌尔比诺医生的怀抱。乌尔比诺医生风度翩翩、门第显赫且知识渊博，在父亲的极力撮合下，他们结为夫妻，开启了长达六十多年的婚姻生活。 </p><p><img src=\"http://47.108.29.91:9000/blog/a58ab557-1c95-467d-980d-dbc31d25a77c/37029324-2cc7-49da-8279-6da7ef083aee.jpg\" alt=\"\" data-href=\"\" style=\"\"/></p><p><span style=\"font-size: 29px;\"><strong>章节一</strong></span></p><p>费尔明娜和乌尔比诺医生的婚后生活，如同大多数夫妻一样，充满了生活的琐碎与磨合。起初，激情在生活的磨砺下逐渐消磨，两人会因为生活中的小事互相挑剔、争吵。乌尔比诺医生会在发现衣服扣子没订好时，讽刺地说 “男人需要两个妻子，一个用来爱，一个用来订扣子”；费尔明娜也会在被丈夫搅扰清梦时，愤怒地责骂。但随着时间的推移，他们在相互斗争又相互依赖的状态中，慢慢学会了理解与包容，共同克服了生活中的种种误解和怨恨。他们一起经历了风风雨雨，在岁月的长河中，逐渐到达了一种相濡以沫的境界。直到乌尔比诺医生意外离世，费尔明娜才惊觉，自己对丈夫的爱早已深深扎根，尽管曾经有过诸多矛盾，但这份爱早已在岁月中变得深沉而浓烈。 </p><p>而被费尔明娜拒绝后的阿里萨，陷入了痛苦的深渊。为了减轻心中的创痛，他开始放纵自己，游走于众多女人之间，拥有了 622 个露水情人。但即便如此，他的内心深处始终为费尔明娜保留着一片纯净的角落，他坚信，自己要娶的人唯有费尔明娜。他在漫长的岁月里，默默地等待着，等待着命运再次给予他追求爱情的机会。终于，乌尔比诺医生的去世让阿里萨看到了希望。当晚，他便向费尔明娜表明心迹，可此时的费尔明娜正因丈夫的离世悲痛万分，面对阿里萨的表白，她怒不可遏，觉得受到了羞辱。但阿里萨并未放弃，他从激进转为退守，开始给费尔明娜写充满人生哲理的信件，渐渐地，这些信件帮助费尔明娜从悲痛中走了出来，她开始重新审视自己与阿里萨之间的感情。在时光的流转中，两人跨越了半个多世纪的鸿沟，再次找回了那份曾经失落的爱情。</p><p><img src=\"http://47.108.29.91:9000/blog/a58ab557-1c95-467d-980d-dbc31d25a77c/21802167-ef03-4c8f-bfda-417e00e80829.jpg\" alt=\"\" data-href=\"\" style=\"\"/></p><p><span style=\"font-size: 29px;\">章节二</span></p><p>这部作品中，马尔克斯不仅展现了爱情的坚韧与执着，更描绘了爱情的复杂与多面。阿里萨在肉体上的放纵与对费尔明娜精神上的忠贞形成了鲜明的对比，让人不禁思考爱情的本质究竟为何。费尔明娜从对阿里萨的幻想破灭，到与乌尔比诺医生平淡又真实的婚姻生活，再到晚年与阿里萨重燃爱火，她的情感历程充满了起伏与转变，反映出爱情在不同人生阶段的不同模样。而书中关于婚姻的诸多描述，如 “婚姻的本质上是一项荒谬的，只能靠上帝的无限仁慈才得以存在的发明，它终结于每晚做爱之后，而在第二天早餐之前又必须重新建立起来”，更是深刻地揭示了婚姻生活的现实与无奈，却又让人在其中看到了夫妻之间相互扶持的力量。​</p><p>读完《霍乱时期的爱情》，就像是经历了一场漫长的人生旅程。我们看到了爱情的诞生、成长、挫折与重生，也感受到了岁月对爱情的洗礼与磨砺。它让我们明白，爱情并非单一的模样，它可以是年轻时的热烈奔放，也可以是中年时的平淡琐碎，更可以是晚年时的深沉醇厚。无论何时何地，爱情始终是爱情，只是在不同的人生境遇中，以不同的姿态展现着它的魅力。或许，这就是马尔克斯通过这部作品想要传达给我们的关于爱情的真谛吧。正如书中所说：“无论何时何地，爱情始终都是爱情，只不过距离死亡越近，爱就越浓郁！”</p><p><img src=\"http://47.108.29.91:9000/blog/a58ab557-1c95-467d-980d-dbc31d25a77c/f49b4a8c-d377-4696-b18d-3224884c62ec.jpg\" alt=\"\" data-href=\"\" style=\"\"/></p>','“不可避免，苦杏仁的气味总是让他想起爱情受阻后的命运。”《霍乱时期的爱情》开篇这句话，就像一把神秘的钥匙，悄然打开了那扇尘封着复杂情感的大门。马尔克斯用他那如椽巨笔，在读者面前铺展开一段横跨五十三年七个月零十一天的爱情史诗，让人沉浸于爱之百态的世界里，难以自拔。','eb8bb5f5-bfec-49c5-82dc-de80b027ff9b',1,1,1,0,'2025-05-20 12:03:40','2025-05-20 12:14:59','霍乱时期的爱情,世界文学','',NULL),('5d314e12-caf5-4717-847c-d3aa4e6727ea','Adison@dev.com','1','<p>11</p>','1','35d313bd-4908-4fbb-bcaa-083f8433825e',0,0,0,0,'2025-07-03 20:16:33',NULL,'11','',NULL),('bc1b789e-39cb-4db8-9ff1-2639c539534c','Adison@dev.com','1','<p>222</p>','2','35d313bd-4908-4fbb-bcaa-083f8433825e',3,0,0,0,'2025-05-21 09:29:18',NULL,'1','',NULL),('e11a7e0f-f6c2-471a-b7c1-1e9d969813de','Adison@dev.com','Vue.js 中基于路由参数的博客数据获取与展示实践','<p><span style=\"font-size: 22px;\"><strong>代码概览与核心功能​</strong></span></p><p>先来看以下代码片段：</p><pre><code class=\"language-typescript\">const route = useRoute()\r\nconst mail = sessionStorage.getItem(\'mail\')\r\ninterface Tag {\r\n    color: string\r\n    description: string\r\n    name: string\r\n    tagId: string\r\n}\r\ninterface Blog {\r\n    blogId: string\r\n    categoryId: string\r\n    comments: number\r\n    content: string\r\n    createdAt: string\r\n    customTags: string\r\n    images: string\r\n    likes: number\r\n    mail: string\r\n    name: string\r\n    nickname: string\r\n    publishedAt: string\r\n    status: number\r\n    summary: string\r\n    title: string\r\n    views: string\r\n    userId: string\r\n    photo: string\r\n    tags: Tag[]\r\n}\r\nconst thisBlog = ref&lt;Blog&gt;()\r\nonMounted(async () =&gt; {\r\n    alert(\'你好\')\r\n    const res = await getBlogAPI({ blogId: route.query.blogId })\r\n    thisBlog.value = res[0]\r\n})</code></pre><p><br></p>','在前端开发中，根据路由参数动态获取并展示数据是常见的业务需求。本文将结合具体代码，深入剖析如何在 Vue.js 项目中，基于路由参数获取博客数据并进行展示，同时探讨其中涉及的技术要点与实现细节。','eb8bb5f5-bfec-49c5-82dc-de80b027ff9b',1,1,0,0,'2025-05-20 12:14:23','2025-05-20 12:14:48','编程,vue3,ts','',NULL),('e1dbe2a7-6c0d-4642-81d8-8ac360d3c45b','Adison@dev.com','11','<p>111</p>','11','316af61a-f8e0-42be-bfb3-de7155cd1c1f',0,0,0,0,'2025-05-20 19:19:45',NULL,'111','',NULL);
/*!40000 ALTER TABLE `blog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_comment`
--

DROP TABLE IF EXISTS `blog_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blog_comment` (
  `comment_id` varchar(255) NOT NULL,
  `mail` varchar(255) NOT NULL,
  `blog_id` varchar(255) NOT NULL,
  `parent_comment_id` varchar(255) DEFAULT NULL,
  `content` text NOT NULL,
  `comment_time` datetime NOT NULL,
  PRIMARY KEY (`comment_id`),
  KEY `mail` (`mail`),
  KEY `blog_id` (`blog_id`),
  KEY `blog_comment_ibfk_3` (`parent_comment_id`),
  CONSTRAINT `blog_comment_ibfk_1` FOREIGN KEY (`mail`) REFERENCES `user` (`mail`),
  CONSTRAINT `blog_comment_ibfk_2` FOREIGN KEY (`blog_id`) REFERENCES `blog` (`blog_id`),
  CONSTRAINT `blog_comment_ibfk_3` FOREIGN KEY (`parent_comment_id`) REFERENCES `blog_comment` (`comment_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_blog_comment_parent` FOREIGN KEY (`parent_comment_id`) REFERENCES `blog_comment` (`comment_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_comment`
--

LOCK TABLES `blog_comment` WRITE;
/*!40000 ALTER TABLE `blog_comment` DISABLE KEYS */;
INSERT INTO `blog_comment` VALUES ('619cf9c8-6a19-46dc-a030-8cd69d6154ec','Adison@dev.com','54a40fad-2a21-4512-9280-5994111f7228',NULL,'haokan','2025-06-19 13:38:24'),('bbbf1b23-6428-472e-957d-2e2f4b9b273a','Adison@dev.com','54a40fad-2a21-4512-9280-5994111f7228','619cf9c8-6a19-46dc-a030-8cd69d6154ec','q确实好看','2025-06-19 13:38:35'),('d1568b71-2da7-4c5e-b05b-ccbe048086c7','Adison@dev.com','39d1cdbf-775d-40d8-8ccb-6841799cc03c',NULL,'写得真好','2025-07-03 20:17:27');
/*!40000 ALTER TABLE `blog_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_like`
--

DROP TABLE IF EXISTS `blog_like`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blog_like` (
  `like_id` varchar(255) NOT NULL COMMENT '点赞记录ID',
  `mail` varchar(255) NOT NULL COMMENT '用户邮箱',
  `blog_id` varchar(255) NOT NULL COMMENT '博客ID',
  `like_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '点赞时间',
  PRIMARY KEY (`like_id`),
  UNIQUE KEY `uk_mail_blog` (`mail`,`blog_id`) COMMENT '确保同一用户对同一博客只能点赞一次',
  KEY `idx_blog_id` (`blog_id`),
  KEY `idx_like_time` (`like_time`),
  CONSTRAINT `blog_like_ibfk_1` FOREIGN KEY (`mail`) REFERENCES `user` (`mail`) ON DELETE CASCADE,
  CONSTRAINT `blog_like_ibfk_2` FOREIGN KEY (`blog_id`) REFERENCES `blog` (`blog_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='博客点赞记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_like`
--

LOCK TABLES `blog_like` WRITE;
/*!40000 ALTER TABLE `blog_like` DISABLE KEYS */;
INSERT INTO `blog_like` VALUES ('a5c45c2b-e40e-4b69-a766-9f43f0a14912','Adison@dev.com','54a40fad-2a21-4512-9280-5994111f7228','2025-07-03 19:15:35');
/*!40000 ALTER TABLE `blog_like` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_tag`
--

DROP TABLE IF EXISTS `blog_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blog_tag` (
  `blog_tag_id` varchar(255) NOT NULL COMMENT '关联ID',
  `blog_id` varchar(255) NOT NULL COMMENT '博客ID',
  `tag_id` varchar(255) NOT NULL COMMENT '标签ID',
  PRIMARY KEY (`blog_tag_id`),
  UNIQUE KEY `uk_blog_tag` (`blog_id`,`tag_id`),
  KEY `idx_blog_id` (`blog_id`),
  KEY `idx_tag_id` (`tag_id`),
  CONSTRAINT `blog_tag_ibfk_1` FOREIGN KEY (`blog_id`) REFERENCES `blog` (`blog_id`) ON DELETE CASCADE,
  CONSTRAINT `blog_tag_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`tag_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_tag`
--

LOCK TABLES `blog_tag` WRITE;
/*!40000 ALTER TABLE `blog_tag` DISABLE KEYS */;
INSERT INTO `blog_tag` VALUES ('9b056b26-17d2-4ac3-9b78-7d1d26cf6ee8','39d1cdbf-775d-40d8-8ccb-6841799cc03c','1838ee72-f3fd-42c8-ba2a-fd0e17828816'),('c24754c5-7fb1-48b9-9a25-f446c598893a','39d1cdbf-775d-40d8-8ccb-6841799cc03c','1cd42ab4-52eb-4025-a190-ef1574e20667'),('965f5c71-26b3-4923-a41f-5d1e0857ac77','39d1cdbf-775d-40d8-8ccb-6841799cc03c','f8d89079-2b07-4817-9545-47cb8c8992e6'),('3b38616a-5be9-47e7-a891-8b221957107e','4b5ce4de-e8cc-4560-a359-47a9ef7ac2a7','1838ee72-f3fd-42c8-ba2a-fd0e17828816'),('0f07c0ee-4a91-421c-ba6c-6b6c3e10513e','4b5ce4de-e8cc-4560-a359-47a9ef7ac2a7','1cd42ab4-52eb-4025-a190-ef1574e20667'),('b29649ea-d026-48f1-b3f5-9a56e728ff3c','4b5ce4de-e8cc-4560-a359-47a9ef7ac2a7','204197bb-4311-45a3-b21b-cae669b99cda'),('b305aea0-bf43-4c07-80e0-101ea503c3f8','54a40fad-2a21-4512-9280-5994111f7228','7c0b6d84-4604-4da1-bdce-fddf30368f78'),('998aa3e0-6709-423e-88a1-d7828bc8f8b5','54a40fad-2a21-4512-9280-5994111f7228','8dad2072-9fec-43bc-8a7e-7e204d8a7286'),('9becd74c-e464-4782-bf15-110ce5001855','54a40fad-2a21-4512-9280-5994111f7228','f8d89079-2b07-4817-9545-47cb8c8992e6'),('efe87f88-13c5-4fba-9736-1fc17624f4c9','5d314e12-caf5-4717-847c-d3aa4e6727ea','204197bb-4311-45a3-b21b-cae669b99cda'),('912dbe97-3f1e-4809-bac0-f03b729029a1','bc1b789e-39cb-4db8-9ff1-2639c539534c','1838ee72-f3fd-42c8-ba2a-fd0e17828816'),('9f37f9a4-e4c6-4b9d-8b18-61471f8601b9','bc1b789e-39cb-4db8-9ff1-2639c539534c','204197bb-4311-45a3-b21b-cae669b99cda'),('15e97c18-e04e-4bad-86e6-4fb4c350aa8a','e11a7e0f-f6c2-471a-b7c1-1e9d969813de','1cd42ab4-52eb-4025-a190-ef1574e20667'),('3a16e2f9-1d5e-451d-9a87-3c8af64ff66b','e11a7e0f-f6c2-471a-b7c1-1e9d969813de','8dad2072-9fec-43bc-8a7e-7e204d8a7286'),('d71e46ac-8f9f-4a6e-bda5-eec6a30610c3','e11a7e0f-f6c2-471a-b7c1-1e9d969813de','f669e93c-a163-401c-a35c-b5ea91a84e97');
/*!40000 ALTER TABLE `blog_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_view_record`
--

DROP TABLE IF EXISTS `blog_view_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blog_view_record` (
  `view_record_id` varchar(255) NOT NULL,
  `mail` varchar(255) NOT NULL,
  `blog_id` varchar(255) NOT NULL,
  `view_time` datetime NOT NULL,
  PRIMARY KEY (`view_record_id`),
  KEY `mail` (`mail`),
  KEY `blog_id` (`blog_id`),
  CONSTRAINT `blog_view_record_ibfk_1` FOREIGN KEY (`mail`) REFERENCES `user` (`mail`),
  CONSTRAINT `blog_view_record_ibfk_2` FOREIGN KEY (`blog_id`) REFERENCES `blog` (`blog_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_view_record`
--

LOCK TABLES `blog_view_record` WRITE;
/*!40000 ALTER TABLE `blog_view_record` DISABLE KEYS */;
INSERT INTO `blog_view_record` VALUES ('1857060d-4102-4bd9-a2a7-573d02f64aec','Adison@dev.com','e11a7e0f-f6c2-471a-b7c1-1e9d969813de','2025-05-20 12:48:38'),('76066771-cb88-4b10-b5ec-7993f480c4d3','Adison@dev.com','54a40fad-2a21-4512-9280-5994111f7228','2025-06-19 13:38:07'),('95b272c2-fe19-4c62-9086-b054c232c34e','Adison@dev.com','39d1cdbf-775d-40d8-8ccb-6841799cc03c','2025-05-20 12:15:20');
/*!40000 ALTER TABLE `blog_view_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `category_id` varchar(255) NOT NULL COMMENT '分类ID',
  `name` varchar(50) NOT NULL COMMENT '分类名称（唯一）',
  `description` varchar(255) DEFAULT NULL COMMENT '分类描述',
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES ('316af61a-f8e0-42be-bfb3-de7155cd1c1f','生活',''),('35d313bd-4908-4fbb-bcaa-083f8433825e','公益',''),('5148a5dc-dab3-47cc-b7a1-ad9d2913f881','电影',''),('649c3250-369f-45e9-8e56-752fbe7eba35','美食',''),('68b9e4b2-df52-4599-a777-03b608d05322','游戏',''),('6cd2c22a-6abe-4f25-9619-2cde03c6d360','哔哩哔哩',''),('92619e60-70fa-4252-9852-5bb00e9a0c8b','YouTube',''),('9cae4dd4-c7ca-48d8-b8aa-590c9fb90fb2','文学',''),('b6a7dd62-1a74-4cd6-acb0-00ce1c2064dc','校园',''),('d1cfa9d0-8a11-4e71-a963-45756381b30f','科技',''),('dfe1ae86-3e85-4f83-8606-67c2f1d0ce07','舞蹈',''),('eb8bb5f5-bfec-49c5-82dc-de80b027ff9b','知识',''),('f248e943-6617-4f67-bddc-3ad7f3e2f572','数码',''),('f35f65ec-d939-4309-ab6c-5b995aaab21e','鬼畜',''),('f6301248-fc8c-4418-84f1-f29a57b0e760','音乐',''),('f64be48b-06e7-4314-9ec0-41b23853552a','抖音','');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `message` (
  `message_id` varchar(255) NOT NULL,
  `sender_email` varchar(255) NOT NULL,
  `message_content` text NOT NULL,
  `message_type` varchar(255) NOT NULL,
  `receiver_email` varchar(255) NOT NULL,
  `message_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_read` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`message_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message`
--

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
INSERT INTO `message` VALUES ('32720fdf-7074-40c0-b8d1-1ca4da586694','admin','管理员通过了您的博客：《霍乱时期的爱情》：跨越时光的爱之百态','通过','Adison@dev.com','2025-05-20 04:14:59',0),('3e67575c-4111-47a1-aeca-749679a68250','Adison@dev.com','用户Adison@dev.com评论了您的博客：《霍乱时期的爱情》：跨越时光的爱之百态。他说：haokan','评论','Adison@dev.com','2025-06-19 05:38:24',1),('41d4612a-3d4f-425f-b494-db88bebe9d89','Adison@dev.com','用户Adison@dev.com赞了您的博客：《霍乱时期的爱情》：跨越时光的爱之百态','点赞','Adison@dev.com','2025-07-03 11:15:35',1),('738a92b6-7413-45da-a8e8-b5850f45ebaa','Adison@dev.com','用户Adison@dev.com评论了您的博客：《霍乱时期的爱情》：跨越时光的爱之百态。他说：q确实好看','评论','Adison@dev.com','2025-06-19 05:38:35',1),('8a68ff46-769a-4d87-8f70-e84ef5b1f3fe','admin','管理员通过了您的博客：《使命召唤 21》游玩体验：战火重燃，全新征程','通过','Adison@dev.com','2025-05-20 04:14:54',0),('c6d2a09c-3292-4b4e-a1ae-7def844786af','Adison@dev.com','用户Adison@dev.com评论了您的博客：《使命召唤 21》游玩体验：战火重燃，全新征程。他说：写得真好','评论','Adison@dev.com','2025-07-03 12:17:27',0),('d8a4bb7e-1d7b-4084-b404-2095fcf9790d','admin','管理员通过了您的博客：Vue.js 中基于路由参数的博客数据获取与展示实践','通过','Adison@dev.com','2025-05-20 04:14:48',0);
/*!40000 ALTER TABLE `message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operation_log`
--

DROP TABLE IF EXISTS `operation_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `operation_log` (
  `operation_id` varchar(255) NOT NULL,
  `mail` varchar(255) NOT NULL,
  `operation_type` varchar(255) NOT NULL,
  `operation_data` text,
  `operation_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `operation_ip` varchar(45) DEFAULT NULL,
  `operation_description` text,
  `operation_result` enum('success','fail') DEFAULT NULL,
  `error_message` text,
  PRIMARY KEY (`operation_id`),
  KEY `mail` (`mail`),
  CONSTRAINT `operation_log_ibfk_1` FOREIGN KEY (`mail`) REFERENCES `user` (`mail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operation_log`
--

LOCK TABLES `operation_log` WRITE;
/*!40000 ALTER TABLE `operation_log` DISABLE KEYS */;
INSERT INTO `operation_log` VALUES ('0a691526-10d6-4ca3-8996-904b11e220c3','Adison@dev.com','修改博客','{\"blogId\":\"54a40fad-2a21-4512-9280-5994111f7228\",\"mail\":\"Adison@dev.com\",\"title\":\"《霍乱时期的爱情》：跨越时光的爱之百态\",\"content\":\"<p><span style=\\\"font-size: 29px;\\\"><strong>前言</strong></span></p><p>故事起始于一场青涩的邂逅。年轻的邮电局学徒阿里萨，在送信途中，偶然间瞥见了窗前的费尔明娜，那惊鸿一瞥，宛如一道闪电，瞬间击中了他的心，从此，爱情的种子便在他心底生根发芽。为了能多见费尔明娜几面，阿里萨每日清晨都会坐在花园长椅上假装看书，期待着她的路过；他还拉起小提琴，试图用悠扬的琴声吸引她的注意。终于，他鼓起勇气，提笔给费尔明娜写信，就这样，一封封饱含深情的信件在两人之间传递，他们沉浸在纸笔传情的甜蜜之中，将彼此视为爱情的美好象征。 ​</p><p>然而，这段美好的感情遭到了费尔明娜父亲的强烈反对。父亲为了让女儿忘却阿里萨，带着她回到家乡，这一别就是大半年。当费尔明娜再次回到熟悉的地方，再次见到阿里萨时，她却突然感到失望。曾经那个在她心中无比美好的幻影，在现实面前瞬间破碎。她惊慌地发现，自己长久以来所坚守的爱情，或许只是一场自我编织的梦，好奇心作祟下的爱情伪装被彻底撕开。此时的她，毅然决然地选择与阿里萨分手，转身投入了乌尔比诺医生的怀抱。乌尔比诺医生风度翩翩、门第显赫且知识渊博，在父亲的极力撮合下，他们结为夫妻，开启了长达六十多年的婚姻生活。 </p><p><img src=\\\"http://47.108.29.91:9000/blog/a58ab557-1c95-467d-980d-dbc31d25a77c/37029324-2cc7-49da-8279-6da7ef083aee.jpg\\\" alt=\\\"\\\" data-href=\\\"\\\" style=\\\"\\\"/></p><p><span style=\\\"font-size: 29px;\\\"><strong>章节一</strong></span></p><p>费尔明娜和乌尔比诺医生的婚后生活，如同大多数夫妻一样，充满了生活的琐碎与磨合。起初，激情在生活的磨砺下逐渐消磨，两人会因为生活中的小事互相挑剔、争吵。乌尔比诺医生会在发现衣服扣子没订好时，讽刺地说 “男人需要两个妻子，一个用来爱，一个用来订扣子”；费尔明娜也会在被丈夫搅扰清梦时，愤怒地责骂。但随着时间的推移，他们在相互斗争又相互依赖的状态中，慢慢学会了理解与包容，共同克服了生活中的种种误解和怨恨。他们一起经历了风风雨雨，在岁月的长河中，逐渐到达了一种相濡以沫的境界。直到乌尔比诺医生意外离世，费尔明娜才惊觉，自己对丈夫的爱早已深深扎根，尽管曾经有过诸多矛盾，但这份爱早已在岁月中变得深沉而浓烈。 </p><p>而被费尔明娜拒绝后的阿里萨，陷入了痛苦的深渊。为了减轻心中的创痛，他开始放纵自己，游走于众多女人之间，拥有了 622 个露水情人。但即便如此，他的内心深处始终为费尔明娜保留着一片纯净的角落，他坚信，自己要娶的人唯有费尔明娜。他在漫长的岁月里，默默地等待着，等待着命运再次给予他追求爱情的机会。终于，乌尔比诺医生的去世让阿里萨看到了希望。当晚，他便向费尔明娜表明心迹，可此时的费尔明娜正因丈夫的离世悲痛万分，面对阿里萨的表白，她怒不可遏，觉得受到了羞辱。但阿里萨并未放弃，他从激进转为退守，开始给费尔明娜写充满人生哲理的信件，渐渐地，这些信件帮助费尔明娜从悲痛中走了出来，她开始重新审视自己与阿里萨之间的感情。在时光的流转中，两人跨越了半个多世纪的鸿沟，再次找回了那份曾经失落的爱情。</p><p><img src=\\\"http://47.108.29.91:9000/blog/a58ab557-1c95-467d-980d-dbc31d25a77c/21802167-ef03-4c8f-bfda-417e00e80829.jpg\\\" alt=\\\"\\\" data-href=\\\"\\\" style=\\\"\\\"/></p><p><span style=\\\"font-size: 29px;\\\">章节二</span></p><p>这部作品中，马尔克斯不仅展现了爱情的坚韧与执着，更描绘了爱情的复杂与多面。阿里萨在肉体上的放纵与对费尔明娜精神上的忠贞形成了鲜明的对比，让人不禁思考爱情的本质究竟为何。费尔明娜从对阿里萨的幻想破灭，到与乌尔比诺医生平淡又真实的婚姻生活，再到晚年与阿里萨重燃爱火，她的情感历程充满了起伏与转变，反映出爱情在不同人生阶段的不同模样。而书中关于婚姻的诸多描述，如 “婚姻的本质上是一项荒谬的，只能靠上帝的无限仁慈才得以存在的发明，它终结于每晚做爱之后，而在第二天早餐之前又必须重新建立起来”，更是深刻地揭示了婚姻生活的现实与无奈，却又让人在其中看到了夫妻之间相互扶持的力量。​</p><p>读完《霍乱时期的爱情》，就像是经历了一场漫长的人生旅程。我们看到了爱情的诞生、成长、挫折与重生，也感受到了岁月对爱情的洗礼与磨砺。它让我们明白，爱情并非单一的模样，它可以是年轻时的热烈奔放，也可以是中年时的平淡琐碎，更可以是晚年时的深沉醇厚。无论何时何地，爱情始终是爱情，只是在不同的人生境遇中，以不同的姿态展现着它的魅力。或许，这就是马尔克斯通过这部作品想要传达给我们的关于爱情的真谛吧。正如书中所说：“无论何时何地，爱情始终都是爱情，只不过距离死亡越近，爱就越浓郁！”</p><p><img src=\\\"http://47.108.29.91:9000/blog/a58ab557-1c95-467d-980d-dbc31d25a77c/f49b4a8c-d377-4696-b18d-3224884c62ec.jpg\\\" alt=\\\"\\\" data-href=\\\"\\\" style=\\\"\\\"/></p>\",\"summary\":\"“不可避免，苦杏仁的气味总是让他想起爱情受阻后的命运。”《霍乱时期的爱情》开篇这句话，就像一把神秘的钥匙，悄然打开了那扇尘封着复杂情感的大门。马尔克斯用他那如椽巨笔，在读者面前铺展开一段横跨五十三年七个月零十一天的爱情史诗，让人沉浸于爱之百态的世界里，难以自拔。\",\"categoryId\":\"eb8bb5f5-bfec-49c5-82dc-de80b027ff9b\",\"status\":0,\"views\":0,\"likes\":0,\"comments\":0,\"createdAt\":\"2025-05-20T12:03:40\",\"publishedAt\":null,\"customTags\":\"霍乱时期的爱情,世界文学\",\"images\":\"\",\"rejectReason\":null}','2025-05-20 12:05:34','172.20.10.11','执行博客修改','success','执行修改博客成功'),('0e62f523-3647-4ce8-88b9-158a2c607100','Adison@dev.com','上传博客图片','21802167-ef03-4c8f-bfda-417e00e80829.jpg','2025-05-20 12:05:24','172.20.10.11','执行上传','success','执行上传成功'),('112898c6-88fa-469d-84d2-cd0002dd02d2','Adison@dev.com','关联博客与标签','[{\"blogId\":\"bc1b789e-39cb-4db8-9ff1-2639c539534c\",\"tagId\":\"204197bb-4311-45a3-b21b-cae669b99cda\",\"blogTagId\":\"9f37f9a4-e4c6-4b9d-8b18-61471f8601b9\"},{\"blogId\":\"bc1b789e-39cb-4db8-9ff1-2639c539534c\",\"tagId\":\"1838ee72-f3fd-42c8-ba2a-fd0e17828816\",\"blogTagId\":\"912dbe97-3f1e-4809-bac0-f03b729029a1\"}]','2025-05-21 09:29:18','192.168.227.16','执行关联博客与标签','success','关联博客与标签成功'),('23c27813-6ab8-4f0a-acd7-91728d66aa30','Adison@dev.com','上传博客','{\"blogId\":\"5d314e12-caf5-4717-847c-d3aa4e6727ea\",\"mail\":\"Adison@dev.com\",\"title\":\"1\",\"content\":\"<p>11</p>\",\"summary\":\"1\",\"categoryId\":\"35d313bd-4908-4fbb-bcaa-083f8433825e\",\"status\":0,\"views\":0,\"likes\":0,\"comments\":0,\"createdAt\":\"2025-07-03 20:16:33\",\"publishedAt\":null,\"customTags\":\"11\",\"images\":\"\",\"rejectReason\":null}','2025-07-03 20:16:33','192.168.0.104','执行上传博客','success','博客上传成功'),('2b9c34fa-1084-477b-a0fb-b0229a5cc39d','Adison@dev.com','上传博客图片','4ecbfc5d-6ff1-4e44-a8d7-fd886e871a95.jpg','2025-05-20 12:08:51','172.20.10.11','执行上传','success','执行上传成功'),('2bddda8a-b1cf-4aa9-a6bb-67ec4ec693a1','Adison@dev.com','上传博客图片','9f052506-f20f-49a6-b11b-aaf4cdcee866.png','2025-05-20 12:03:08','172.20.10.11','执行上传','success','执行上传成功'),('2cd5b6f4-b83c-42d0-953b-041a53b48b84','Adison@dev.com','关联博客与标签','[{\"blogId\":\"5d314e12-caf5-4717-847c-d3aa4e6727ea\",\"tagId\":\"204197bb-4311-45a3-b21b-cae669b99cda\",\"blogTagId\":\"efe87f88-13c5-4fba-9736-1fc17624f4c9\"}]','2025-07-03 20:16:34','192.168.0.104','执行关联博客与标签','success','关联博客与标签成功'),('3718ad39-bda5-4832-a52a-f745f8813902','Adison@dev.com','上传博客图片','37029324-2cc7-49da-8279-6da7ef083aee.jpg','2025-05-20 12:05:09','172.20.10.11','执行上传','success','执行上传成功'),('39cb2b69-dbe6-4b6c-bc3f-0530f1a58a41','Adison@dev.com','添加评论','{\"commentId\":\"d1568b71-2da7-4c5e-b05b-ccbe048086c7\",\"mail\":\"Adison@dev.com\",\"blogId\":\"39d1cdbf-775d-40d8-8ccb-6841799cc03c\",\"parentCommentId\":null,\"content\":\"写得真好\",\"commentTime\":\"2025-07-03 20:17:27\"}','2025-07-03 20:17:27','192.168.0.104','执行添加评论操作','success',''),('434670c1-604d-46ab-8140-6bdb6ada8216','Adison@dev.com','修改博客','{\"blogId\":\"4b5ce4de-e8cc-4560-a359-47a9ef7ac2a7\",\"mail\":\"Adison@dev.com\",\"title\":\"22\",\"content\":\"<p>111</p>\",\"summary\":\"313\",\"categoryId\":\"35d313bd-4908-4fbb-bcaa-083f8433825e\",\"status\":0,\"views\":0,\"likes\":0,\"comments\":0,\"createdAt\":\"2025-05-20T19:23:22\",\"publishedAt\":null,\"customTags\":\"111\",\"images\":\"\",\"rejectReason\":null}','2025-05-20 19:23:53','192.168.227.16','执行博客修改','success','执行修改博客成功'),('4dd88bdd-4b45-4d06-9d11-65108aa8fb74','Adison@dev.com','关联博客与标签','[{\"blogId\":\"e11a7e0f-f6c2-471a-b7c1-1e9d969813de\",\"tagId\":\"f669e93c-a163-401c-a35c-b5ea91a84e97\",\"blogTagId\":\"3f9ddbac-98d1-4c9e-aae7-769d3b546650\"},{\"blogId\":\"e11a7e0f-f6c2-471a-b7c1-1e9d969813de\",\"tagId\":\"8dad2072-9fec-43bc-8a7e-7e204d8a7286\",\"blogTagId\":\"f66c9b09-e057-4dc6-984e-416e91aaec83\"},{\"blogId\":\"e11a7e0f-f6c2-471a-b7c1-1e9d969813de\",\"tagId\":\"1cd42ab4-52eb-4025-a190-ef1574e20667\",\"blogTagId\":\"d95fb52f-9373-4dad-a79e-baa5907968c6\"}]','2025-05-20 12:14:23','172.20.10.11','执行关联博客与标签','success','关联博客与标签成功'),('5317d680-fcdb-4b61-a97f-97d401968b19','Adison@dev.com','关联博客与标签','[{\"blogId\":\"54a40fad-2a21-4512-9280-5994111f7228\",\"tagId\":\"8dad2072-9fec-43bc-8a7e-7e204d8a7286\",\"blogTagId\":\"d3d13016-5f3d-4b34-b4f7-161605703fbc\"},{\"blogId\":\"54a40fad-2a21-4512-9280-5994111f7228\",\"tagId\":\"7c0b6d84-4604-4da1-bdce-fddf30368f78\",\"blogTagId\":\"a518a5a2-e0f3-4c60-bcf4-cf6e083231f2\"},{\"blogId\":\"54a40fad-2a21-4512-9280-5994111f7228\",\"tagId\":\"f8d89079-2b07-4817-9545-47cb8c8992e6\",\"blogTagId\":\"815e71e4-dd3d-437a-8b51-2207213f6357\"}]','2025-05-20 12:03:41','172.20.10.11','执行关联博客与标签','success','关联博客与标签成功'),('5559a732-5191-4c62-90e6-66ebe3076ece','Adison@dev.com','修改博客','{\"blogId\":\"54a40fad-2a21-4512-9280-5994111f7228\",\"mail\":\"Adison@dev.com\",\"title\":\"《霍乱时期的爱情》：跨越时光的爱之百态\",\"content\":\"<p><span style=\\\"font-size: 29px;\\\"><strong>前言</strong></span></p><p>故事起始于一场青涩的邂逅。年轻的邮电局学徒阿里萨，在送信途中，偶然间瞥见了窗前的费尔明娜，那惊鸿一瞥，宛如一道闪电，瞬间击中了他的心，从此，爱情的种子便在他心底生根发芽。为了能多见费尔明娜几面，阿里萨每日清晨都会坐在花园长椅上假装看书，期待着她的路过；他还拉起小提琴，试图用悠扬的琴声吸引她的注意。终于，他鼓起勇气，提笔给费尔明娜写信，就这样，一封封饱含深情的信件在两人之间传递，他们沉浸在纸笔传情的甜蜜之中，将彼此视为爱情的美好象征。 ​</p><p>然而，这段美好的感情遭到了费尔明娜父亲的强烈反对。父亲为了让女儿忘却阿里萨，带着她回到家乡，这一别就是大半年。当费尔明娜再次回到熟悉的地方，再次见到阿里萨时，她却突然感到失望。曾经那个在她心中无比美好的幻影，在现实面前瞬间破碎。她惊慌地发现，自己长久以来所坚守的爱情，或许只是一场自我编织的梦，好奇心作祟下的爱情伪装被彻底撕开。此时的她，毅然决然地选择与阿里萨分手，转身投入了乌尔比诺医生的怀抱。乌尔比诺医生风度翩翩、门第显赫且知识渊博，在父亲的极力撮合下，他们结为夫妻，开启了长达六十多年的婚姻生活。 </p><p><img src=\\\"http://47.108.29.91:9000/blog/a58ab557-1c95-467d-980d-dbc31d25a77c/37029324-2cc7-49da-8279-6da7ef083aee.jpg\\\" alt=\\\"\\\" data-href=\\\"\\\" style=\\\"\\\"/></p><p><span style=\\\"font-size: 29px;\\\"><strong>章节一</strong></span></p><p>费尔明娜和乌尔比诺医生的婚后生活，如同大多数夫妻一样，充满了生活的琐碎与磨合。起初，激情在生活的磨砺下逐渐消磨，两人会因为生活中的小事互相挑剔、争吵。乌尔比诺医生会在发现衣服扣子没订好时，讽刺地说 “男人需要两个妻子，一个用来爱，一个用来订扣子”；费尔明娜也会在被丈夫搅扰清梦时，愤怒地责骂。但随着时间的推移，他们在相互斗争又相互依赖的状态中，慢慢学会了理解与包容，共同克服了生活中的种种误解和怨恨。他们一起经历了风风雨雨，在岁月的长河中，逐渐到达了一种相濡以沫的境界。直到乌尔比诺医生意外离世，费尔明娜才惊觉，自己对丈夫的爱早已深深扎根，尽管曾经有过诸多矛盾，但这份爱早已在岁月中变得深沉而浓烈。 </p><p>而被费尔明娜拒绝后的阿里萨，陷入了痛苦的深渊。为了减轻心中的创痛，他开始放纵自己，游走于众多女人之间，拥有了 622 个露水情人。但即便如此，他的内心深处始终为费尔明娜保留着一片纯净的角落，他坚信，自己要娶的人唯有费尔明娜。他在漫长的岁月里，默默地等待着，等待着命运再次给予他追求爱情的机会。终于，乌尔比诺医生的去世让阿里萨看到了希望。当晚，他便向费尔明娜表明心迹，可此时的费尔明娜正因丈夫的离世悲痛万分，面对阿里萨的表白，她怒不可遏，觉得受到了羞辱。但阿里萨并未放弃，他从激进转为退守，开始给费尔明娜写充满人生哲理的信件，渐渐地，这些信件帮助费尔明娜从悲痛中走了出来，她开始重新审视自己与阿里萨之间的感情。在时光的流转中，两人跨越了半个多世纪的鸿沟，再次找回了那份曾经失落的爱情。</p><p><img src=\\\"http://47.108.29.91:9000/blog/a58ab557-1c95-467d-980d-dbc31d25a77c/21802167-ef03-4c8f-bfda-417e00e80829.jpg\\\" alt=\\\"\\\" data-href=\\\"\\\" style=\\\"\\\"/></p><p><span style=\\\"font-size: 29px;\\\">章节二</span></p><p>这部作品中，马尔克斯不仅展现了爱情的坚韧与执着，更描绘了爱情的复杂与多面。阿里萨在肉体上的放纵与对费尔明娜精神上的忠贞形成了鲜明的对比，让人不禁思考爱情的本质究竟为何。费尔明娜从对阿里萨的幻想破灭，到与乌尔比诺医生平淡又真实的婚姻生活，再到晚年与阿里萨重燃爱火，她的情感历程充满了起伏与转变，反映出爱情在不同人生阶段的不同模样。而书中关于婚姻的诸多描述，如 “婚姻的本质上是一项荒谬的，只能靠上帝的无限仁慈才得以存在的发明，它终结于每晚做爱之后，而在第二天早餐之前又必须重新建立起来”，更是深刻地揭示了婚姻生活的现实与无奈，却又让人在其中看到了夫妻之间相互扶持的力量。​</p><p>读完《霍乱时期的爱情》，就像是经历了一场漫长的人生旅程。我们看到了爱情的诞生、成长、挫折与重生，也感受到了岁月对爱情的洗礼与磨砺。它让我们明白，爱情并非单一的模样，它可以是年轻时的热烈奔放，也可以是中年时的平淡琐碎，更可以是晚年时的深沉醇厚。无论何时何地，爱情始终是爱情，只是在不同的人生境遇中，以不同的姿态展现着它的魅力。或许，这就是马尔克斯通过这部作品想要传达给我们的关于爱情的真谛吧。正如书中所说：“无论何时何地，爱情始终都是爱情，只不过距离死亡越近，爱就越浓郁！”</p><p><img src=\\\"http://47.108.29.91:9000/blog/a58ab557-1c95-467d-980d-dbc31d25a77c/f49b4a8c-d377-4696-b18d-3224884c62ec.jpg\\\" alt=\\\"\\\" data-href=\\\"\\\" style=\\\"\\\"/></p>\",\"summary\":\"“不可避免，苦杏仁的气味总是让他想起爱情受阻后的命运。”《霍乱时期的爱情》开篇这句话，就像一把神秘的钥匙，悄然打开了那扇尘封着复杂情感的大门。马尔克斯用他那如椽巨笔，在读者面前铺展开一段横跨五十三年七个月零十一天的爱情史诗，让人沉浸于爱之百态的世界里，难以自拔。\",\"categoryId\":\"eb8bb5f5-bfec-49c5-82dc-de80b027ff9b\",\"status\":1,\"views\":0,\"likes\":0,\"comments\":0,\"createdAt\":\"2025-05-20T12:03:40\",\"publishedAt\":\"2025-05-20 12:14:59\",\"customTags\":\"霍乱时期的爱情,世界文学\",\"images\":\"\",\"rejectReason\":null}','2025-05-20 12:14:59','172.20.10.11','执行博客修改','success','执行修改博客成功'),('5808d9b0-5865-43e8-9fd9-4494fcab1abc','Adison@dev.com','上传博客图片','0286377c-de4e-4a72-84f8-8c0f13b67224.png','2025-05-20 12:03:01','172.20.10.11','执行上传','success','执行上传成功'),('58a84c95-f947-441a-a9c3-3a2f63515fd9','Adison@dev.com','修改博客','{\"blogId\":\"4b5ce4de-e8cc-4560-a359-47a9ef7ac2a7\",\"mail\":\"Adison@dev.com\",\"title\":\"22\",\"content\":\"<p>111</p>\",\"summary\":\"313\",\"categoryId\":\"35d313bd-4908-4fbb-bcaa-083f8433825e\",\"status\":3,\"views\":0,\"likes\":0,\"comments\":0,\"createdAt\":\"2025-05-20T19:23:22\",\"publishedAt\":null,\"customTags\":\"111\",\"images\":\"\",\"rejectReason\":null}','2025-05-20 19:24:00','192.168.227.16','执行博客修改','success','执行修改博客成功'),('59149ccf-78ab-41dc-a9a7-ec3a0dc6d573','Adison@dev.com','上传博客','{\"blogId\":\"54a40fad-2a21-4512-9280-5994111f7228\",\"mail\":\"Adison@dev.com\",\"title\":\"《霍乱时期的爱情》：跨越时光的爱之百态\",\"content\":\"<p><span style=\\\"font-size: 29px;\\\"><strong>前言</strong></span></p><p>故事起始于一场青涩的邂逅。年轻的邮电局学徒阿里萨，在送信途中，偶然间瞥见了窗前的费尔明娜，那惊鸿一瞥，宛如一道闪电，瞬间击中了他的心，从此，爱情的种子便在他心底生根发芽。为了能多见费尔明娜几面，阿里萨每日清晨都会坐在花园长椅上假装看书，期待着她的路过；他还拉起小提琴，试图用悠扬的琴声吸引她的注意。终于，他鼓起勇气，提笔给费尔明娜写信，就这样，一封封饱含深情的信件在两人之间传递，他们沉浸在纸笔传情的甜蜜之中，将彼此视为爱情的美好象征。 ​</p><p>然而，这段美好的感情遭到了费尔明娜父亲的强烈反对。父亲为了让女儿忘却阿里萨，带着她回到家乡，这一别就是大半年。当费尔明娜再次回到熟悉的地方，再次见到阿里萨时，她却突然感到失望。曾经那个在她心中无比美好的幻影，在现实面前瞬间破碎。她惊慌地发现，自己长久以来所坚守的爱情，或许只是一场自我编织的梦，好奇心作祟下的爱情伪装被彻底撕开。此时的她，毅然决然地选择与阿里萨分手，转身投入了乌尔比诺医生的怀抱。乌尔比诺医生风度翩翩、门第显赫且知识渊博，在父亲的极力撮合下，他们结为夫妻，开启了长达六十多年的婚姻生活。 <img src=\\\"http://47.108.29.91:9000/blog/54a40fad-2a21-4512-9280-5994111f7228/af483aed-30f3-450a-9a59-f33d5f1ffbf7.jpg\\\" alt=\\\"\\\" data-href=\\\"\\\" style=\\\"\\\"/></p><p><span style=\\\"font-size: 29px;\\\"><strong>章节一</strong></span></p><p>费尔明娜和乌尔比诺医生的婚后生活，如同大多数夫妻一样，充满了生活的琐碎与磨合。起初，激情在生活的磨砺下逐渐消磨，两人会因为生活中的小事互相挑剔、争吵。乌尔比诺医生会在发现衣服扣子没订好时，讽刺地说 “男人需要两个妻子，一个用来爱，一个用来订扣子”；费尔明娜也会在被丈夫搅扰清梦时，愤怒地责骂。但随着时间的推移，他们在相互斗争又相互依赖的状态中，慢慢学会了理解与包容，共同克服了生活中的种种误解和怨恨。他们一起经历了风风雨雨，在岁月的长河中，逐渐到达了一种相濡以沫的境界。直到乌尔比诺医生意外离世，费尔明娜才惊觉，自己对丈夫的爱早已深深扎根，尽管曾经有过诸多矛盾，但这份爱早已在岁月中变得深沉而浓烈。 </p><p>而被费尔明娜拒绝后的阿里萨，陷入了痛苦的深渊。为了减轻心中的创痛，他开始放纵自己，游走于众多女人之间，拥有了 622 个露水情人。但即便如此，他的内心深处始终为费尔明娜保留着一片纯净的角落，他坚信，自己要娶的人唯有费尔明娜。他在漫长的岁月里，默默地等待着，等待着命运再次给予他追求爱情的机会。终于，乌尔比诺医生的去世让阿里萨看到了希望。当晚，他便向费尔明娜表明心迹，可此时的费尔明娜正因丈夫的离世悲痛万分，面对阿里萨的表白，她怒不可遏，觉得受到了羞辱。但阿里萨并未放弃，他从激进转为退守，开始给费尔明娜写充满人生哲理的信件，渐渐地，这些信件帮助费尔明娜从悲痛中走了出来，她开始重新审视自己与阿里萨之间的感情。在时光的流转中，两人跨越了半个多世纪的鸿沟，再次找回了那份曾经失落的爱情。</p><p><span style=\\\"font-size: 29px;\\\">章节二</span></p><p>这部作品中，马尔克斯不仅展现了爱情的坚韧与执着，更描绘了爱情的复杂与多面。阿里萨在肉体上的放纵与对费尔明娜精神上的忠贞形成了鲜明的对比，让人不禁思考爱情的本质究竟为何。费尔明娜从对阿里萨的幻想破灭，到与乌尔比诺医生平淡又真实的婚姻生活，再到晚年与阿里萨重燃爱火，她的情感历程充满了起伏与转变，反映出爱情在不同人生阶段的不同模样。而书中关于婚姻的诸多描述，如 “婚姻的本质上是一项荒谬的，只能靠上帝的无限仁慈才得以存在的发明，它终结于每晚做爱之后，而在第二天早餐之前又必须重新建立起来”，更是深刻地揭示了婚姻生活的现实与无奈，却又让人在其中看到了夫妻之间相互扶持的力量。​</p><p>读完《霍乱时期的爱情》，就像是经历了一场漫长的人生旅程。我们看到了爱情的诞生、成长、挫折与重生，也感受到了岁月对爱情的洗礼与磨砺。它让我们明白，爱情并非单一的模样，它可以是年轻时的热烈奔放，也可以是中年时的平淡琐碎，更可以是晚年时的深沉醇厚。无论何时何地，爱情始终是爱情，只是在不同的人生境遇中，以不同的姿态展现着它的魅力。或许，这就是马尔克斯通过这部作品想要传达给我们的关于爱情的真谛吧。正如书中所说：“无论何时何地，爱情始终都是爱情，只不过距离死亡越近，爱就越浓郁！”</p>\",\"summary\":\"“不可避免，苦杏仁的气味总是让他想起爱情受阻后的命运。”《霍乱时期的爱情》开篇这句话，就像一把神秘的钥匙，悄然打开了那扇尘封着复杂情感的大门。马尔克斯用他那如椽巨笔，在读者面前铺展开一段横跨五十三年七个月零十一天的爱情史诗，让人沉浸于爱之百态的世界里，难以自拔。\",\"categoryId\":\"eb8bb5f5-bfec-49c5-82dc-de80b027ff9b\",\"status\":3,\"views\":0,\"likes\":0,\"comments\":0,\"createdAt\":\"2025-05-20 12:03:40\",\"publishedAt\":null,\"customTags\":\"霍乱时期的爱情,世界文学\",\"images\":\"\",\"rejectReason\":null}','2025-05-20 12:03:40','172.20.10.11','执行上传博客','success','博客上传成功'),('6225f71c-185b-4232-b7ba-acd2004d0bca','Adison@dev.com','关联博客与标签','[{\"blogId\":\"4b5ce4de-e8cc-4560-a359-47a9ef7ac2a7\",\"tagId\":\"1cd42ab4-52eb-4025-a190-ef1574e20667\",\"blogTagId\":\"38a27793-ef72-4642-a99e-952a27f482df\"}]','2025-05-20 19:23:22','192.168.227.16','执行关联博客与标签','success','关联博客与标签成功'),('67a09439-8127-414a-8abe-0cadb33480c0','Adison@dev.com','修改博客','{\"blogId\":\"e11a7e0f-f6c2-471a-b7c1-1e9d969813de\",\"mail\":\"Adison@dev.com\",\"title\":\"Vue.js 中基于路由参数的博客数据获取与展示实践\",\"content\":\"<p><span style=\\\"font-size: 22px;\\\"><strong>代码概览与核心功能​</strong></span></p><p>先来看以下代码片段：</p><pre><code class=\\\"language-typescript\\\">const route = useRoute()\\r\\nconst mail = sessionStorage.getItem(\'mail\')\\r\\ninterface Tag {\\r\\n    color: string\\r\\n    description: string\\r\\n    name: string\\r\\n    tagId: string\\r\\n}\\r\\ninterface Blog {\\r\\n    blogId: string\\r\\n    categoryId: string\\r\\n    comments: number\\r\\n    content: string\\r\\n    createdAt: string\\r\\n    customTags: string\\r\\n    images: string\\r\\n    likes: number\\r\\n    mail: string\\r\\n    name: string\\r\\n    nickname: string\\r\\n    publishedAt: string\\r\\n    status: number\\r\\n    summary: string\\r\\n    title: string\\r\\n    views: string\\r\\n    userId: string\\r\\n    photo: string\\r\\n    tags: Tag[]\\r\\n}\\r\\nconst thisBlog = ref&lt;Blog&gt;()\\r\\nonMounted(async () =&gt; {\\r\\n    alert(\'你好\')\\r\\n    const res = await getBlogAPI({ blogId: route.query.blogId })\\r\\n    thisBlog.value = res[0]\\r\\n})</code></pre><p><br></p>\",\"summary\":\"在前端开发中，根据路由参数动态获取并展示数据是常见的业务需求。本文将结合具体代码，深入剖析如何在 Vue.js 项目中，基于路由参数获取博客数据并进行展示，同时探讨其中涉及的技术要点与实现细节。\",\"categoryId\":\"eb8bb5f5-bfec-49c5-82dc-de80b027ff9b\",\"status\":1,\"views\":0,\"likes\":0,\"comments\":0,\"createdAt\":\"2025-05-20T12:14:23\",\"publishedAt\":\"2025-05-20 12:14:48\",\"customTags\":\"编程,vue3,ts\",\"images\":\"\",\"rejectReason\":null}','2025-05-20 12:14:48','172.20.10.11','执行博客修改','success','执行修改博客成功'),('6cd52714-e96a-4201-8790-e29dc8d2b567','Adison@dev.com','上传博客','{\"blogId\":\"39d1cdbf-775d-40d8-8ccb-6841799cc03c\",\"mail\":\"Adison@dev.com\",\"title\":\"《使命召唤 21》游玩体验：战火重燃，全新征程\",\"content\":\"<p><span style=\\\"font-size: 24px;\\\"><strong>剧情：深入复杂的冷战阴谋​</strong></span></p><p>《黑色行动 6》的剧情延续了该系列一贯的紧张刺激风格，将玩家带回到了 1991 年的海湾战争时期。玩家扮演的 CIA 特工 “凯斯”，在这个动荡的时代背景下，卷入了一场错综复杂的阴谋之中。游戏开场，便是一场紧张刺激的营救行动，玩家需要和队友们一起，在枪林弹雨中解救叛变的伊拉克国防部长赛义德・阿拉维。然而，事情远没有那么简单，在行动过程中，玩家小队遭遇了神秘私人军事组织 “万神殿” 的袭击，这群装备精良、训练有素的敌人，给玩家带来了极大的挑战。​</p><p>随着剧情的推进，玩家会发现 CIA 内部似乎也存在着 “内鬼”，前作中的经典角色阿德勒，竟然在关键时刻倒戈，一枪击毙了玩家保护的 VIP。这一情节的反转，瞬间让玩家陷入了迷茫与困惑之中，也让整个故事变得更加扑朔迷离。为了揭开事件的真相，玩家不得不与小队成员一起选择 “叛逃”，开始了一段充满未知与危险的调查之旅。​</p><p><img src=\\\"http://47.108.29.91:9000/blog/39d1cdbf-775d-40d8-8ccb-6841799cc03c/4ecbfc5d-6ff1-4e44-a8d7-fd886e871a95.jpg\\\" alt=\\\"\\\" data-href=\\\"\\\" style=\\\"\\\"/></p><p>在剧情模式中，游戏还引入了 “安全屋” 系统。安全屋不仅是玩家在任务间隙的休息场所，更是一个充满解谜元素的地方。玩家可以在安全屋内与小队成员交流，获取情报，还能通过解谜任务寻找隐藏的宝物。这些解谜任务难度适中，既不会让玩家感到过于困难而放弃，也不会过于简单而失去乐趣。例如，在安全屋的一个角落，可能隐藏着一个需要特定密码才能打开的箱子，而密码的线索则隐藏在房间内的各种物品和文件之中，玩家需要仔细观察、思考，才能解开谜题，获得奖励。这种解谜元素的加入，为传统的射击游戏剧情模式增添了一份别样的乐趣，让玩家在紧张刺激的战斗之余，也能体验到探索和解谜的成就感。 </p><p><span style=\\\"font-size: 24px;\\\"><strong>特色玩法：全向移动带来新体验​</strong></span></p><p>《使命召唤 21》最引人注目的特色玩法之一，当属全新加入的 “全向移动” 功能。这个功能允许玩家在面部朝向不变的情况下，自由地向前后左右四个方向奔跑和做出战术动作，极大地提升了角色的机动性。在实际游戏过程中，这种全向移动的操作方式给我带来了一种前所未有的新鲜感。以往在射击游戏中，角色的移动方向往往受到一定限制，而 “全向移动” 打破了这种束缚，让我能够更加灵活地应对各种复杂的战斗场景。​</p><p>例如，在一场激烈的对战中，我可以利用全向移动迅速侧身躲避敌人的攻击，同时还能保持枪口对准敌人，进行反击。或者在需要快速转移阵地时，直接向后奔跑，而无需像以往那样先转身再移动，大大节省了时间，提高了生存几率。不过，这种全新的移动机制也并非完美无缺。由于其操作方式与传统 FPS 游戏有所不同，需要一定的时间来适应。在刚开始游玩时，我经常会因为操作失误而陷入尴尬的境地，比如在紧张的战斗中，误按了全向移动的按键，导致角色朝着错误的方向移动，从而错失战机。但随着游戏时间的增加，逐渐熟悉了这种操作方式后，我开始真正体会到它的魅力所在。 </p><p><span style=\\\"font-size: 24px;\\\"><strong>武器系统：丰富多样，各有千秋​</strong></span></p><p>《使命召唤》系列的武器系统一直以来都备受玩家喜爱，《使命召唤 21》也不例外。本作中，武器种类繁多，涵盖了手枪、冲锋枪、步枪、机枪等各种类型，而且其中不乏一些首次出现在 COD 系列中的新武器。​</p><p>手枪方面，以 USP 为原型的 “GS45” 成为了西方阵营角色的标配手枪，它虽然弹匣容量被缩减到了 10 发，但在稳定性和射击精度上表现出色。而伊拉克军队和犯罪分子则使用马卡洛夫 PM 手枪，这种手枪以其可靠性和强大的近距离杀伤力而闻名。此外，斯捷奇金 APS 冲锋手枪的加入，也为喜欢手枪冲锋的玩家提供了更多选择。​</p><p>冲锋枪在游戏中扮演着重要的角色，智利 FAMAE SAF 冲锋枪就是本作的标志性武器之一。它独特的外观和较高的射速，使其在近距离战斗中具有很强的压制力，无论是犯罪组织还是 “万神殿” 士兵都对其青睐有加。值得一提的是，SAF 冲锋枪实际上是 1993 年才设计出来的，在游戏中属于 “穿越” 武器，这也为游戏增添了一份别样的趣味。除了 SAF 冲锋枪，PP-90M1 冲锋枪在《现代战争 3》之后首次回归，它那独特的螺旋弹筒设计，让人一眼就能认出它。</p><p>步枪种类同样丰富，经典的 AR-18 自动步枪和西班牙 CETME-L 自动步枪首次加入，为玩家提供了更多的选择。AR-18 虽然没有被大量国家采购，但它的设计思路影响了众多经典武器。CETME-L 作为西班牙军队的制式步枪，在游戏中也展现出了其独特的性能。当然，游戏中也少不了玩家们熟悉的 “XM4” 步枪，不过这里的 XM4 并非现实中的 XM4 或 M4，而是 M4 定型之前美军特种部队常用的柯尔特 723 卡宾枪。​</p><p>此外，游戏中还加入了一些极为冷门的武器，如 AR-10 机枪型、PU-21 轻机枪、格伦德尔 P-30 手枪、R-31 卡宾枪等等。这些武器有的是罕见的实验武器，有的是冷门的民用枪支，它们的加入，极大地丰富了游戏的武器库，满足了不同玩家对于武器的个性化需求。而且，游戏中的武器模型制作精美，细节处理非常到位，每一把武器都仿佛是一件艺术品，让人爱不释手。无论是武器的外观质感，还是射击时的音效和后坐力反馈，都给玩家带来了非常逼真的体验，仿佛真的置身于战场之中，手持各种先进武器与敌人展开激烈对抗。​</p><p><span style=\\\"font-size: 24px;\\\"><strong>多人游戏：激烈对战，乐趣无穷​</strong></span></p><p>多人游戏模式一直是《使命召唤》系列的核心玩法之一，《使命召唤 21》也不例外。在多人游戏中，玩家将在 16 张精心设计的新地图上与其他玩家展开激烈对战，其中包括 12 张核心 6v6 地图和 4 张可以 2v2 或 6v6 玩的 Strike 地图。这些地图风格各异，有的是繁华的商业街，有的是废弃的工厂，还有的是充满异域风情的小镇。每一张地图都有着独特的地形和建筑布局，为玩家提供了丰富多样的战术选择。​</p><p>例如，在 “列车坟场” 这张地图中，地图结构紧凑复杂，到处都是废弃的列车车厢和集装箱，玩家可以利用这些障碍物进行隐蔽和伏击，也可以通过灵活的走位和团队配合，突破敌人的防线。而在 “商业街” 地图中，由于地图面积较大，玩家需要更加注重团队协作和战略规划，合理分配兵力，控制重要据点，才能在战斗中取得优势。​</p><p><img src=\\\"http://47.108.29.91:9000/blog/39d1cdbf-775d-40d8-8ccb-6841799cc03c/740360d6-305b-44a1-bd82-2b45c0d838d4.jpg\\\" alt=\\\"\\\" data-href=\\\"\\\" style=\\\"\\\"/></p><p>除了多样化的地图，游戏还回归了传统的声望系统。玩家在游戏中通过完成各种任务、击杀敌人、获得胜利等方式获取经验值，提升等级。随着等级的提升，玩家可以解锁更多的武器、装备和技能，从而根据自己的游戏风格和喜好进行个性化的搭配。这种声望系统的回归，让玩家在游戏中有了明确的目标和成长感，激励着玩家不断地投入到游戏中，提升自己的实力。 【配图 4：展示一张多人游戏中激烈对战的截图，画面中玩家们在地图中穿梭，枪火纷飞，充满紧张感】​</p><p><span style=\\\"font-size: 24px;\\\"><strong>总结：瑕不掩瑜的射击佳作​</strong></span></p><p>总的来说，《使命召唤 21：黑色行动 6》给我带来了一段非常精彩的游戏体验。它在剧情、特色玩法、武器系统和多人游戏等方面都有着出色的表现，为玩家呈现了一个紧张刺激、丰富多彩的战争世界。虽然在游戏过程中，也存在一些小问题，比如武器平衡性方面，“胡狼” 冲锋枪在游戏初期表现过于强势，影响了部分游戏体验；地图设计上，个别地图存在地形不合理或面积过大过小等问题。但这些小瑕疵并不能掩盖游戏的光芒，相信随着游戏的不断更新和优化，这些问题都将得到妥善解决。​</p><p>如果你是一名射击游戏爱好者，那么《使命召唤 21》绝对值得你一试。它将带你重回战火纷飞的年代，体验一场紧张刺激、充满挑战的射击盛宴，让你在游戏中感受到战争的残酷与热血，同时也能享受到团队协作和胜利带来的喜悦。快来加入这场全新的使命召唤之旅吧，拿起武器，与队友们一起并肩作战，书写属于自己的战争传奇！​<br></p>\",\"summary\":\"​\\r\\n​\\r\\n​\\r\\n​\\r\\n​\\r\\n当《使命召唤》系列的第 21 部作品 ——《使命召唤 21：黑色行动 6》呈现在玩家面前时，它无疑再次点燃了玩家们对射击游戏的热情。作为该系列的忠实粉丝，我迫不及待地投身其中，开启了一场惊心动魄的游戏之旅，现在就来和大家分享一下我的游玩体验。\",\"categoryId\":\"68b9e4b2-df52-4599-a777-03b608d05322\",\"status\":0,\"views\":0,\"likes\":0,\"comments\":0,\"createdAt\":\"2025-05-20 12:09:23\",\"publishedAt\":null,\"customTags\":\"cod,call of duty,使命召唤21\",\"images\":\"\",\"rejectReason\":null}','2025-05-20 12:09:23','172.20.10.11','执行上传博客','success','博客上传成功'),('9345ec41-7e01-4a85-9294-0c97e1aa6d11','Adison@dev.com','上传博客图片','8f7e014e-5d5e-4c06-a92f-12874c170c74.jpg','2025-05-20 12:04:03','172.20.10.11','执行上传','success','执行上传成功'),('94eac221-18ff-4000-849c-56ed4a9a49d2','Adison@dev.com','上传博客图片','f49b4a8c-d377-4696-b18d-3224884c62ec.jpg','2025-05-20 12:05:32','172.20.10.11','执行上传','success','执行上传成功'),('a539bdaa-e469-49dd-8c17-45cf0667e53d','Adison@dev.com','修改博客','{\"blogId\":\"39d1cdbf-775d-40d8-8ccb-6841799cc03c\",\"mail\":\"Adison@dev.com\",\"title\":\"《使命召唤 21》游玩体验：战火重燃，全新征程\",\"content\":\"<p><span style=\\\"font-size: 24px;\\\"><strong>剧情：深入复杂的冷战阴谋​</strong></span></p><p>《黑色行动 6》的剧情延续了该系列一贯的紧张刺激风格，将玩家带回到了 1991 年的海湾战争时期。玩家扮演的 CIA 特工 “凯斯”，在这个动荡的时代背景下，卷入了一场错综复杂的阴谋之中。游戏开场，便是一场紧张刺激的营救行动，玩家需要和队友们一起，在枪林弹雨中解救叛变的伊拉克国防部长赛义德・阿拉维。然而，事情远没有那么简单，在行动过程中，玩家小队遭遇了神秘私人军事组织 “万神殿” 的袭击，这群装备精良、训练有素的敌人，给玩家带来了极大的挑战。​</p><p>随着剧情的推进，玩家会发现 CIA 内部似乎也存在着 “内鬼”，前作中的经典角色阿德勒，竟然在关键时刻倒戈，一枪击毙了玩家保护的 VIP。这一情节的反转，瞬间让玩家陷入了迷茫与困惑之中，也让整个故事变得更加扑朔迷离。为了揭开事件的真相，玩家不得不与小队成员一起选择 “叛逃”，开始了一段充满未知与危险的调查之旅。​</p><p><img src=\\\"http://47.108.29.91:9000/blog/39d1cdbf-775d-40d8-8ccb-6841799cc03c/4ecbfc5d-6ff1-4e44-a8d7-fd886e871a95.jpg\\\" alt=\\\"\\\" data-href=\\\"\\\" style=\\\"\\\"/></p><p>在剧情模式中，游戏还引入了 “安全屋” 系统。安全屋不仅是玩家在任务间隙的休息场所，更是一个充满解谜元素的地方。玩家可以在安全屋内与小队成员交流，获取情报，还能通过解谜任务寻找隐藏的宝物。这些解谜任务难度适中，既不会让玩家感到过于困难而放弃，也不会过于简单而失去乐趣。例如，在安全屋的一个角落，可能隐藏着一个需要特定密码才能打开的箱子，而密码的线索则隐藏在房间内的各种物品和文件之中，玩家需要仔细观察、思考，才能解开谜题，获得奖励。这种解谜元素的加入，为传统的射击游戏剧情模式增添了一份别样的乐趣，让玩家在紧张刺激的战斗之余，也能体验到探索和解谜的成就感。 </p><p><span style=\\\"font-size: 24px;\\\"><strong>特色玩法：全向移动带来新体验​</strong></span></p><p>《使命召唤 21》最引人注目的特色玩法之一，当属全新加入的 “全向移动” 功能。这个功能允许玩家在面部朝向不变的情况下，自由地向前后左右四个方向奔跑和做出战术动作，极大地提升了角色的机动性。在实际游戏过程中，这种全向移动的操作方式给我带来了一种前所未有的新鲜感。以往在射击游戏中，角色的移动方向往往受到一定限制，而 “全向移动” 打破了这种束缚，让我能够更加灵活地应对各种复杂的战斗场景。​</p><p>例如，在一场激烈的对战中，我可以利用全向移动迅速侧身躲避敌人的攻击，同时还能保持枪口对准敌人，进行反击。或者在需要快速转移阵地时，直接向后奔跑，而无需像以往那样先转身再移动，大大节省了时间，提高了生存几率。不过，这种全新的移动机制也并非完美无缺。由于其操作方式与传统 FPS 游戏有所不同，需要一定的时间来适应。在刚开始游玩时，我经常会因为操作失误而陷入尴尬的境地，比如在紧张的战斗中，误按了全向移动的按键，导致角色朝着错误的方向移动，从而错失战机。但随着游戏时间的增加，逐渐熟悉了这种操作方式后，我开始真正体会到它的魅力所在。 </p><p><span style=\\\"font-size: 24px;\\\"><strong>武器系统：丰富多样，各有千秋​</strong></span></p><p>《使命召唤》系列的武器系统一直以来都备受玩家喜爱，《使命召唤 21》也不例外。本作中，武器种类繁多，涵盖了手枪、冲锋枪、步枪、机枪等各种类型，而且其中不乏一些首次出现在 COD 系列中的新武器。​</p><p>手枪方面，以 USP 为原型的 “GS45” 成为了西方阵营角色的标配手枪，它虽然弹匣容量被缩减到了 10 发，但在稳定性和射击精度上表现出色。而伊拉克军队和犯罪分子则使用马卡洛夫 PM 手枪，这种手枪以其可靠性和强大的近距离杀伤力而闻名。此外，斯捷奇金 APS 冲锋手枪的加入，也为喜欢手枪冲锋的玩家提供了更多选择。​</p><p>冲锋枪在游戏中扮演着重要的角色，智利 FAMAE SAF 冲锋枪就是本作的标志性武器之一。它独特的外观和较高的射速，使其在近距离战斗中具有很强的压制力，无论是犯罪组织还是 “万神殿” 士兵都对其青睐有加。值得一提的是，SAF 冲锋枪实际上是 1993 年才设计出来的，在游戏中属于 “穿越” 武器，这也为游戏增添了一份别样的趣味。除了 SAF 冲锋枪，PP-90M1 冲锋枪在《现代战争 3》之后首次回归，它那独特的螺旋弹筒设计，让人一眼就能认出它。</p><p>步枪种类同样丰富，经典的 AR-18 自动步枪和西班牙 CETME-L 自动步枪首次加入，为玩家提供了更多的选择。AR-18 虽然没有被大量国家采购，但它的设计思路影响了众多经典武器。CETME-L 作为西班牙军队的制式步枪，在游戏中也展现出了其独特的性能。当然，游戏中也少不了玩家们熟悉的 “XM4” 步枪，不过这里的 XM4 并非现实中的 XM4 或 M4，而是 M4 定型之前美军特种部队常用的柯尔特 723 卡宾枪。​</p><p>此外，游戏中还加入了一些极为冷门的武器，如 AR-10 机枪型、PU-21 轻机枪、格伦德尔 P-30 手枪、R-31 卡宾枪等等。这些武器有的是罕见的实验武器，有的是冷门的民用枪支，它们的加入，极大地丰富了游戏的武器库，满足了不同玩家对于武器的个性化需求。而且，游戏中的武器模型制作精美，细节处理非常到位，每一把武器都仿佛是一件艺术品，让人爱不释手。无论是武器的外观质感，还是射击时的音效和后坐力反馈，都给玩家带来了非常逼真的体验，仿佛真的置身于战场之中，手持各种先进武器与敌人展开激烈对抗。​</p><p><span style=\\\"font-size: 24px;\\\"><strong>多人游戏：激烈对战，乐趣无穷​</strong></span></p><p>多人游戏模式一直是《使命召唤》系列的核心玩法之一，《使命召唤 21》也不例外。在多人游戏中，玩家将在 16 张精心设计的新地图上与其他玩家展开激烈对战，其中包括 12 张核心 6v6 地图和 4 张可以 2v2 或 6v6 玩的 Strike 地图。这些地图风格各异，有的是繁华的商业街，有的是废弃的工厂，还有的是充满异域风情的小镇。每一张地图都有着独特的地形和建筑布局，为玩家提供了丰富多样的战术选择。​</p><p>例如，在 “列车坟场” 这张地图中，地图结构紧凑复杂，到处都是废弃的列车车厢和集装箱，玩家可以利用这些障碍物进行隐蔽和伏击，也可以通过灵活的走位和团队配合，突破敌人的防线。而在 “商业街” 地图中，由于地图面积较大，玩家需要更加注重团队协作和战略规划，合理分配兵力，控制重要据点，才能在战斗中取得优势。​</p><p><img src=\\\"http://47.108.29.91:9000/blog/39d1cdbf-775d-40d8-8ccb-6841799cc03c/740360d6-305b-44a1-bd82-2b45c0d838d4.jpg\\\" alt=\\\"\\\" data-href=\\\"\\\" style=\\\"\\\"/></p><p>除了多样化的地图，游戏还回归了传统的声望系统。玩家在游戏中通过完成各种任务、击杀敌人、获得胜利等方式获取经验值，提升等级。随着等级的提升，玩家可以解锁更多的武器、装备和技能，从而根据自己的游戏风格和喜好进行个性化的搭配。这种声望系统的回归，让玩家在游戏中有了明确的目标和成长感，激励着玩家不断地投入到游戏中，提升自己的实力。 【配图 4：展示一张多人游戏中激烈对战的截图，画面中玩家们在地图中穿梭，枪火纷飞，充满紧张感】​</p><p><span style=\\\"font-size: 24px;\\\"><strong>总结：瑕不掩瑜的射击佳作​</strong></span></p><p>总的来说，《使命召唤 21：黑色行动 6》给我带来了一段非常精彩的游戏体验。它在剧情、特色玩法、武器系统和多人游戏等方面都有着出色的表现，为玩家呈现了一个紧张刺激、丰富多彩的战争世界。虽然在游戏过程中，也存在一些小问题，比如武器平衡性方面，“胡狼” 冲锋枪在游戏初期表现过于强势，影响了部分游戏体验；地图设计上，个别地图存在地形不合理或面积过大过小等问题。但这些小瑕疵并不能掩盖游戏的光芒，相信随着游戏的不断更新和优化，这些问题都将得到妥善解决。​</p><p>如果你是一名射击游戏爱好者，那么《使命召唤 21》绝对值得你一试。它将带你重回战火纷飞的年代，体验一场紧张刺激、充满挑战的射击盛宴，让你在游戏中感受到战争的残酷与热血，同时也能享受到团队协作和胜利带来的喜悦。快来加入这场全新的使命召唤之旅吧，拿起武器，与队友们一起并肩作战，书写属于自己的战争传奇！​<br></p>\",\"summary\":\"​\\r\\n​\\r\\n​\\r\\n​\\r\\n​\\r\\n当《使命召唤》系列的第 21 部作品 ——《使命召唤 21：黑色行动 6》呈现在玩家面前时，它无疑再次点燃了玩家们对射击游戏的热情。作为该系列的忠实粉丝，我迫不及待地投身其中，开启了一场惊心动魄的游戏之旅，现在就来和大家分享一下我的游玩体验。\",\"categoryId\":\"68b9e4b2-df52-4599-a777-03b608d05322\",\"status\":1,\"views\":0,\"likes\":0,\"comments\":0,\"createdAt\":\"2025-05-20T12:09:23\",\"publishedAt\":\"2025-05-20 12:14:54\",\"customTags\":\"cod,call of duty,使命召唤21\",\"images\":\"\",\"rejectReason\":null}','2025-05-20 12:14:54','172.20.10.11','执行博客修改','success','执行修改博客成功'),('b68cc474-5e42-40b9-b313-74f3ba8b9d17','Adison@dev.com','关联博客与标签','[{\"blogId\":\"39d1cdbf-775d-40d8-8ccb-6841799cc03c\",\"tagId\":\"1838ee72-f3fd-42c8-ba2a-fd0e17828816\",\"blogTagId\":\"64055ab8-00fd-4a27-9c12-f87f2015a768\"},{\"blogId\":\"39d1cdbf-775d-40d8-8ccb-6841799cc03c\",\"tagId\":\"1cd42ab4-52eb-4025-a190-ef1574e20667\",\"blogTagId\":\"87acdec5-944c-4eb4-915b-b8c79c5ce294\"},{\"blogId\":\"39d1cdbf-775d-40d8-8ccb-6841799cc03c\",\"tagId\":\"f8d89079-2b07-4817-9545-47cb8c8992e6\",\"blogTagId\":\"84c65721-e7cd-4943-bdc7-e718e7e2878b\"}]','2025-05-20 12:09:23','172.20.10.11','执行关联博客与标签','success','关联博客与标签成功'),('b7b8dab8-8eef-407b-9793-634507b87794','Adison@dev.com','关联博客与标签','[]','2025-05-20 19:22:04','192.168.227.16','执行关联博客与标签','success','关联博客与标签成功'),('b7ce1d64-a0f7-44a7-b21a-2b8bd235d5c3','Adison@dev.com','上传博客','{\"blogId\":\"bc1b789e-39cb-4db8-9ff1-2639c539534c\",\"mail\":\"Adison@dev.com\",\"title\":\"1\",\"content\":\"<p>222</p>\",\"summary\":\"2\",\"categoryId\":\"35d313bd-4908-4fbb-bcaa-083f8433825e\",\"status\":3,\"views\":0,\"likes\":0,\"comments\":0,\"createdAt\":\"2025-05-21 09:29:18\",\"publishedAt\":null,\"customTags\":\"1\",\"images\":\"\",\"rejectReason\":null}','2025-05-21 09:29:18','192.168.227.16','执行上传博客','success','博客上传成功'),('b9dbda1c-9fee-450c-9b9b-896f15848f3f','Adison@dev.com','修改博客','{\"blogId\":\"4b5ce4de-e8cc-4560-a359-47a9ef7ac2a7\",\"mail\":\"Adison@dev.com\",\"title\":\"22\",\"content\":\"<p>111</p>\",\"summary\":\"313\",\"categoryId\":\"35d313bd-4908-4fbb-bcaa-083f8433825e\",\"status\":0,\"views\":0,\"likes\":0,\"comments\":0,\"createdAt\":\"2025-05-20T19:23:22\",\"publishedAt\":null,\"customTags\":\"111\",\"images\":\"\",\"rejectReason\":null}','2025-05-20 19:23:46','192.168.227.16','执行博客修改','success','执行修改博客成功'),('ba90f9b8-5be7-4906-accc-d532b34d86e9','Adison@dev.com','上传博客','{\"blogId\":\"383de3b3-1d33-4275-8d19-eba751a5debd\",\"mail\":\"Adison@dev.com\",\"title\":\"1\",\"content\":\"<p>111</p>\",\"summary\":\"231\",\"categoryId\":\"35d313bd-4908-4fbb-bcaa-083f8433825e\",\"status\":0,\"views\":0,\"likes\":0,\"comments\":0,\"createdAt\":\"2025-05-20 19:22:04\",\"publishedAt\":null,\"customTags\":\"11\",\"images\":\"\",\"rejectReason\":null}','2025-05-20 19:22:04','192.168.227.16','执行上传博客','success','博客上传成功'),('bff09c61-4b3e-4c78-b3fb-eb2423c6f9ce','Adison@dev.com','添加评论','{\"commentId\":\"bbbf1b23-6428-472e-957d-2e2f4b9b273a\",\"mail\":\"Adison@dev.com\",\"blogId\":\"54a40fad-2a21-4512-9280-5994111f7228\",\"parentCommentId\":\"619cf9c8-6a19-46dc-a030-8cd69d6154ec\",\"content\":\"q确实好看\",\"commentTime\":\"2025-06-19 13:38:35\"}','2025-06-19 13:38:35','192.168.182.16','执行添加评论操作','success',''),('c0f7eec0-90d6-4f10-bbfd-3cdc36fc0fac','Adison@dev.com','上传博客图片','740360d6-305b-44a1-bd82-2b45c0d838d4.jpg','2025-05-20 12:09:20','172.20.10.11','执行上传','success','执行上传成功'),('c109832c-9b43-4db2-b147-88d335670d6c','Adison@dev.com','上传博客图片','af483aed-30f3-450a-9a59-f33d5f1ffbf7.jpg','2025-05-20 12:03:23','172.20.10.11','执行上传','success','执行上传成功'),('c1c9bba9-7ed2-48e3-a096-b09add408d42','Adison@dev.com','关联博客与标签','[]','2025-05-20 19:19:45','192.168.227.16','执行关联博客与标签','success','关联博客与标签成功'),('d4947c9b-a325-4b6e-bc68-7baafbe8fa94','Adison@dev.com','上传博客','{\"blogId\":\"e1dbe2a7-6c0d-4642-81d8-8ac360d3c45b\",\"mail\":\"Adison@dev.com\",\"title\":\"11\",\"content\":\"<p>111</p>\",\"summary\":\"11\",\"categoryId\":\"316af61a-f8e0-42be-bfb3-de7155cd1c1f\",\"status\":0,\"views\":0,\"likes\":0,\"comments\":0,\"createdAt\":\"2025-05-20 19:19:45\",\"publishedAt\":null,\"customTags\":\"111\",\"images\":\"\",\"rejectReason\":null}','2025-05-20 19:19:45','192.168.227.16','执行上传博客','success','博客上传成功'),('d72baa7f-dbd1-4091-9cda-4c190088fc03','Adison@dev.com','上传博客','{\"blogId\":\"4b5ce4de-e8cc-4560-a359-47a9ef7ac2a7\",\"mail\":\"Adison@dev.com\",\"title\":\"22\",\"content\":\"<p>111</p>\",\"summary\":\"313\",\"categoryId\":\"35d313bd-4908-4fbb-bcaa-083f8433825e\",\"status\":0,\"views\":0,\"likes\":0,\"comments\":0,\"createdAt\":\"2025-05-20 19:23:22\",\"publishedAt\":null,\"customTags\":\"111\",\"images\":\"\",\"rejectReason\":null}','2025-05-20 19:23:22','192.168.227.16','执行上传博客','success','博客上传成功'),('e186566b-03fa-4f22-9b85-1be7953ecca5','Adison@dev.com','上传博客','{\"blogId\":\"e11a7e0f-f6c2-471a-b7c1-1e9d969813de\",\"mail\":\"Adison@dev.com\",\"title\":\"Vue.js 中基于路由参数的博客数据获取与展示实践\",\"content\":\"<p><span style=\\\"font-size: 22px;\\\"><strong>代码概览与核心功能​</strong></span></p><p>先来看以下代码片段：</p><pre><code class=\\\"language-typescript\\\">const route = useRoute()\\r\\nconst mail = sessionStorage.getItem(\'mail\')\\r\\ninterface Tag {\\r\\n    color: string\\r\\n    description: string\\r\\n    name: string\\r\\n    tagId: string\\r\\n}\\r\\ninterface Blog {\\r\\n    blogId: string\\r\\n    categoryId: string\\r\\n    comments: number\\r\\n    content: string\\r\\n    createdAt: string\\r\\n    customTags: string\\r\\n    images: string\\r\\n    likes: number\\r\\n    mail: string\\r\\n    name: string\\r\\n    nickname: string\\r\\n    publishedAt: string\\r\\n    status: number\\r\\n    summary: string\\r\\n    title: string\\r\\n    views: string\\r\\n    userId: string\\r\\n    photo: string\\r\\n    tags: Tag[]\\r\\n}\\r\\nconst thisBlog = ref&lt;Blog&gt;()\\r\\nonMounted(async () =&gt; {\\r\\n    alert(\'你好\')\\r\\n    const res = await getBlogAPI({ blogId: route.query.blogId })\\r\\n    thisBlog.value = res[0]\\r\\n})</code></pre><p><br></p>\",\"summary\":\"在前端开发中，根据路由参数动态获取并展示数据是常见的业务需求。本文将结合具体代码，深入剖析如何在 Vue.js 项目中，基于路由参数获取博客数据并进行展示，同时探讨其中涉及的技术要点与实现细节。\",\"categoryId\":\"eb8bb5f5-bfec-49c5-82dc-de80b027ff9b\",\"status\":0,\"views\":0,\"likes\":0,\"comments\":0,\"createdAt\":\"2025-05-20 12:14:23\",\"publishedAt\":null,\"customTags\":\"编程,vue3,ts\",\"images\":\"\",\"rejectReason\":null}','2025-05-20 12:14:23','172.20.10.11','执行上传博客','success','博客上传成功'),('ea4bdc74-5fee-4006-8307-88c1bf9e186f','Adison@dev.com','上传博客图片','fb2560f0-afa9-404a-9b4f-1945d4d21d9c.jpg','2025-05-20 15:37:25','192.168.227.16','执行上传','success','执行上传成功'),('fa79e399-fc25-4ac5-8b22-dceefe9debb8','Adison@dev.com','添加评论','{\"commentId\":\"619cf9c8-6a19-46dc-a030-8cd69d6154ec\",\"mail\":\"Adison@dev.com\",\"blogId\":\"54a40fad-2a21-4512-9280-5994111f7228\",\"parentCommentId\":null,\"content\":\"haokan\",\"commentTime\":\"2025-06-19 13:38:24\"}','2025-06-19 13:38:24','192.168.182.16','执行添加评论操作','success',''),('fc73ecf2-0b61-4c8d-a7a1-bc70adc8061e','Adison@dev.com','更新喜欢数量','{\"likeId\":\"a5c45c2b-e40e-4b69-a766-9f43f0a14912\",\"likeTime\":\"2025-07-03 19:15:35\",\"mail\":\"Adison@dev.com\",\"blogId\":\"54a40fad-2a21-4512-9280-5994111f7228\"}','2025-07-03 19:15:35','192.168.0.104','执行更新喜欢数量','success','喜欢成功');
/*!40000 ALTER TABLE `operation_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tag`
--

DROP TABLE IF EXISTS `tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tag` (
  `tag_id` varchar(255) NOT NULL COMMENT '标签ID',
  `name` varchar(50) NOT NULL COMMENT '标签名称（唯一）',
  `description` varchar(255) DEFAULT NULL COMMENT '标签描述',
  `color` varchar(20) DEFAULT '#808080' COMMENT '标签显示颜色',
  PRIMARY KEY (`tag_id`),
  UNIQUE KEY `name` (`name`),
  KEY `idx_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag`
--

LOCK TABLES `tag` WRITE;
/*!40000 ALTER TABLE `tag` DISABLE KEYS */;
INSERT INTO `tag` VALUES ('1838ee72-f3fd-42c8-ba2a-fd0e17828816','游戏','','#FF0000'),('1cd42ab4-52eb-4025-a190-ef1574e20667','电子','','#141E69'),('204197bb-4311-45a3-b21b-cae669b99cda','大学生','','#6F1E54'),('3007c224-ef57-4921-a434-12a2e3944e9e','校园','','#A03E80'),('48740456-7031-41cf-a7a3-d89bc05589f6','科幻','','#893D3D'),('56d255dc-d465-4226-b0ae-6799addb7654','科学','','#6D1852'),('5f54afb9-93d5-49fd-a350-9d60469f15fe','音乐','','#0F8B76'),('7c0b6d84-4604-4da1-bdce-fddf30368f78','文学','','#39B54B'),('7f556b6e-4fdd-43fa-9df4-ce245fae5687','电影','','#30853C'),('83c80047-b1a1-4e55-8fe3-80349334988a','物理','','#893D3D'),('8dad2072-9fec-43bc-8a7e-7e204d8a7286','知识','','#8897C4'),('b453cdba-6676-4b0e-9cf8-0e603681eaca','爵士','','#89C25E'),('d6b11d63-41be-47c1-b44e-af80e4474d24','管弦乐','','#0F8B76'),('e72646fc-b75b-4eb8-8b57-8808a0999a3f','地理','','#000000'),('f669e93c-a163-401c-a35c-b5ea91a84e97','技术','','#9F5587'),('f8d89079-2b07-4817-9545-47cb8c8992e6','生活','','#C47777');
/*!40000 ALTER TABLE `tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` varchar(255) NOT NULL COMMENT '用户ID',
  `mail` varchar(255) NOT NULL COMMENT '邮箱地址',
  `password` varchar(255) NOT NULL COMMENT '加密后的密码',
  `nickname` varchar(50) NOT NULL COMMENT '用户昵称',
  `gender` enum('保密','男','女') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '保密' COMMENT '用户性别（枚举类型）',
  `introduce` text COMMENT '个人简介',
  `photo` varchar(255) DEFAULT NULL COMMENT '头像URL',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `mail` (`mail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('9ba4f057-6c4d-43a3-943b-93dfee00a0d0','Adison@dev.com','$2a$10$Fisa7rmi/2h2eCZapfbzhOq0NEoKDSpvoh76XH2e810XwVJWjvNyu','AdisonL','男','在代码的星河中，我是执着的追光者，以useRoute为罗盘，探寻数据流转的轨迹，用 TypeScript 编织严谨的逻辑诗篇。热爱在 Vue 的舞台上，将冰冷的接口定义化作灵动的交互乐章，让每一行代码都诉说着对技术的深情。于键盘敲击的韵律里，既有攻克难题的热血，也藏着对代码美学的浪漫追求，愿与代码共舞，书写前端世界的诗意篇章。','b0a54dc0-e079-4c3e-be06-b3166ba8e466.png'),('9ba4f057-6c4d-43a3-943b-93dfee00b0a0','admin','$2a$10$gByXjqTEWHgGyUMwhrIapee.6r.Zw5JjfDOayQDD0GtFyQ5GLSn1C','管理员','保密','','');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-03 21:24:49

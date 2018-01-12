-- MySQL dump 10.13  Distrib 5.5.53, for Win32 (AMD64)
--
-- Host: localhost    Database: zzstore
-- ------------------------------------------------------
-- Server version	5.5.53

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cmf_action`
--

DROP TABLE IF EXISTS `cmf_action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_action` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '管理员操作记录',
  `aid` int(11) NOT NULL,
  `action` varchar(100) NOT NULL,
  `time` int(11) NOT NULL,
  `ip` varchar(50) DEFAULT '',
  `type` varchar(20) NOT NULL COMMENT '操作类型',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_action`
--

LOCK TABLES `cmf_action` WRITE;
/*!40000 ALTER TABLE `cmf_action` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_action` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_admin_menu`
--

DROP TABLE IF EXISTS `cmf_admin_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_admin_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父菜单id',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '菜单类型;1:有界面可访问菜单,2:无界面可访问菜单,0:只作为菜单',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态;1:显示,0:不显示',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `app` varchar(15) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '应用名',
  `controller` varchar(30) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '控制器名',
  `action` varchar(30) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '操作名称',
  `param` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '额外参数',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '菜单名称',
  `icon` varchar(20) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '菜单图标',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `parentid` (`parent_id`),
  KEY `model` (`controller`)
) ENGINE=InnoDB AUTO_INCREMENT=266 DEFAULT CHARSET=utf8mb4 COMMENT='后台菜单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_admin_menu`
--

LOCK TABLES `cmf_admin_menu` WRITE;
/*!40000 ALTER TABLE `cmf_admin_menu` DISABLE KEYS */;
INSERT INTO `cmf_admin_menu` VALUES (1,0,0,1,20,'admin','Plugin','default','','插件管理','cloud','插件管理'),(2,1,1,1,10000,'admin','Hook','index','','钩子管理','','钩子管理'),(3,2,1,0,10000,'admin','Hook','plugins','','钩子插件管理','','钩子插件管理'),(4,2,2,0,10000,'admin','Hook','pluginListOrder','','钩子插件排序','','钩子插件排序'),(5,2,1,0,10000,'admin','Hook','sync','','同步钩子','','同步钩子'),(6,0,0,1,0,'admin','Setting','default','','设置','cogs','系统设置入口'),(7,6,1,1,50,'admin','Link','index','','友情链接','','友情链接管理'),(8,7,1,0,10000,'admin','Link','add','','添加友情链接','','添加友情链接'),(9,7,2,0,10000,'admin','Link','addPost','','添加友情链接提交保存','','添加友情链接提交保存'),(10,7,1,0,10000,'admin','Link','edit','','编辑友情链接','','编辑友情链接'),(11,7,2,0,10000,'admin','Link','editPost','','编辑友情链接提交保存','','编辑友情链接提交保存'),(12,7,2,0,10000,'admin','Link','delete','','删除友情链接','','删除友情链接'),(13,7,2,0,10000,'admin','Link','listOrder','','友情链接排序','','友情链接排序'),(14,7,2,0,10000,'admin','Link','toggle','','友情链接显示隐藏','','友情链接显示隐藏'),(15,6,1,1,10,'admin','Mailer','index','','邮箱配置','','邮箱配置'),(16,15,2,0,10000,'admin','Mailer','indexPost','','邮箱配置提交保存','','邮箱配置提交保存'),(17,15,1,0,10000,'admin','Mailer','template','','邮件模板','','邮件模板'),(18,15,2,0,10000,'admin','Mailer','templatePost','','邮件模板提交','','邮件模板提交'),(19,15,1,0,10000,'admin','Mailer','test','','邮件发送测试','','邮件发送测试'),(20,6,1,0,10000,'admin','Menu','index','','后台菜单','','后台菜单管理'),(21,20,1,0,10000,'admin','Menu','lists','','所有菜单','','后台所有菜单列表'),(22,20,1,0,10000,'admin','Menu','add','','后台菜单添加','','后台菜单添加'),(23,20,2,0,10000,'admin','Menu','addPost','','后台菜单添加提交保存','','后台菜单添加提交保存'),(24,20,1,0,10000,'admin','Menu','edit','','后台菜单编辑','','后台菜单编辑'),(25,20,2,0,10000,'admin','Menu','editPost','','后台菜单编辑提交保存','','后台菜单编辑提交保存'),(26,20,2,0,10000,'admin','Menu','delete','','后台菜单删除','','后台菜单删除'),(27,20,2,0,10000,'admin','Menu','listOrder','','后台菜单排序','','后台菜单排序'),(28,20,1,0,10000,'admin','Menu','getActions','','导入新后台菜单','','导入新后台菜单'),(29,6,1,1,30,'admin','Nav','index','','导航管理','','导航管理'),(30,29,1,0,10000,'admin','Nav','add','','添加导航','','添加导航'),(31,29,2,0,10000,'admin','Nav','addPost','','添加导航提交保存','','添加导航提交保存'),(32,29,1,0,10000,'admin','Nav','edit','','编辑导航','','编辑导航'),(33,29,2,0,10000,'admin','Nav','editPost','','编辑导航提交保存','','编辑导航提交保存'),(34,29,2,0,10000,'admin','Nav','delete','','删除导航','','删除导航'),(35,29,1,0,10000,'admin','NavMenu','index','','导航菜单','','导航菜单'),(36,35,1,0,10000,'admin','NavMenu','add','','添加导航菜单','','添加导航菜单'),(37,35,2,0,10000,'admin','NavMenu','addPost','','添加导航菜单提交保存','','添加导航菜单提交保存'),(38,35,1,0,10000,'admin','NavMenu','edit','','编辑导航菜单','','编辑导航菜单'),(39,35,2,0,10000,'admin','NavMenu','editPost','','编辑导航菜单提交保存','','编辑导航菜单提交保存'),(40,35,2,0,10000,'admin','NavMenu','delete','','删除导航菜单','','删除导航菜单'),(41,35,2,0,10000,'admin','NavMenu','listOrder','','导航菜单排序','','导航菜单排序'),(42,1,1,1,10000,'admin','Plugin','index','','插件列表','','插件列表'),(43,42,2,0,10000,'admin','Plugin','toggle','','插件启用禁用','','插件启用禁用'),(44,42,1,0,10000,'admin','Plugin','setting','','插件设置','','插件设置'),(45,42,2,0,10000,'admin','Plugin','settingPost','','插件设置提交','','插件设置提交'),(46,42,2,0,10000,'admin','Plugin','install','','插件安装','','插件安装'),(47,42,2,0,10000,'admin','Plugin','update','','插件更新','','插件更新'),(48,42,2,0,10000,'admin','Plugin','uninstall','','卸载插件','','卸载插件'),(49,0,0,1,10000,'admin','User','default','','管理组','','管理组'),(50,49,1,1,10000,'admin','Rbac','index','','角色管理','','角色管理'),(51,50,1,0,10000,'admin','Rbac','roleAdd','','添加角色','','添加角色'),(52,50,2,0,10000,'admin','Rbac','roleAddPost','','添加角色提交','','添加角色提交'),(53,50,1,0,10000,'admin','Rbac','roleEdit','','编辑角色','','编辑角色'),(54,50,2,0,10000,'admin','Rbac','roleEditPost','','编辑角色提交','','编辑角色提交'),(55,50,2,0,10000,'admin','Rbac','roleDelete','','删除角色','','删除角色'),(56,50,1,0,10000,'admin','Rbac','authorize','','设置角色权限','','设置角色权限'),(57,50,2,0,10000,'admin','Rbac','authorizePost','','角色授权提交','','角色授权提交'),(58,0,1,0,10000,'admin','RecycleBin','index','','回收站','','回收站'),(59,58,2,0,10000,'admin','RecycleBin','restore','','回收站还原','','回收站还原'),(60,58,2,0,10000,'admin','RecycleBin','delete','','回收站彻底删除','','回收站彻底删除'),(61,6,1,1,10000,'admin','Route','index','','URL美化','','URL规则管理'),(62,61,1,0,10000,'admin','Route','add','','添加路由规则','','添加路由规则'),(63,61,2,0,10000,'admin','Route','addPost','','添加路由规则提交','','添加路由规则提交'),(64,61,1,0,10000,'admin','Route','edit','','路由规则编辑','','路由规则编辑'),(65,61,2,0,10000,'admin','Route','editPost','','路由规则编辑提交','','路由规则编辑提交'),(66,61,2,0,10000,'admin','Route','delete','','路由规则删除','','路由规则删除'),(67,61,2,0,10000,'admin','Route','ban','','路由规则禁用','','路由规则禁用'),(68,61,2,0,10000,'admin','Route','open','','路由规则启用','','路由规则启用'),(69,61,2,0,10000,'admin','Route','listOrder','','路由规则排序','','路由规则排序'),(70,61,1,0,10000,'admin','Route','select','','选择URL','','选择URL'),(71,6,1,1,0,'admin','Setting','site','','网站信息','','网站信息'),(72,71,2,0,10000,'admin','Setting','sitePost','','网站信息设置提交','','网站信息设置提交'),(73,6,1,1,10000,'admin','Setting','password','','密码修改','','密码修改'),(74,73,2,0,10000,'admin','Setting','passwordPost','','密码修改提交','','密码修改提交'),(75,6,1,1,10000,'admin','Setting','upload','','上传设置','','上传设置'),(76,75,2,0,10000,'admin','Setting','uploadPost','','上传设置提交','','上传设置提交'),(77,6,1,0,10000,'admin','Setting','clearCache','','清除缓存','','清除缓存'),(78,6,1,1,40,'admin','Slide','index','','幻灯片管理','','幻灯片管理'),(79,78,1,0,10000,'admin','Slide','add','','添加幻灯片','','添加幻灯片'),(80,78,2,0,10000,'admin','Slide','addPost','','添加幻灯片提交','','添加幻灯片提交'),(81,78,1,0,10000,'admin','Slide','edit','','编辑幻灯片','','编辑幻灯片'),(82,78,2,0,10000,'admin','Slide','editPost','','编辑幻灯片提交','','编辑幻灯片提交'),(83,78,2,0,10000,'admin','Slide','delete','','删除幻灯片','','删除幻灯片'),(84,78,1,0,10000,'admin','SlideItem','index','','幻灯片页面列表','','幻灯片页面列表'),(85,84,1,0,10000,'admin','SlideItem','add','','幻灯片页面添加','','幻灯片页面添加'),(86,84,2,0,10000,'admin','SlideItem','addPost','','幻灯片页面添加提交','','幻灯片页面添加提交'),(87,84,1,0,10000,'admin','SlideItem','edit','','幻灯片页面编辑','','幻灯片页面编辑'),(88,84,2,0,10000,'admin','SlideItem','editPost','','幻灯片页面编辑提交','','幻灯片页面编辑提交'),(89,84,2,0,10000,'admin','SlideItem','delete','','幻灯片页面删除','','幻灯片页面删除'),(90,84,2,0,10000,'admin','SlideItem','ban','','幻灯片页面隐藏','','幻灯片页面隐藏'),(91,84,2,0,10000,'admin','SlideItem','cancelBan','','幻灯片页面显示','','幻灯片页面显示'),(92,84,2,0,10000,'admin','SlideItem','listOrder','','幻灯片页面排序','','幻灯片页面排序'),(93,6,1,1,10000,'admin','Storage','index','','文件存储','','文件存储'),(94,93,2,0,10000,'admin','Storage','settingPost','','文件存储设置提交','','文件存储设置提交'),(95,6,1,1,20,'admin','Theme','index','','模板管理','','模板管理'),(96,95,1,0,10000,'admin','Theme','install','','安装模板','','安装模板'),(97,95,2,0,10000,'admin','Theme','uninstall','','卸载模板','','卸载模板'),(98,95,2,0,10000,'admin','Theme','installTheme','','模板安装','','模板安装'),(99,95,2,0,10000,'admin','Theme','update','','模板更新','','模板更新'),(100,95,2,0,10000,'admin','Theme','active','','启用模板','','启用模板'),(101,95,1,0,10000,'admin','Theme','files','','模板文件列表','','启用模板'),(102,95,1,0,10000,'admin','Theme','fileSetting','','模板文件设置','','模板文件设置'),(103,95,1,0,10000,'admin','Theme','fileArrayData','','模板文件数组数据列表','','模板文件数组数据列表'),(104,95,2,0,10000,'admin','Theme','fileArrayDataEdit','','模板文件数组数据添加编辑','','模板文件数组数据添加编辑'),(105,95,2,0,10000,'admin','Theme','fileArrayDataEditPost','','模板文件数组数据添加编辑提交保存','','模板文件数组数据添加编辑提交保存'),(106,95,2,0,10000,'admin','Theme','fileArrayDataDelete','','模板文件数组数据删除','','模板文件数组数据删除'),(107,95,2,0,10000,'admin','Theme','settingPost','','模板文件编辑提交保存','','模板文件编辑提交保存'),(108,95,1,0,10000,'admin','Theme','dataSource','','模板文件设置数据源','','模板文件设置数据源'),(109,0,0,1,10,'user','AdminIndex','default','','用户管理','group','用户管理'),(110,49,1,1,10000,'admin','User','index','','管理员','','管理员管理'),(111,110,1,0,10000,'admin','User','add','','管理员添加','','管理员添加'),(112,110,2,0,10000,'admin','User','addPost','','管理员添加提交','','管理员添加提交'),(113,110,1,0,10000,'admin','User','edit','','管理员编辑','','管理员编辑'),(114,110,2,0,10000,'admin','User','editPost','','管理员编辑提交','','管理员编辑提交'),(115,110,1,1,10000,'admin','User','userInfo','','个人信息','','管理员个人信息修改'),(116,110,2,0,10000,'admin','User','userInfoPost','','管理员个人信息修改提交','','管理员个人信息修改提交'),(117,110,2,0,10000,'admin','User','delete','','管理员删除','','管理员删除'),(118,110,2,0,10000,'admin','User','ban','','停用管理员','','停用管理员'),(119,110,2,0,10000,'admin','User','cancelBan','','启用管理员','','启用管理员'),(120,0,0,1,30,'portal','AdminIndex','default','','门户管理','th','门户管理'),(121,120,1,1,10000,'portal','AdminArticle','index','','文章管理','','文章列表'),(122,121,1,0,10000,'portal','AdminArticle','add','','添加文章','','添加文章'),(123,121,2,0,10000,'portal','AdminArticle','addPost','','添加文章提交','','添加文章提交'),(124,121,1,0,10000,'portal','AdminArticle','edit','','编辑文章','','编辑文章'),(125,121,2,0,10000,'portal','AdminArticle','editPost','','编辑文章提交','','编辑文章提交'),(126,121,2,0,10000,'portal','AdminArticle','delete','','文章删除','','文章删除'),(127,121,2,0,10000,'portal','AdminArticle','publish','','文章发布','','文章发布'),(128,121,2,0,10000,'portal','AdminArticle','top','','文章置顶','','文章置顶'),(129,121,2,0,10000,'portal','AdminArticle','recommend','','文章推荐','','文章推荐'),(130,121,2,0,10000,'portal','AdminArticle','listOrder','','文章排序','','文章排序'),(131,120,1,1,10000,'portal','AdminCategory','index','','分类管理','','文章分类列表'),(132,131,1,0,10000,'portal','AdminCategory','add','','添加文章分类','','添加文章分类'),(133,131,2,0,10000,'portal','AdminCategory','addPost','','添加文章分类提交','','添加文章分类提交'),(134,131,1,0,10000,'portal','AdminCategory','edit','','编辑文章分类','','编辑文章分类'),(135,131,2,0,10000,'portal','AdminCategory','editPost','','编辑文章分类提交','','编辑文章分类提交'),(136,131,1,0,10000,'portal','AdminCategory','select','','文章分类选择对话框','','文章分类选择对话框'),(137,131,2,0,10000,'portal','AdminCategory','listOrder','','文章分类排序','','文章分类排序'),(138,131,2,0,10000,'portal','AdminCategory','delete','','删除文章分类','','删除文章分类'),(139,120,1,1,10000,'portal','AdminPage','index','','页面管理','','页面管理'),(140,139,1,0,10000,'portal','AdminPage','add','','添加页面','','添加页面'),(141,139,2,0,10000,'portal','AdminPage','addPost','','添加页面提交','','添加页面提交'),(142,139,1,0,10000,'portal','AdminPage','edit','','编辑页面','','编辑页面'),(143,139,2,0,10000,'portal','AdminPage','editPost','','编辑页面提交','','编辑页面提交'),(144,139,2,0,10000,'portal','AdminPage','delete','','删除页面','','删除页面'),(145,120,1,1,10000,'portal','AdminTag','index','','文章标签','','文章标签'),(146,145,1,0,10000,'portal','AdminTag','add','','添加文章标签','','添加文章标签'),(147,145,2,0,10000,'portal','AdminTag','addPost','','添加文章标签提交','','添加文章标签提交'),(148,145,2,0,10000,'portal','AdminTag','upStatus','','更新标签状态','','更新标签状态'),(149,145,2,0,10000,'portal','AdminTag','delete','','删除文章标签','','删除文章标签'),(150,0,1,0,10000,'user','AdminAsset','index','','资源管理','file','资源管理列表'),(151,150,2,0,10000,'user','AdminAsset','delete','','删除文件','','删除文件'),(152,109,0,1,10000,'user','AdminIndex','default1','','用户组','','用户组'),(153,152,1,1,10000,'user','AdminIndex','index','','本站用户','','本站用户'),(154,153,2,0,10000,'user','AdminIndex','ban','','本站用户拉黑','','本站用户拉黑'),(155,153,2,0,10000,'user','AdminIndex','cancelBan','','本站用户启用','','本站用户启用'),(156,152,1,1,10000,'user','AdminOauth','index','','第三方用户','','第三方用户'),(157,156,2,0,10000,'user','AdminOauth','delete','','删除第三方用户绑定','','删除第三方用户绑定'),(158,6,1,1,10000,'user','AdminUserAction','index','','用户操作管理','','用户操作管理'),(159,158,1,0,10000,'user','AdminUserAction','edit','','编辑用户操作','','编辑用户操作'),(160,158,2,0,10000,'user','AdminUserAction','editPost','','编辑用户操作提交','','编辑用户操作提交'),(161,158,1,0,10000,'user','AdminUserAction','sync','','同步用户操作','','同步用户操作'),(162,0,0,1,10,'admin','goods','default','','产品管理','','产品管理'),(169,162,1,1,11,'admin','Cate','index','','产品分类管理','','产品分类列表'),(170,169,1,0,10,'admin','Cate','add','','添加产品分类','','添加产品分类'),(171,169,2,0,10,'admin','Cate','addPost','','添加产品分类提交','','添加产品分类提交'),(172,169,1,0,10,'admin','Cate','edit','','编辑产品分类','','编辑产品分类'),(173,169,2,0,10,'admin','Cate','editPost','','编辑产品分类提交','','编辑产品分类提交'),(174,169,1,0,10,'admin','Cate','select','','产品分类选择对话框','','产品分类选择对话框'),(175,169,2,0,10,'admin','Cate','sort','','产品分类排序','','产品分类排序'),(176,169,2,0,10,'admin','Cate','delete','','删除产品分类','','删除产品分类'),(177,162,1,1,10,'admin','Goods','index','','产品名称列表','','产品列表'),(178,177,1,0,10,'admin','Goods','edit','','产品编辑','','产品编辑'),(179,177,2,0,10,'admin','Goods','editPost','','产品编辑_执行','','产品编辑_执行'),(180,177,2,0,10,'admin','Goods','delete','','产品删除','','产品删除'),(181,177,1,0,10,'admin','Goods','add','','产品添加','','产品添加'),(182,177,2,0,10,'admin','Goods','addPost','','产品添加_执行','','产品添加_执行'),(183,162,1,1,10,'admin','Goods','goods_attr','','产品规格详情','','属性编辑'),(184,183,2,0,10,'admin','Goods','sort','','产品属性排序','','产品属性排序'),(185,183,1,0,10,'admin','Goods','attr_edit','','产品规格编辑','','属性编辑'),(186,183,2,0,10,'admin','Goods','attr_editPost','','属性编辑_执行','','属性编辑_执行'),(187,183,1,0,10,'admin','Goods','attr_add','','属性添加','','属性添加'),(188,183,2,0,10,'admin','Goods','attr_addPost','','属性添加_执行','','属性添加_执行'),(189,0,0,1,10,'admin','Instore','default','','产品入库','','产品入库'),(190,189,1,1,11,'admin','Instore','index','','产品入库记录','','产品入库记录'),(191,190,1,0,10,'admin','Instore','add','','添加产品入库','','添加产品入库'),(192,190,2,0,10,'admin','Instore','addPost','','添加产品入库提交','','添加产品入库提交'),(193,190,1,0,10,'admin','Instore','edit','','编辑产品入库','','编辑产品入库'),(194,190,2,0,10,'admin','Instore','editPost','','编辑产品入库提交','','编辑产品入库提交'),(195,190,1,0,10,'admin','Instore','select','','产品入库选择对话框','','产品入库选择对话框'),(196,190,2,0,10,'admin','Instore','delete','','删除产品入库','','删除产品入库'),(197,189,1,1,10,'admin','Instore','instores','','产品入库单','','产品入库单'),(198,190,2,0,10,'admin','Instore','instore_add','','添加产品入库记录','','添加产品入库记录'),(199,190,2,0,10,'admin','Instore','instore_delete','','删除产品入库记录','','删除产品入库记录'),(200,190,2,0,10,'admin','Instore','review','','审核产品入库 ','','审核产品入库 '),(201,0,0,1,10,'admin','Outstore','default','','产品出库','','产品出库'),(202,201,1,1,11,'admin','Outstore','index','','产品出库记录','','产品出库记录'),(203,201,1,1,10,'admin','Outstore','outstores','','产品出库单','','产品出库单'),(204,202,1,0,10,'admin','Outstore','add','','添加产品出库','','添加产品出库'),(205,202,2,0,10,'admin','Outstore','outstore_add','','添加产品出库记录','','添加产品出库记录'),(206,202,2,0,10,'admin','Outstore','outstore_delete','','删除产品出库记录','','删除产品出库记录'),(207,202,2,0,10,'admin','Outstore','addPost','','添加产品出库提交','','添加产品出库提交'),(208,202,1,0,10,'admin','Outstore','edit','','编辑产品出库','','编辑产品出库'),(209,202,2,0,10,'admin','Outstore','editPost','','编辑产品出库提交','','编辑产品出库提交'),(210,202,2,0,10,'admin','Outstore','review','','审核产品出库 ','','审核产品出库 '),(211,202,2,0,10,'admin','Outstore','delete','','删除产品出库单','','删除产品出库单'),(215,0,0,1,10,'admin','GoodsStore','default','','仓库管理','','仓库管理'),(216,215,1,1,0,'admin','GoodsStore','index','','产品库存','','产品库存'),(217,215,1,1,0,'admin','Store','index','','仓库管理','','仓库管理'),(218,217,1,0,10,'admin','Store','edit','','仓库编辑','','仓库编辑'),(219,217,2,0,10,'admin','Store','editPost','','仓库编辑1','','仓库编辑1'),(220,217,2,0,10,'admin','Store','delete','','仓库删除','','仓库删除'),(221,217,1,0,10,'admin','Store','add','','仓库添加','','仓库添加'),(222,217,2,0,10,'admin','Store','addPost','','仓库添加1','','仓库添加1'),(223,215,1,1,10,'admin','Customer','index','','顾客管理','','顾客管理'),(224,223,1,0,10,'admin','Customer','edit','','顾客编辑','','顾客编辑'),(225,223,2,0,10,'admin','Customer','editPost','','顾客编辑1','','顾客编辑1'),(226,223,2,0,10,'admin','Customer','delete','','顾客删除','','顾客删除'),(227,223,1,0,10,'admin','Customer','add','','顾客添加','','顾客添加'),(228,223,2,0,10,'admin','Customer','addPost','','顾客添加1','','顾客添加1'),(229,223,2,0,10,'admin','Customer','sort','','顾客排序','','顾客排序'),(230,217,2,0,10,'admin','Store','sort','','仓库排序','','仓库排序'),(231,215,1,1,0,'admin','Supplier','index','','供货商管理','','供货商管理'),(232,231,1,0,10,'admin','Supplier','edit','','供货商编辑','','供货商编辑'),(233,231,2,0,10,'admin','Supplier','editPost','','供货商编辑1','','供货商编辑1'),(234,231,2,0,10,'admin','Supplier','delete','','供货商删除','','供货商删除'),(235,231,1,0,10,'admin','Supplier','add','','供货商添加','','供货商添加'),(236,231,2,0,10,'admin','Supplier','addPost','','供货商添加1','','供货商添加1'),(237,231,2,0,10,'admin','Supplier','sort','','供货商排序','','供货商排序'),(238,215,1,1,0,'admin','Worker','index','','员工管理','','员工管理'),(239,238,1,0,10,'admin','Worker','edit','','员工编辑','','员工编辑'),(240,238,2,0,10,'admin','Worker','editPost','','员工编辑1','','员工编辑1'),(241,238,2,0,10,'admin','Worker','delete','','员工删除','','员工删除'),(242,238,1,0,10,'admin','Worker','add','','员工添加','','员工添加'),(243,238,2,0,10,'admin','Worker','addPost','','员工添加1','','员工添加1'),(244,238,2,0,10,'admin','Worker','sort','','员工排序','','员工排序'),(245,49,1,1,0,'admin','Action','index','','管理员操作记录','','管理员操作记录'),(246,177,2,0,10,'admin','Goods','attr_delete','','产品规格删除','','产品规格删除'),(247,190,2,0,10,'admin','Instore','excel','','导出excel','','导出excel'),(248,0,1,1,100,'admin','Sql','index','','数据库操作','','数据库操作'),(249,248,1,0,10,'admin','Sql','add','','数据库备份','','数据库备份'),(250,248,1,0,10,'admin','Sql','restore','','数据库还原','','数据库还原'),(251,248,2,0,10,'admin','Sql','del','','数据库删除备份','','数据库删除备份'),(252,248,2,0,10,'admin','Sql','dels','','数据库批量删除备份','','数据库批量删除备份'),(253,257,1,1,10,'admin','Count','index','','出入库统计','','出入库统计'),(254,177,2,0,10,'admin','Goods','excel','','导出excel','','导出excel'),(255,215,2,0,0,'admin','GoodsStore','clear','','清理库存','','清理库存'),(256,202,2,0,10,'admin','Outstore','excel','','导出excel','','导出excel'),(257,0,0,1,10,'admin','Count','default','','数据统计','','数据统计'),(258,257,1,1,10,'admin','Count','search','','出入库统计查询','','出入库统计查询'),(259,257,1,1,10,'admin','Count','seller','','销售统计查询','','销售统计查询'),(260,177,2,0,10,'admin','Goods','excel0','','导出excel图片','','导出excel图片'),(261,248,1,0,10,'admin','Sql','query','',' 数据库查询','',' 数据库查询'),(262,257,1,1,10,'admin','Count','buyer','','进货统计查询','','进货统计查询'),(263,0,1,1,15,'admin','Config','index','','网站配置','','网站配置'),(264,263,2,0,10,'admin','Config','editPost','','网站配置编辑1','','网站配置编辑1'),(265,202,2,0,10,'admin','Outstore','excel0','','销售导出excel','','销售导出excel');
/*!40000 ALTER TABLE `cmf_admin_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_asset`
--

DROP TABLE IF EXISTS `cmf_asset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_asset` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `file_size` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小,单位B',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上传时间',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态;1:可用,0:不可用',
  `download_times` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '下载次数',
  `file_key` varchar(64) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '文件惟一码',
  `filename` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '文件名',
  `file_path` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '文件路径,相对于upload目录,可以为url',
  `file_md5` varchar(32) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '文件md5值',
  `file_sha1` varchar(40) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `suffix` varchar(10) NOT NULL DEFAULT '' COMMENT '文件后缀名,不包括点',
  `more` text COMMENT '其它详细信息,JSON格式',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COMMENT='资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_asset`
--

LOCK TABLES `cmf_asset` WRITE;
/*!40000 ALTER TABLE `cmf_asset` DISABLE KEYS */;
INSERT INTO `cmf_asset` VALUES (1,1,20882,1515378255,1,0,'4bfc113ac032502408a3d95f829aa7008072b47bb79a072ca44fca1a87ee01b8','avatar-2.jpg','admin/20180108/cb68f59cc5433e0aa71a629086d19cac.jpg','4bfc113ac032502408a3d95f829aa700','eabca4534c70e57ca51a5a7504e3e9b928ac4ede','jpg',NULL),(2,1,153517,1515378365,1,0,'818b202cdc96853c56083686a41d9ccbe5e15625a6debbe004b516b14a43332e','about-img-1.png','admin/20180108/ff74431023272c855b619a9cf8040acf.png','818b202cdc96853c56083686a41d9ccb','095d3478f7e3f7eef7729a6141e4a7e4e5d81976','png',NULL),(3,1,163385,1515378365,1,0,'1bc6c6395158b9a4350b19ef4e4ae9a7bbfe056fae71104e64418ee1e77fcb01','about-img-2.png','admin/20180108/a763898341b29dfb908e6760f39e52eb.png','1bc6c6395158b9a4350b19ef4e4ae9a7','419883ea3e9cf355dbd9acb60100eecd63fd0663','png',NULL),(4,1,204721,1515378365,1,0,'3aba4e62aee3d718311a89e27f9c8e2f6f0ff523d45727e06a6de8972fcfd34d','about-img-3.png','admin/20180108/f2bf8c898c22c7924642803e576b1fd1.png','3aba4e62aee3d718311a89e27f9c8e2f','21d24d45454fa1fe3772537920122e45e6b23f82','png',NULL),(5,1,132470,1515378387,1,0,'25e5c94b3590e1f847b774b0ae8d1b2099a94fea16f51e003d8934a956c583dc','about-4.jpg','admin/20180108/0ad4a13bc59625d6d86c00266c2b43c5.jpg','25e5c94b3590e1f847b774b0ae8d1b20','3336f83330d100ba7d7120b7975624cc6a3fb527','jpg',NULL),(6,1,124081,1515378825,1,0,'f135e9f932fd9cfafbc3b613ea6caf2c2d59fa298b0b992b10ad19debe6f402e','about-3.jpg','admin/20180108/4405cf9acd3b20731e0dbe16c2847525.jpg','f135e9f932fd9cfafbc3b613ea6caf2c','c25a3ee4d405940aae663aa4787cf972a5f45f9b','jpg',NULL),(7,1,189115,1515379027,1,0,'e8742a7ffbfd4db7b9729769e95e446d7dc5d08c28b1e0965e70ae159c278cc7','about-img-4.png','admin/20180108/36d9402b4c103afe3f94d06d3636b21f.png','e8742a7ffbfd4db7b9729769e95e446d','3c36cc6d6c4d90b1d6f0bd0dd76505ab59eb055b','png',NULL),(8,1,32179,1515379027,1,0,'195d682b67e548523b2393b998f32549ee8bc9ec7a12648288ebf9b793935bb0','avatar-1.jpg','admin/20180108/9f999621e5b80a3c20ca26b605cc9988.jpg','195d682b67e548523b2393b998f32549','31411af758922106effc5800d6d8464ab18f6a0b','jpg',NULL),(9,1,67586,1515379608,1,0,'61eea6fdce19dbaf6288303a8ffe46f46712a1f62940863572b5124bfc56a69f','avtar.png','admin/20180108/b99aaba4f7b2d0aecf653ad482348ef0.png','61eea6fdce19dbaf6288303a8ffe46f4','de5ec73f55327ab6b9924f95e1d958c65d8b6629','png',NULL);
/*!40000 ALTER TABLE `cmf_asset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_auth_access`
--

DROP TABLE IF EXISTS `cmf_auth_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_auth_access` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int(10) unsigned NOT NULL COMMENT '角色',
  `rule_name` varchar(100) NOT NULL DEFAULT '' COMMENT '规则唯一英文标识,全小写',
  `type` varchar(30) NOT NULL DEFAULT '' COMMENT '权限规则分类,请加应用前缀,如admin_',
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`),
  KEY `rule_name` (`rule_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1130 DEFAULT CHARSET=utf8 COMMENT='权限授权表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_auth_access`
--

LOCK TABLES `cmf_auth_access` WRITE;
/*!40000 ALTER TABLE `cmf_auth_access` DISABLE KEYS */;
INSERT INTO `cmf_auth_access` VALUES (813,5,'admin/setting/default','admin_url'),(814,5,'admin/setting/password','admin_url'),(815,5,'admin/setting/passwordpost','admin_url'),(816,5,'admin/user/userinfo','admin_url'),(817,5,'admin/user/userinfopost','admin_url'),(818,5,'admin/goods/default','admin_url'),(819,5,'admin/goods/index','admin_url'),(820,5,'admin/goods/excel0','admin_url'),(821,5,'admin/goods/edit','admin_url'),(822,5,'admin/goods/excel','admin_url'),(823,5,'admin/goods/goods_attr','admin_url'),(824,5,'admin/goods/attr_edit','admin_url'),(825,5,'admin/cate/index','admin_url'),(826,5,'admin/cate/edit','admin_url'),(827,5,'admin/instore/default','admin_url'),(828,5,'admin/instore/instores','admin_url'),(829,5,'admin/instore/index','admin_url'),(830,5,'admin/instore/edit','admin_url'),(831,5,'admin/instore/excel','admin_url'),(832,5,'admin/outstore/default','admin_url'),(833,5,'admin/outstore/outstores','admin_url'),(834,5,'admin/outstore/index','admin_url'),(835,5,'admin/outstore/excel','admin_url'),(836,5,'admin/outstore/excel0','admin_url'),(837,5,'admin/outstore/add','admin_url'),(838,5,'admin/outstore/outstore_add','admin_url'),(839,5,'admin/outstore/outstore_delete','admin_url'),(840,5,'admin/outstore/addpost','admin_url'),(841,5,'admin/outstore/edit','admin_url'),(842,5,'admin/outstore/editpost','admin_url'),(843,5,'admin/outstore/delete','admin_url'),(844,5,'admin/goodsstore/default','admin_url'),(845,5,'admin/goodsstore/index','admin_url'),(846,5,'admin/store/index','admin_url'),(847,5,'admin/store/edit','admin_url'),(848,5,'admin/worker/index','admin_url'),(849,5,'admin/worker/edit','admin_url'),(850,5,'admin/customer/index','admin_url'),(851,5,'admin/customer/edit','admin_url'),(852,5,'admin/user/default','admin_url'),(853,5,'admin/action/index','admin_url'),(854,4,'admin/setting/default','admin_url'),(855,4,'admin/setting/password','admin_url'),(856,4,'admin/setting/passwordpost','admin_url'),(857,4,'admin/user/userinfo','admin_url'),(858,4,'admin/user/userinfopost','admin_url'),(859,4,'admin/goods/default','admin_url'),(860,4,'admin/goods/index','admin_url'),(861,4,'admin/goods/excel0','admin_url'),(862,4,'admin/goods/edit','admin_url'),(863,4,'admin/goods/excel','admin_url'),(864,4,'admin/goods/goods_attr','admin_url'),(865,4,'admin/goods/attr_edit','admin_url'),(866,4,'admin/instore/default','admin_url'),(867,4,'admin/instore/instores','admin_url'),(868,4,'admin/instore/index','admin_url'),(869,4,'admin/instore/add','admin_url'),(870,4,'admin/instore/addpost','admin_url'),(871,4,'admin/instore/edit','admin_url'),(872,4,'admin/instore/editpost','admin_url'),(873,4,'admin/instore/select','admin_url'),(874,4,'admin/instore/delete','admin_url'),(875,4,'admin/instore/instore_add','admin_url'),(876,4,'admin/instore/instore_delete','admin_url'),(877,4,'admin/instore/excel','admin_url'),(878,4,'admin/outstore/default','admin_url'),(879,4,'admin/outstore/outstores','admin_url'),(880,4,'admin/outstore/index','admin_url'),(881,4,'admin/outstore/excel','admin_url'),(882,4,'admin/outstore/excel0','admin_url'),(883,4,'admin/goodsstore/default','admin_url'),(884,4,'admin/goodsstore/index','admin_url'),(885,4,'admin/store/index','admin_url'),(886,4,'admin/store/edit','admin_url'),(887,4,'admin/supplier/index','admin_url'),(888,4,'admin/supplier/edit','admin_url'),(889,4,'admin/worker/index','admin_url'),(890,4,'admin/worker/edit','admin_url'),(891,4,'admin/customer/index','admin_url'),(892,4,'admin/customer/edit','admin_url'),(893,4,'admin/user/default','admin_url'),(894,4,'admin/action/index','admin_url'),(895,3,'admin/setting/default','admin_url'),(896,3,'admin/mailer/index','admin_url'),(897,3,'admin/mailer/indexpost','admin_url'),(898,3,'admin/mailer/template','admin_url'),(899,3,'admin/mailer/templatepost','admin_url'),(900,3,'admin/mailer/test','admin_url'),(901,3,'admin/setting/password','admin_url'),(902,3,'admin/setting/passwordpost','admin_url'),(903,3,'admin/user/userinfo','admin_url'),(904,3,'admin/user/userinfopost','admin_url'),(905,3,'admin/count/default','admin_url'),(906,3,'admin/count/search','admin_url'),(907,3,'admin/count/seller','admin_url'),(908,3,'admin/count/buyer','admin_url'),(909,3,'admin/count/index','admin_url'),(910,3,'admin/goods/default','admin_url'),(911,3,'admin/goods/index','admin_url'),(912,3,'admin/goods/excel0','admin_url'),(913,3,'admin/goods/edit','admin_url'),(914,3,'admin/goods/editpost','admin_url'),(915,3,'admin/goods/delete','admin_url'),(916,3,'admin/goods/add','admin_url'),(917,3,'admin/goods/addpost','admin_url'),(918,3,'admin/goods/attr_delete','admin_url'),(919,3,'admin/goods/excel','admin_url'),(920,3,'admin/goods/goods_attr','admin_url'),(921,3,'admin/goods/sort','admin_url'),(922,3,'admin/goods/attr_edit','admin_url'),(923,3,'admin/goods/attr_editpost','admin_url'),(924,3,'admin/goods/attr_add','admin_url'),(925,3,'admin/goods/attr_addpost','admin_url'),(926,3,'admin/cate/index','admin_url'),(927,3,'admin/cate/add','admin_url'),(928,3,'admin/cate/addpost','admin_url'),(929,3,'admin/cate/edit','admin_url'),(930,3,'admin/cate/editpost','admin_url'),(931,3,'admin/cate/select','admin_url'),(932,3,'admin/cate/sort','admin_url'),(933,3,'admin/cate/delete','admin_url'),(934,3,'admin/instore/default','admin_url'),(935,3,'admin/instore/instores','admin_url'),(936,3,'admin/instore/index','admin_url'),(937,3,'admin/instore/add','admin_url'),(938,3,'admin/instore/addpost','admin_url'),(939,3,'admin/instore/edit','admin_url'),(940,3,'admin/instore/editpost','admin_url'),(941,3,'admin/instore/select','admin_url'),(942,3,'admin/instore/delete','admin_url'),(943,3,'admin/instore/instore_add','admin_url'),(944,3,'admin/instore/instore_delete','admin_url'),(945,3,'admin/instore/review','admin_url'),(946,3,'admin/instore/excel','admin_url'),(947,3,'admin/outstore/default','admin_url'),(948,3,'admin/outstore/outstores','admin_url'),(949,3,'admin/outstore/index','admin_url'),(950,3,'admin/outstore/excel','admin_url'),(951,3,'admin/outstore/excel0','admin_url'),(952,3,'admin/outstore/add','admin_url'),(953,3,'admin/outstore/outstore_add','admin_url'),(954,3,'admin/outstore/outstore_delete','admin_url'),(955,3,'admin/outstore/addpost','admin_url'),(956,3,'admin/outstore/edit','admin_url'),(957,3,'admin/outstore/editpost','admin_url'),(958,3,'admin/outstore/review','admin_url'),(959,3,'admin/outstore/delete','admin_url'),(960,3,'admin/goodsstore/default','admin_url'),(961,3,'admin/goodsstore/index','admin_url'),(962,3,'admin/store/index','admin_url'),(963,3,'admin/store/edit','admin_url'),(964,3,'admin/store/editpost','admin_url'),(965,3,'admin/store/delete','admin_url'),(966,3,'admin/store/add','admin_url'),(967,3,'admin/store/addpost','admin_url'),(968,3,'admin/store/sort','admin_url'),(969,3,'admin/supplier/index','admin_url'),(970,3,'admin/supplier/edit','admin_url'),(971,3,'admin/supplier/editpost','admin_url'),(972,3,'admin/supplier/delete','admin_url'),(973,3,'admin/supplier/add','admin_url'),(974,3,'admin/supplier/addpost','admin_url'),(975,3,'admin/supplier/sort','admin_url'),(976,3,'admin/worker/index','admin_url'),(977,3,'admin/worker/edit','admin_url'),(978,3,'admin/worker/editpost','admin_url'),(979,3,'admin/worker/delete','admin_url'),(980,3,'admin/worker/add','admin_url'),(981,3,'admin/worker/addpost','admin_url'),(982,3,'admin/worker/sort','admin_url'),(983,3,'admin/goodsstore/clear','admin_url'),(984,3,'admin/customer/index','admin_url'),(985,3,'admin/customer/edit','admin_url'),(986,3,'admin/customer/editpost','admin_url'),(987,3,'admin/customer/delete','admin_url'),(988,3,'admin/customer/add','admin_url'),(989,3,'admin/customer/addpost','admin_url'),(990,3,'admin/customer/sort','admin_url'),(991,3,'admin/config/index','admin_url'),(992,3,'admin/config/editpost','admin_url'),(993,3,'admin/user/default','admin_url'),(994,3,'admin/action/index','admin_url'),(995,3,'admin/user/index','admin_url'),(996,3,'admin/user/add','admin_url'),(997,3,'admin/user/addpost','admin_url'),(998,3,'admin/user/edit','admin_url'),(999,3,'admin/user/editpost','admin_url'),(1000,3,'admin/user/delete','admin_url'),(1001,3,'admin/user/ban','admin_url'),(1002,3,'admin/user/cancelban','admin_url'),(1003,3,'user/adminasset/index','admin_url'),(1004,3,'user/adminasset/delete','admin_url'),(1005,2,'admin/setting/default','admin_url'),(1006,2,'admin/mailer/index','admin_url'),(1007,2,'admin/mailer/indexpost','admin_url'),(1008,2,'admin/mailer/template','admin_url'),(1009,2,'admin/mailer/templatepost','admin_url'),(1010,2,'admin/mailer/test','admin_url'),(1011,2,'admin/setting/password','admin_url'),(1012,2,'admin/setting/passwordpost','admin_url'),(1013,2,'admin/setting/clearcache','admin_url'),(1014,2,'admin/count/default','admin_url'),(1015,2,'admin/count/search','admin_url'),(1016,2,'admin/count/seller','admin_url'),(1017,2,'admin/count/buyer','admin_url'),(1018,2,'admin/count/index','admin_url'),(1019,2,'admin/goods/default','admin_url'),(1020,2,'admin/goods/index','admin_url'),(1021,2,'admin/goods/excel0','admin_url'),(1022,2,'admin/goods/edit','admin_url'),(1023,2,'admin/goods/editpost','admin_url'),(1024,2,'admin/goods/delete','admin_url'),(1025,2,'admin/goods/add','admin_url'),(1026,2,'admin/goods/addpost','admin_url'),(1027,2,'admin/goods/attr_delete','admin_url'),(1028,2,'admin/goods/excel','admin_url'),(1029,2,'admin/goods/goods_attr','admin_url'),(1030,2,'admin/goods/sort','admin_url'),(1031,2,'admin/goods/attr_edit','admin_url'),(1032,2,'admin/goods/attr_editpost','admin_url'),(1033,2,'admin/goods/attr_add','admin_url'),(1034,2,'admin/goods/attr_addpost','admin_url'),(1035,2,'admin/cate/index','admin_url'),(1036,2,'admin/cate/add','admin_url'),(1037,2,'admin/cate/addpost','admin_url'),(1038,2,'admin/cate/edit','admin_url'),(1039,2,'admin/cate/editpost','admin_url'),(1040,2,'admin/cate/select','admin_url'),(1041,2,'admin/cate/sort','admin_url'),(1042,2,'admin/cate/delete','admin_url'),(1043,2,'admin/instore/default','admin_url'),(1044,2,'admin/instore/instores','admin_url'),(1045,2,'admin/instore/index','admin_url'),(1046,2,'admin/instore/add','admin_url'),(1047,2,'admin/instore/addpost','admin_url'),(1048,2,'admin/instore/edit','admin_url'),(1049,2,'admin/instore/editpost','admin_url'),(1050,2,'admin/instore/select','admin_url'),(1051,2,'admin/instore/delete','admin_url'),(1052,2,'admin/instore/instore_add','admin_url'),(1053,2,'admin/instore/instore_delete','admin_url'),(1054,2,'admin/instore/review','admin_url'),(1055,2,'admin/instore/excel','admin_url'),(1056,2,'admin/outstore/default','admin_url'),(1057,2,'admin/outstore/outstores','admin_url'),(1058,2,'admin/outstore/index','admin_url'),(1059,2,'admin/outstore/excel','admin_url'),(1060,2,'admin/outstore/excel0','admin_url'),(1061,2,'admin/outstore/add','admin_url'),(1062,2,'admin/outstore/outstore_add','admin_url'),(1063,2,'admin/outstore/outstore_delete','admin_url'),(1064,2,'admin/outstore/addpost','admin_url'),(1065,2,'admin/outstore/edit','admin_url'),(1066,2,'admin/outstore/editpost','admin_url'),(1067,2,'admin/outstore/review','admin_url'),(1068,2,'admin/outstore/delete','admin_url'),(1069,2,'admin/goodsstore/default','admin_url'),(1070,2,'admin/goodsstore/index','admin_url'),(1071,2,'admin/store/index','admin_url'),(1072,2,'admin/store/edit','admin_url'),(1073,2,'admin/store/editpost','admin_url'),(1074,2,'admin/store/delete','admin_url'),(1075,2,'admin/store/add','admin_url'),(1076,2,'admin/store/addpost','admin_url'),(1077,2,'admin/store/sort','admin_url'),(1078,2,'admin/supplier/index','admin_url'),(1079,2,'admin/supplier/edit','admin_url'),(1080,2,'admin/supplier/editpost','admin_url'),(1081,2,'admin/supplier/delete','admin_url'),(1082,2,'admin/supplier/add','admin_url'),(1083,2,'admin/supplier/addpost','admin_url'),(1084,2,'admin/supplier/sort','admin_url'),(1085,2,'admin/worker/index','admin_url'),(1086,2,'admin/worker/edit','admin_url'),(1087,2,'admin/worker/editpost','admin_url'),(1088,2,'admin/worker/delete','admin_url'),(1089,2,'admin/worker/add','admin_url'),(1090,2,'admin/worker/addpost','admin_url'),(1091,2,'admin/worker/sort','admin_url'),(1092,2,'admin/goodsstore/clear','admin_url'),(1093,2,'admin/customer/index','admin_url'),(1094,2,'admin/customer/edit','admin_url'),(1095,2,'admin/customer/editpost','admin_url'),(1096,2,'admin/customer/delete','admin_url'),(1097,2,'admin/customer/add','admin_url'),(1098,2,'admin/customer/addpost','admin_url'),(1099,2,'admin/customer/sort','admin_url'),(1100,2,'admin/config/index','admin_url'),(1101,2,'admin/config/editpost','admin_url'),(1102,2,'admin/sql/index','admin_url'),(1103,2,'admin/sql/query','admin_url'),(1104,2,'admin/sql/add','admin_url'),(1105,2,'admin/sql/restore','admin_url'),(1106,2,'admin/sql/del','admin_url'),(1107,2,'admin/sql/dels','admin_url'),(1108,2,'admin/user/default','admin_url'),(1109,2,'admin/action/index','admin_url'),(1110,2,'admin/rbac/index','admin_url'),(1111,2,'admin/rbac/roleadd','admin_url'),(1112,2,'admin/rbac/roleaddpost','admin_url'),(1113,2,'admin/rbac/roleedit','admin_url'),(1114,2,'admin/rbac/roleeditpost','admin_url'),(1115,2,'admin/rbac/roledelete','admin_url'),(1116,2,'admin/rbac/authorize','admin_url'),(1117,2,'admin/rbac/authorizepost','admin_url'),(1118,2,'admin/user/index','admin_url'),(1119,2,'admin/user/add','admin_url'),(1120,2,'admin/user/addpost','admin_url'),(1121,2,'admin/user/edit','admin_url'),(1122,2,'admin/user/editpost','admin_url'),(1123,2,'admin/user/userinfo','admin_url'),(1124,2,'admin/user/userinfopost','admin_url'),(1125,2,'admin/user/delete','admin_url'),(1126,2,'admin/user/ban','admin_url'),(1127,2,'admin/user/cancelban','admin_url'),(1128,2,'user/adminasset/index','admin_url'),(1129,2,'user/adminasset/delete','admin_url');
/*!40000 ALTER TABLE `cmf_auth_access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_auth_rule`
--

DROP TABLE IF EXISTS `cmf_auth_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_auth_rule` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '规则id,自增主键',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '是否有效(0:无效,1:有效)',
  `app` varchar(15) NOT NULL COMMENT '规则所属module',
  `type` varchar(30) NOT NULL DEFAULT '' COMMENT '权限规则分类，请加应用前缀,如admin_',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '规则唯一英文标识,全小写',
  `param` varchar(100) NOT NULL DEFAULT '' COMMENT '额外url参数',
  `title` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '规则描述',
  `condition` varchar(200) NOT NULL DEFAULT '' COMMENT '规则附加条件',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`) USING BTREE,
  KEY `module` (`app`,`status`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=264 DEFAULT CHARSET=utf8mb4 COMMENT='权限规则表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_auth_rule`
--

LOCK TABLES `cmf_auth_rule` WRITE;
/*!40000 ALTER TABLE `cmf_auth_rule` DISABLE KEYS */;
INSERT INTO `cmf_auth_rule` VALUES (1,1,'admin','admin_url','admin/Hook/index','','钩子管理',''),(2,1,'admin','admin_url','admin/Hook/plugins','','钩子插件管理',''),(3,1,'admin','admin_url','admin/Hook/pluginListOrder','','钩子插件排序',''),(4,1,'admin','admin_url','admin/Hook/sync','','同步钩子',''),(5,1,'admin','admin_url','admin/Link/index','','友情链接',''),(6,1,'admin','admin_url','admin/Link/add','','添加友情链接',''),(7,1,'admin','admin_url','admin/Link/addPost','','添加友情链接提交保存',''),(8,1,'admin','admin_url','admin/Link/edit','','编辑友情链接',''),(9,1,'admin','admin_url','admin/Link/editPost','','编辑友情链接提交保存',''),(10,1,'admin','admin_url','admin/Link/delete','','删除友情链接',''),(11,1,'admin','admin_url','admin/Link/listOrder','','友情链接排序',''),(12,1,'admin','admin_url','admin/Link/toggle','','友情链接显示隐藏',''),(13,1,'admin','admin_url','admin/Mailer/index','','邮箱配置',''),(14,1,'admin','admin_url','admin/Mailer/indexPost','','邮箱配置提交保存',''),(15,1,'admin','admin_url','admin/Mailer/template','','邮件模板',''),(16,1,'admin','admin_url','admin/Mailer/templatePost','','邮件模板提交',''),(17,1,'admin','admin_url','admin/Mailer/test','','邮件发送测试',''),(18,1,'admin','admin_url','admin/Menu/index','','后台菜单',''),(19,1,'admin','admin_url','admin/Menu/lists','','所有菜单',''),(20,1,'admin','admin_url','admin/Menu/add','','后台菜单添加',''),(21,1,'admin','admin_url','admin/Menu/addPost','','后台菜单添加提交保存',''),(22,1,'admin','admin_url','admin/Menu/edit','','后台菜单编辑',''),(23,1,'admin','admin_url','admin/Menu/editPost','','后台菜单编辑提交保存',''),(24,1,'admin','admin_url','admin/Menu/delete','','后台菜单删除',''),(25,1,'admin','admin_url','admin/Menu/listOrder','','后台菜单排序',''),(26,1,'admin','admin_url','admin/Menu/getActions','','导入新后台菜单',''),(27,1,'admin','admin_url','admin/Nav/index','','导航管理',''),(28,1,'admin','admin_url','admin/Nav/add','','添加导航',''),(29,1,'admin','admin_url','admin/Nav/addPost','','添加导航提交保存',''),(30,1,'admin','admin_url','admin/Nav/edit','','编辑导航',''),(31,1,'admin','admin_url','admin/Nav/editPost','','编辑导航提交保存',''),(32,1,'admin','admin_url','admin/Nav/delete','','删除导航',''),(33,1,'admin','admin_url','admin/NavMenu/index','','导航菜单',''),(34,1,'admin','admin_url','admin/NavMenu/add','','添加导航菜单',''),(35,1,'admin','admin_url','admin/NavMenu/addPost','','添加导航菜单提交保存',''),(36,1,'admin','admin_url','admin/NavMenu/edit','','编辑导航菜单',''),(37,1,'admin','admin_url','admin/NavMenu/editPost','','编辑导航菜单提交保存',''),(38,1,'admin','admin_url','admin/NavMenu/delete','','删除导航菜单',''),(39,1,'admin','admin_url','admin/NavMenu/listOrder','','导航菜单排序',''),(40,1,'admin','admin_url','admin/Plugin/default','','插件管理',''),(41,1,'admin','admin_url','admin/Plugin/index','','插件列表',''),(42,1,'admin','admin_url','admin/Plugin/toggle','','插件启用禁用',''),(43,1,'admin','admin_url','admin/Plugin/setting','','插件设置',''),(44,1,'admin','admin_url','admin/Plugin/settingPost','','插件设置提交',''),(45,1,'admin','admin_url','admin/Plugin/install','','插件安装',''),(46,1,'admin','admin_url','admin/Plugin/update','','插件更新',''),(47,1,'admin','admin_url','admin/Plugin/uninstall','','卸载插件',''),(48,1,'admin','admin_url','admin/Rbac/index','','角色管理',''),(49,1,'admin','admin_url','admin/Rbac/roleAdd','','添加角色',''),(50,1,'admin','admin_url','admin/Rbac/roleAddPost','','添加角色提交',''),(51,1,'admin','admin_url','admin/Rbac/roleEdit','','编辑角色',''),(52,1,'admin','admin_url','admin/Rbac/roleEditPost','','编辑角色提交',''),(53,1,'admin','admin_url','admin/Rbac/roleDelete','','删除角色',''),(54,1,'admin','admin_url','admin/Rbac/authorize','','设置角色权限',''),(55,1,'admin','admin_url','admin/Rbac/authorizePost','','角色授权提交',''),(56,1,'admin','admin_url','admin/RecycleBin/index','','回收站',''),(57,1,'admin','admin_url','admin/RecycleBin/restore','','回收站还原',''),(58,1,'admin','admin_url','admin/RecycleBin/delete','','回收站彻底删除',''),(59,1,'admin','admin_url','admin/Route/index','','URL美化',''),(60,1,'admin','admin_url','admin/Route/add','','添加路由规则',''),(61,1,'admin','admin_url','admin/Route/addPost','','添加路由规则提交',''),(62,1,'admin','admin_url','admin/Route/edit','','路由规则编辑',''),(63,1,'admin','admin_url','admin/Route/editPost','','路由规则编辑提交',''),(64,1,'admin','admin_url','admin/Route/delete','','路由规则删除',''),(65,1,'admin','admin_url','admin/Route/ban','','路由规则禁用',''),(66,1,'admin','admin_url','admin/Route/open','','路由规则启用',''),(67,1,'admin','admin_url','admin/Route/listOrder','','路由规则排序',''),(68,1,'admin','admin_url','admin/Route/select','','选择URL',''),(69,1,'admin','admin_url','admin/Setting/default','','设置',''),(70,1,'admin','admin_url','admin/Setting/site','','网站信息',''),(71,1,'admin','admin_url','admin/Setting/sitePost','','网站信息设置提交',''),(72,1,'admin','admin_url','admin/Setting/password','','密码修改',''),(73,1,'admin','admin_url','admin/Setting/passwordPost','','密码修改提交',''),(74,1,'admin','admin_url','admin/Setting/upload','','上传设置',''),(75,1,'admin','admin_url','admin/Setting/uploadPost','','上传设置提交',''),(76,1,'admin','admin_url','admin/Setting/clearCache','','清除缓存',''),(77,1,'admin','admin_url','admin/Slide/index','','幻灯片管理',''),(78,1,'admin','admin_url','admin/Slide/add','','添加幻灯片',''),(79,1,'admin','admin_url','admin/Slide/addPost','','添加幻灯片提交',''),(80,1,'admin','admin_url','admin/Slide/edit','','编辑幻灯片',''),(81,1,'admin','admin_url','admin/Slide/editPost','','编辑幻灯片提交',''),(82,1,'admin','admin_url','admin/Slide/delete','','删除幻灯片',''),(83,1,'admin','admin_url','admin/SlideItem/index','','幻灯片页面列表',''),(84,1,'admin','admin_url','admin/SlideItem/add','','幻灯片页面添加',''),(85,1,'admin','admin_url','admin/SlideItem/addPost','','幻灯片页面添加提交',''),(86,1,'admin','admin_url','admin/SlideItem/edit','','幻灯片页面编辑',''),(87,1,'admin','admin_url','admin/SlideItem/editPost','','幻灯片页面编辑提交',''),(88,1,'admin','admin_url','admin/SlideItem/delete','','幻灯片页面删除',''),(89,1,'admin','admin_url','admin/SlideItem/ban','','幻灯片页面隐藏',''),(90,1,'admin','admin_url','admin/SlideItem/cancelBan','','幻灯片页面显示',''),(91,1,'admin','admin_url','admin/SlideItem/listOrder','','幻灯片页面排序',''),(92,1,'admin','admin_url','admin/Storage/index','','文件存储',''),(93,1,'admin','admin_url','admin/Storage/settingPost','','文件存储设置提交',''),(94,1,'admin','admin_url','admin/Theme/index','','模板管理',''),(95,1,'admin','admin_url','admin/Theme/install','','安装模板',''),(96,1,'admin','admin_url','admin/Theme/uninstall','','卸载模板',''),(97,1,'admin','admin_url','admin/Theme/installTheme','','模板安装',''),(98,1,'admin','admin_url','admin/Theme/update','','模板更新',''),(99,1,'admin','admin_url','admin/Theme/active','','启用模板',''),(100,1,'admin','admin_url','admin/Theme/files','','模板文件列表',''),(101,1,'admin','admin_url','admin/Theme/fileSetting','','模板文件设置',''),(102,1,'admin','admin_url','admin/Theme/fileArrayData','','模板文件数组数据列表',''),(103,1,'admin','admin_url','admin/Theme/fileArrayDataEdit','','模板文件数组数据添加编辑',''),(104,1,'admin','admin_url','admin/Theme/fileArrayDataEditPost','','模板文件数组数据添加编辑提交保存',''),(105,1,'admin','admin_url','admin/Theme/fileArrayDataDelete','','模板文件数组数据删除',''),(106,1,'admin','admin_url','admin/Theme/settingPost','','模板文件编辑提交保存',''),(107,1,'admin','admin_url','admin/Theme/dataSource','','模板文件设置数据源',''),(108,1,'admin','admin_url','admin/User/default','','管理组',''),(109,1,'admin','admin_url','admin/User/index','','管理员',''),(110,1,'admin','admin_url','admin/User/add','','管理员添加',''),(111,1,'admin','admin_url','admin/User/addPost','','管理员添加提交',''),(112,1,'admin','admin_url','admin/User/edit','','管理员编辑',''),(113,1,'admin','admin_url','admin/User/editPost','','管理员编辑提交',''),(114,1,'admin','admin_url','admin/User/userInfo','','个人信息',''),(115,1,'admin','admin_url','admin/User/userInfoPost','','管理员个人信息修改提交',''),(116,1,'admin','admin_url','admin/User/delete','','管理员删除',''),(117,1,'admin','admin_url','admin/User/ban','','停用管理员',''),(118,1,'admin','admin_url','admin/User/cancelBan','','启用管理员',''),(119,1,'portal','admin_url','portal/AdminArticle/index','','文章管理',''),(120,1,'portal','admin_url','portal/AdminArticle/add','','添加文章',''),(121,1,'portal','admin_url','portal/AdminArticle/addPost','','添加文章提交',''),(122,1,'portal','admin_url','portal/AdminArticle/edit','','编辑文章',''),(123,1,'portal','admin_url','portal/AdminArticle/editPost','','编辑文章提交',''),(124,1,'portal','admin_url','portal/AdminArticle/delete','','文章删除',''),(125,1,'portal','admin_url','portal/AdminArticle/publish','','文章发布',''),(126,1,'portal','admin_url','portal/AdminArticle/top','','文章置顶',''),(127,1,'portal','admin_url','portal/AdminArticle/recommend','','文章推荐',''),(128,1,'portal','admin_url','portal/AdminArticle/listOrder','','文章排序',''),(129,1,'portal','admin_url','portal/AdminCategory/index','','分类管理',''),(130,1,'portal','admin_url','portal/AdminCategory/add','','添加文章分类',''),(131,1,'portal','admin_url','portal/AdminCategory/addPost','','添加文章分类提交',''),(132,1,'portal','admin_url','portal/AdminCategory/edit','','编辑文章分类',''),(133,1,'portal','admin_url','portal/AdminCategory/editPost','','编辑文章分类提交',''),(134,1,'portal','admin_url','portal/AdminCategory/select','','文章分类选择对话框',''),(135,1,'portal','admin_url','portal/AdminCategory/listOrder','','文章分类排序',''),(136,1,'portal','admin_url','portal/AdminCategory/delete','','删除文章分类',''),(137,1,'portal','admin_url','portal/AdminIndex/default','','门户管理',''),(138,1,'portal','admin_url','portal/AdminPage/index','','页面管理',''),(139,1,'portal','admin_url','portal/AdminPage/add','','添加页面',''),(140,1,'portal','admin_url','portal/AdminPage/addPost','','添加页面提交',''),(141,1,'portal','admin_url','portal/AdminPage/edit','','编辑页面',''),(142,1,'portal','admin_url','portal/AdminPage/editPost','','编辑页面提交',''),(143,1,'portal','admin_url','portal/AdminPage/delete','','删除页面',''),(144,1,'portal','admin_url','portal/AdminTag/index','','文章标签',''),(145,1,'portal','admin_url','portal/AdminTag/add','','添加文章标签',''),(146,1,'portal','admin_url','portal/AdminTag/addPost','','添加文章标签提交',''),(147,1,'portal','admin_url','portal/AdminTag/upStatus','','更新标签状态',''),(148,1,'portal','admin_url','portal/AdminTag/delete','','删除文章标签',''),(149,1,'user','admin_url','user/AdminAsset/index','','资源管理',''),(150,1,'user','admin_url','user/AdminAsset/delete','','删除文件',''),(151,1,'user','admin_url','user/AdminIndex/default','','用户管理',''),(152,1,'user','admin_url','user/AdminIndex/default1','','用户组',''),(153,1,'user','admin_url','user/AdminIndex/index','','本站用户',''),(154,1,'user','admin_url','user/AdminIndex/ban','','本站用户拉黑',''),(155,1,'user','admin_url','user/AdminIndex/cancelBan','','本站用户启用',''),(156,1,'user','admin_url','user/AdminOauth/index','','第三方用户',''),(157,1,'user','admin_url','user/AdminOauth/delete','','删除第三方用户绑定',''),(158,1,'user','admin_url','user/AdminUserAction/index','','用户操作管理',''),(159,1,'user','admin_url','user/AdminUserAction/edit','','编辑用户操作',''),(160,1,'user','admin_url','user/AdminUserAction/editPost','','编辑用户操作提交',''),(161,1,'user','admin_url','user/AdminUserAction/sync','','同步用户操作',''),(162,1,'admin','admin_url','admin/Attr/index','','产品属性管理',''),(163,1,'admin','admin_url','admin/Attr/edit','','产品属性编辑',''),(164,1,'admin','admin_url','admin/Attr/editPost','','产品属性编辑1',''),(165,1,'admin','admin_url','admin/Attr/delete','','产品属性删除',''),(166,1,'admin','admin_url','admin/Attr/add','','产品属性添加',''),(167,1,'admin','admin_url','admin/Attr/addPost','','产品属性添加1',''),(168,1,'admin','admin_url','admin/Cate/index','','产品分类管理',''),(169,1,'admin','admin_url','admin/Cate/add','','添加产品分类',''),(170,1,'admin','admin_url','admin/Cate/addPost','','添加产品分类提交',''),(171,1,'admin','admin_url','admin/Cate/edit','','编辑产品分类',''),(172,1,'admin','admin_url','admin/Cate/editPost','','编辑产品分类提交',''),(173,1,'admin','admin_url','admin/Cate/select','','产品分类选择对话框',''),(174,1,'admin','admin_url','admin/Cate/sort','','产品分类排序',''),(175,1,'admin','admin_url','admin/Cate/delete','','删除产品分类',''),(176,1,'admin','admin_url','admin/Goods/default','','产品管理',''),(177,1,'admin','admin_url','admin/Goods/index','','产品名称列表',''),(178,1,'admin','admin_url','admin/Goods/edit','','产品编辑',''),(179,1,'admin','admin_url','admin/Goods/editPost','','产品编辑_执行',''),(180,1,'admin','admin_url','admin/Goods/delete','','产品删除',''),(181,1,'admin','admin_url','admin/Goods/add','','产品添加',''),(182,1,'admin','admin_url','admin/Goods/addPost','','产品添加_执行',''),(183,1,'admin','admin_url','admin/Goods/goods_attr','','产品规格详情',''),(184,1,'admin','admin_url','admin/Goods/sort','','产品属性排序',''),(185,1,'admin','admin_url','admin/Goods/attr_edit','','产品规格编辑',''),(186,1,'admin','admin_url','admin/Goods/attr_editPost','','属性编辑_执行',''),(187,1,'admin','admin_url','admin/Goods/attr_add','','属性添加',''),(188,1,'admin','admin_url','admin/Goods/attr_addPost','','属性添加_执行',''),(189,1,'admin','admin_url','admin/Instore/default','','产品入库',''),(190,1,'admin','admin_url','admin/Instore/index','','产品入库记录',''),(191,1,'admin','admin_url','admin/Instore/add','','添加产品入库',''),(192,1,'admin','admin_url','admin/Instore/addPost','','添加产品入库提交',''),(193,1,'admin','admin_url','admin/Instore/edit','','编辑产品入库',''),(194,1,'admin','admin_url','admin/Instore/editPost','','编辑产品入库提交',''),(195,1,'admin','admin_url','admin/Instore/select','','产品入库选择对话框',''),(196,1,'admin','admin_url','admin/Instore/delete','','删除产品入库',''),(197,1,'admin','admin_url','admin/Instore/instores','','产品入库单',''),(198,1,'admin','admin_url','admin/Instore/instore_add','','添加产品入库记录',''),(199,1,'admin','admin_url','admin/Instore/instore_delete','','删除产品入库记录',''),(200,1,'admin','admin_url','admin/Instore/review','','审核产品入库 ',''),(201,1,'admin','admin_url','admin/Outstore/default','','产品出库',''),(202,1,'admin','admin_url','admin/Outstore/index','','产品出库记录',''),(203,1,'admin','admin_url','admin/Outstore/outstores','','产品出库单',''),(204,1,'admin','admin_url','admin/Outstore/add','','添加产品出库',''),(205,1,'admin','admin_url','admin/Outstore/outstore_add','','添加产品出库记录',''),(206,1,'admin','admin_url','admin/Outstore/outstore_delete','','删除产品出库记录',''),(207,1,'admin','admin_url','admin/Outstore/addPost','','添加产品出库提交',''),(208,1,'admin','admin_url','admin/Outstore/edit','','编辑产品出库',''),(209,1,'admin','admin_url','admin/Outstore/editPost','','编辑产品出库提交',''),(210,1,'admin','admin_url','admin/Outstore/review','','审核产品出库 ',''),(211,1,'admin','admin_url','admin/Outstore/delete','','删除产品出库单',''),(212,1,'admin','admin_url','admin/GoodsStore/admin/GoodsStore/default','','仓库管理',''),(213,1,'admin','admin_url','admin/GoodsStore/index','','产品库存',''),(214,1,'admin','admin_url','admin/GoodsStore/default','','仓库管理',''),(215,1,'admin','admin_url','admin/Store/index','','仓库管理',''),(216,1,'admin','admin_url','admin/Store/edit','','仓库编辑',''),(217,1,'admin','admin_url','admin/Store/editPost','','仓库编辑1',''),(218,1,'admin','admin_url','admin/Store/delete','','仓库删除',''),(219,1,'admin','admin_url','admin/Store/add','','仓库添加',''),(220,1,'admin','admin_url','admin/Store/addPost','','仓库添加1',''),(221,1,'admin','admin_url','admin/Customer/index','','顾客管理',''),(222,1,'admin','admin_url','admin/Customer/edit','','顾客编辑',''),(223,1,'admin','admin_url','admin/Customer/editPost','','顾客编辑1',''),(224,1,'admin','admin_url','admin/Customer/delete','','顾客删除',''),(225,1,'admin','admin_url','admin/Customer/add','','顾客添加',''),(226,1,'admin','admin_url','admin/Customer/addPost','','顾客添加1',''),(227,1,'admin','admin_url','admin/Customer/sort','','顾客排序',''),(228,1,'admin','admin_url','admin/Store/sort','','仓库排序',''),(229,1,'admin','admin_url','admin/Supplier/index','','供货商管理',''),(230,1,'admin','admin_url','admin/Supplier/edit','','供货商编辑',''),(231,1,'admin','admin_url','admin/Supplier/editPost','','供货商编辑1',''),(232,1,'admin','admin_url','admin/Supplier/delete','','供货商删除',''),(233,1,'admin','admin_url','admin/Supplier/add','','供货商添加',''),(234,1,'admin','admin_url','admin/Supplier/addPost','','供货商添加1',''),(235,1,'admin','admin_url','admin/Supplier/sort','','供货商排序',''),(236,1,'admin','admin_url','admin/Worker/index','','员工管理',''),(237,1,'admin','admin_url','admin/Worker/edit','','员工编辑',''),(238,1,'admin','admin_url','admin/Worker/editPost','','员工编辑1',''),(239,1,'admin','admin_url','admin/Worker/delete','','员工删除',''),(240,1,'admin','admin_url','admin/Worker/add','','员工添加',''),(241,1,'admin','admin_url','admin/Worker/addPost','','员工添加1',''),(242,1,'admin','admin_url','admin/Worker/sort','','员工排序',''),(243,1,'admin','admin_url','admin/Action/index','','管理员操作记录',''),(244,1,'admin','admin_url','admin/Goods/attr_delete','','产品规格删除',''),(245,1,'admin','admin_url','admin/Instore/excel','','导出excel',''),(246,1,'admin','admin_url','admin/Sql/index','','数据库操作',''),(247,1,'admin','admin_url','admin/Sql/add','','数据库备份',''),(248,1,'admin','admin_url','admin/Sql/restore','','数据库还原',''),(249,1,'admin','admin_url','admin/Sql/del','','数据库删除备份',''),(250,1,'admin','admin_url','admin/Sql/dels','','数据库批量删除备份',''),(251,1,'admin','admin_url','admin/Count/index','','出入库统计',''),(252,1,'admin','admin_url','admin/Goods/excel','','导出excel',''),(253,1,'admin','admin_url','admin/GoodsStore/clear','','清理库存',''),(254,1,'admin','admin_url','admin/Outstore/excel','','导出excel',''),(255,1,'admin','admin_url','admin/Count/default','','数据统计',''),(256,1,'admin','admin_url','admin/Count/search','','出入库统计查询',''),(257,1,'admin','admin_url','admin/Count/seller','','销售统计查询',''),(258,1,'admin','admin_url','admin/Goods/excel0','','导出excel图片',''),(259,1,'admin','admin_url','admin/Sql/query','',' 数据库查询',''),(260,1,'admin','admin_url','admin/Count/buyer','','进货统计查询',''),(261,1,'admin','admin_url','admin/Config/index','','网站配置',''),(262,1,'admin','admin_url','admin/Config/editPost','','网站配置编辑1',''),(263,1,'admin','admin_url','admin/Outstore/excel0','','销售导出excel','');
/*!40000 ALTER TABLE `cmf_auth_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_cate`
--

DROP TABLE IF EXISTS `cmf_cate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_cate` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'cate',
  `name` varchar(50) NOT NULL COMMENT '名称',
  `dsc` varchar(100) NOT NULL DEFAULT '' COMMENT '简介',
  `sort` int(1) NOT NULL DEFAULT '5' COMMENT '排序',
  `insert_time` int(11) NOT NULL COMMENT '添加时间',
  `time` int(11) NOT NULL COMMENT '更新时间',
  `parent_id` int(11) NOT NULL COMMENT '父id',
  `path` varchar(50) NOT NULL COMMENT '父子关系路径',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_cate`
--

LOCK TABLES `cmf_cate` WRITE;
/*!40000 ALTER TABLE `cmf_cate` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_cate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_comment`
--

DROP TABLE IF EXISTS `cmf_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_comment` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '被回复的评论id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '发表评论的用户id',
  `to_user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '被评论的用户id',
  `object_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评论内容 id',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评论时间',
  `delete_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '删除时间',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态,1:已审核,0:未审核',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '评论类型；1实名评论',
  `table_name` varchar(64) NOT NULL DEFAULT '' COMMENT '评论内容所在表，不带表前缀',
  `full_name` varchar(50) NOT NULL DEFAULT '' COMMENT '评论者昵称',
  `email` varchar(255) NOT NULL DEFAULT '' COMMENT '评论者邮箱',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '层级关系',
  `url` text COMMENT '原文地址',
  `content` text COMMENT '评论内容',
  `more` text COMMENT '扩展属性',
  PRIMARY KEY (`id`),
  KEY `comment_post_ID` (`object_id`),
  KEY `comment_approved_date_gmt` (`status`),
  KEY `comment_parent` (`parent_id`),
  KEY `table_id_status` (`table_name`,`object_id`,`status`),
  KEY `createtime` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评论表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_comment`
--

LOCK TABLES `cmf_comment` WRITE;
/*!40000 ALTER TABLE `cmf_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_customer`
--

DROP TABLE IF EXISTS `cmf_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_customer` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '顾客id',
  `name` varchar(50) NOT NULL,
  `sort` smallint(1) NOT NULL DEFAULT '5',
  `insert_time` int(11) NOT NULL DEFAULT '0',
  `time` int(11) NOT NULL DEFAULT '0',
  `dsc` varchar(100) NOT NULL DEFAULT '',
  `status` smallint(1) NOT NULL DEFAULT '1' COMMENT '1正常，0废弃',
  `tel` varchar(20) NOT NULL DEFAULT '',
  `address` varchar(200) NOT NULL DEFAULT '',
  `pic` varchar(100) NOT NULL DEFAULT '' COMMENT '头像图片',
  `pics` text COMMENT '资质，执照等',
  `phone` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_customer`
--

LOCK TABLES `cmf_customer` WRITE;
/*!40000 ALTER TABLE `cmf_customer` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_goods`
--

DROP TABLE IF EXISTS `cmf_goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `cid` int(11) NOT NULL COMMENT 'cate id',
  `dsc` varchar(200) NOT NULL DEFAULT '' COMMENT '简介',
  `sort` smallint(1) NOT NULL DEFAULT '5',
  `time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `insert_time` int(11) NOT NULL DEFAULT '0' COMMENT '插入时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_goods`
--

LOCK TABLES `cmf_goods` WRITE;
/*!40000 ALTER TABLE `cmf_goods` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_goods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_goods_attr`
--

DROP TABLE IF EXISTS `cmf_goods_attr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_goods_attr` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gid` int(11) NOT NULL COMMENT 'goods id',
  `attr` varchar(50) NOT NULL COMMENT 'attr name，大小颜色等',
  `inprice` decimal(8,2) NOT NULL COMMENT '预期进价',
  `outprice` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '预期售价',
  `sort` smallint(1) NOT NULL DEFAULT '5',
  `sn` varchar(30) NOT NULL DEFAULT '0' COMMENT '商品sn号',
  `sn0` varchar(30) NOT NULL DEFAULT '' COMMENT '没有sn,手动输入',
  `unit` varchar(10) NOT NULL COMMENT '单位，袋，盒',
  `pic` varchar(100) NOT NULL DEFAULT '',
  `time` int(11) NOT NULL DEFAULT '0',
  `insert_time` int(11) NOT NULL DEFAULT '0',
  `dsc` varchar(100) NOT NULL DEFAULT '' COMMENT '简介',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sn0sn` (`sn0`,`sn`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_goods_attr`
--

LOCK TABLES `cmf_goods_attr` WRITE;
/*!40000 ALTER TABLE `cmf_goods_attr` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_goods_attr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_goods_store`
--

DROP TABLE IF EXISTS `cmf_goods_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_goods_store` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '库存表',
  `store` int(11) NOT NULL COMMENT 'store id',
  `goods` int(11) NOT NULL COMMENT 'goods_attr id',
  `num` int(11) NOT NULL DEFAULT '0' COMMENT '数量',
  `time` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `gs` (`store`,`goods`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_goods_store`
--

LOCK TABLES `cmf_goods_store` WRITE;
/*!40000 ALTER TABLE `cmf_goods_store` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_goods_store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_hook`
--

DROP TABLE IF EXISTS `cmf_hook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_hook` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '钩子类型(1:系统钩子;2:应用钩子;3:模板钩子)',
  `once` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否只允许一个插件运行(0:多个;1:一个)',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '钩子名称',
  `hook` varchar(50) NOT NULL DEFAULT '' COMMENT '钩子',
  `app` varchar(15) NOT NULL DEFAULT '' COMMENT '应用名(只有应用钩子才用)',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COMMENT='系统钩子表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_hook`
--

LOCK TABLES `cmf_hook` WRITE;
/*!40000 ALTER TABLE `cmf_hook` DISABLE KEYS */;
INSERT INTO `cmf_hook` VALUES (1,1,0,'应用初始化','app_init','cmf','应用初始化'),(2,1,0,'应用开始','app_begin','cmf','应用开始'),(3,1,0,'模块初始化','module_init','cmf','模块初始化'),(4,1,0,'控制器开始','action_begin','cmf','控制器开始'),(5,1,0,'视图输出过滤','view_filter','cmf','视图输出过滤'),(6,1,0,'应用结束','app_end','cmf','应用结束'),(7,1,0,'日志write方法','log_write','cmf','日志write方法'),(8,1,0,'输出结束','response_end','cmf','输出结束'),(9,1,0,'后台控制器初始化','admin_init','cmf','后台控制器初始化'),(10,1,0,'前台控制器初始化','home_init','cmf','前台控制器初始化'),(11,1,1,'发送手机验证码','send_mobile_verification_code','cmf','发送手机验证码'),(12,3,0,'模板 body标签开始','body_start','','模板 body标签开始'),(13,3,0,'模板 head标签结束前','before_head_end','','模板 head标签结束前'),(14,3,0,'模板底部开始','footer_start','','模板底部开始'),(15,3,0,'模板底部开始之前','before_footer','','模板底部开始之前'),(16,3,0,'模板底部结束之前','before_footer_end','','模板底部结束之前'),(17,3,0,'模板 body 标签结束之前','before_body_end','','模板 body 标签结束之前'),(18,3,0,'模板左边栏开始','left_sidebar_start','','模板左边栏开始'),(19,3,0,'模板左边栏结束之前','before_left_sidebar_end','','模板左边栏结束之前'),(20,3,0,'模板右边栏开始','right_sidebar_start','','模板右边栏开始'),(21,3,0,'模板右边栏结束之前','before_right_sidebar_end','','模板右边栏结束之前'),(22,3,1,'评论区','comment','','评论区'),(23,3,1,'留言区','guestbook','','留言区'),(24,2,0,'后台首页仪表盘','admin_dashboard','admin','后台首页仪表盘'),(25,4,0,'后台模板 head标签结束前','admin_before_head_end','','后台模板 head标签结束前'),(26,4,0,'后台模板 body 标签结束之前','admin_before_body_end','','后台模板 body 标签结束之前'),(27,2,0,'后台登录页面','admin_login','admin','后台登录页面'),(28,1,1,'前台模板切换','switch_theme','cmf','前台模板切换'),(29,3,0,'主要内容之后','after_content','','主要内容之后'),(30,2,0,'文章显示之前','portal_before_assign_article','portal','文章显示之前'),(31,2,0,'后台文章保存之后','portal_admin_after_save_article','portal','后台文章保存之后');
/*!40000 ALTER TABLE `cmf_hook` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_hook_plugin`
--

DROP TABLE IF EXISTS `cmf_hook_plugin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_hook_plugin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态(0:禁用,1:启用)',
  `hook` varchar(50) NOT NULL DEFAULT '' COMMENT '钩子名',
  `plugin` varchar(30) NOT NULL DEFAULT '' COMMENT '插件',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统钩子插件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_hook_plugin`
--

LOCK TABLES `cmf_hook_plugin` WRITE;
/*!40000 ALTER TABLE `cmf_hook_plugin` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_hook_plugin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_instore`
--

DROP TABLE IF EXISTS `cmf_instore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_instore` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '入库记录',
  `oid` varchar(50) NOT NULL COMMENT '入库单号',
  `cid` int(11) NOT NULL,
  `cname` varchar(50) NOT NULL COMMENT '入库商品类名',
  `gname` varchar(100) NOT NULL COMMENT 'goods name',
  `gid` int(11) NOT NULL COMMENT 'good id',
  `gaid` int(11) NOT NULL DEFAULT '0' COMMENT 'goods_attr id',
  `gsn` varchar(30) NOT NULL COMMENT '商品条码',
  `gsn0` varchar(30) NOT NULL DEFAULT '',
  `ganame` varchar(50) NOT NULL DEFAULT '' COMMENT 'attr name',
  `unit` varchar(10) NOT NULL COMMENT '单位',
  `num` int(11) NOT NULL DEFAULT '1' COMMENT '数量',
  `inprice` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '进价',
  `cprice` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '总进价',
  `inprice0` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '参考进价',
  `dsc` varchar(50) NOT NULL DEFAULT '' COMMENT '备注',
  `time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_instore`
--

LOCK TABLES `cmf_instore` WRITE;
/*!40000 ALTER TABLE `cmf_instore` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_instore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_instore_info`
--

DROP TABLE IF EXISTS `cmf_instore_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_instore_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '入库单',
  `oid` varchar(50) NOT NULL COMMENT '入库单号',
  `seller_id` int(11) NOT NULL DEFAULT '0' COMMENT '供货商',
  `seller_name` varchar(50) NOT NULL DEFAULT '0',
  `buyer_id` int(11) NOT NULL DEFAULT '0' COMMENT '采购员',
  `buyer_name` varchar(50) NOT NULL DEFAULT '0',
  `store_id` int(11) NOT NULL DEFAULT '0' COMMENT '仓库',
  `store_name` varchar(50) NOT NULL DEFAULT '0',
  `time` int(11) NOT NULL COMMENT '更新时间',
  `cprice` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '总进价',
  `cdsc` varchar(100) NOT NULL DEFAULT '' COMMENT '备注',
  `rdsc` varchar(100) NOT NULL DEFAULT '' COMMENT '审核备注',
  `count` int(11) NOT NULL DEFAULT '0' COMMENT '合计品种',
  `num` int(11) NOT NULL DEFAULT '0' COMMENT '合计数量',
  `aid0` int(11) NOT NULL DEFAULT '0' COMMENT '操作人',
  `aname0` varchar(50) NOT NULL DEFAULT '',
  `aid1` int(11) NOT NULL DEFAULT '0' COMMENT '审核人',
  `aname1` varchar(50) NOT NULL DEFAULT '',
  `status` smallint(1) NOT NULL DEFAULT '0' COMMENT '0未提交，1已提交，2已审核，3审核不通过',
  `insert_time` int(11) NOT NULL COMMENT '入库时间',
  `freight` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '运费',
  `is_freight` smallint(1) NOT NULL DEFAULT '0' COMMENT '是否支付运费，0不支付，2支付',
  `cprice1` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '计算运费后的总价',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_instore_info`
--

LOCK TABLES `cmf_instore_info` WRITE;
/*!40000 ALTER TABLE `cmf_instore_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_instore_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_link`
--

DROP TABLE IF EXISTS `cmf_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_link` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态;1:显示;0:不显示',
  `rating` int(11) NOT NULL DEFAULT '0' COMMENT '友情链接评级',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '友情链接描述',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '友情链接地址',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '友情链接名称',
  `image` varchar(100) NOT NULL DEFAULT '' COMMENT '友情链接图标',
  `target` varchar(10) NOT NULL DEFAULT '' COMMENT '友情链接打开方式',
  `rel` varchar(50) NOT NULL DEFAULT '' COMMENT '链接与网站的关系',
  PRIMARY KEY (`id`),
  KEY `link_visible` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='友情链接表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_link`
--

LOCK TABLES `cmf_link` WRITE;
/*!40000 ALTER TABLE `cmf_link` DISABLE KEYS */;
INSERT INTO `cmf_link` VALUES (1,1,1,8,'thinkcmf官网','http://www.thinkcmf.com','ThinkCMF','','_blank','');
/*!40000 ALTER TABLE `cmf_link` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_nav`
--

DROP TABLE IF EXISTS `cmf_nav`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_nav` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `is_main` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '是否为主导航;1:是;0:不是',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '导航位置名称',
  `remark` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='前台导航位置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_nav`
--

LOCK TABLES `cmf_nav` WRITE;
/*!40000 ALTER TABLE `cmf_nav` DISABLE KEYS */;
INSERT INTO `cmf_nav` VALUES (1,1,'主导航','主导航'),(2,0,'底部导航','');
/*!40000 ALTER TABLE `cmf_nav` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_nav_menu`
--

DROP TABLE IF EXISTS `cmf_nav_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_nav_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nav_id` int(11) NOT NULL COMMENT '导航 id',
  `parent_id` int(11) NOT NULL COMMENT '父 id',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态;1:显示;0:隐藏',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '菜单名称',
  `target` varchar(10) NOT NULL DEFAULT '' COMMENT '打开方式',
  `href` varchar(100) NOT NULL DEFAULT '' COMMENT '链接',
  `icon` varchar(20) NOT NULL DEFAULT '' COMMENT '图标',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '层级关系',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='前台导航菜单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_nav_menu`
--

LOCK TABLES `cmf_nav_menu` WRITE;
/*!40000 ALTER TABLE `cmf_nav_menu` DISABLE KEYS */;
INSERT INTO `cmf_nav_menu` VALUES (1,1,0,1,0,'首页','','home','','0-1');
/*!40000 ALTER TABLE `cmf_nav_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_option`
--

DROP TABLE IF EXISTS `cmf_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_option` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `autoload` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '是否自动加载;1:自动加载;0:不自动加载',
  `option_name` varchar(64) NOT NULL DEFAULT '' COMMENT '配置名',
  `option_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '配置值',
  PRIMARY KEY (`id`),
  UNIQUE KEY `option_name` (`option_name`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='全站配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_option`
--

LOCK TABLES `cmf_option` WRITE;
/*!40000 ALTER TABLE `cmf_option` DISABLE KEYS */;
INSERT INTO `cmf_option` VALUES (7,1,'site_info','{\"site_name\":\"zz\\u4ed3\\u5e93\\u7ba1\\u7406\\u7cfb\\u7edf\",\"site_seo_title\":\"zz\\u4ed3\\u5e93\\u7ba1\\u7406\\u7cfb\\u7edf\",\"site_seo_keywords\":\"zz,\\u4ed3\\u5e93\\u7ba1\\u7406\\u7cfb\\u7edf\",\"site_seo_description\":\"zz\\u4ed3\\u5e93\\u7ba1\\u7406\\u7cfb\\u7edf\\u662f\\u7528thinkcmf5\\u5f00\\u53d1\\u7684\",\"site_icp\":\"\",\"site_admin_email\":\"\",\"site_analytics\":\"\",\"urlmode\":\"1\",\"html_suffix\":\"\"}'),(11,1,'cmf_settings','{\"open_registration\":\"0\",\"banned_usernames\":\"\"}'),(12,1,'cdn_settings','{\"cdn_static_root\":\"\"}'),(13,1,'admin_settings','{\"admin_password\":\"\",\"admin_style\":\"flatadmin\"}'),(14,1,'smtp_setting','{\"from_name\":\"\\u534e\\u521b\\u5728\\u7ebf\\u8fdb\\u9500\\u5b58\\u7ba1\\u7406\\u7cfb\\u7edf\",\"from\":\"1132974092@qq.com\",\"host\":\"smtp.qq.com\",\"smtp_secure\":\"ssl\",\"port\":\"465\",\"username\":\"1132974092@qq.com\",\"password\":\"ptepiejuitcegacg\"}');
/*!40000 ALTER TABLE `cmf_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_outstore`
--

DROP TABLE IF EXISTS `cmf_outstore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_outstore` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '入库记录',
  `oid` varchar(50) NOT NULL COMMENT '出库单号',
  `cid` int(11) NOT NULL,
  `cname` varchar(50) NOT NULL COMMENT '商品类名',
  `gname` varchar(100) NOT NULL COMMENT 'goods name',
  `gid` int(11) NOT NULL COMMENT 'good id',
  `gaid` int(11) NOT NULL DEFAULT '0' COMMENT 'goods_attr id',
  `gsn` varchar(30) NOT NULL COMMENT '商品条码',
  `gsn0` varchar(30) NOT NULL DEFAULT '',
  `ganame` varchar(50) NOT NULL DEFAULT '' COMMENT 'attr name',
  `unit` varchar(10) NOT NULL COMMENT '单位',
  `num` int(11) NOT NULL DEFAULT '1' COMMENT '数量',
  `outprice` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '出库价',
  `cprice` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '总出库价',
  `outprice0` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '参考出库价',
  `dsc` varchar(50) NOT NULL DEFAULT '' COMMENT '备注',
  `time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_outstore`
--

LOCK TABLES `cmf_outstore` WRITE;
/*!40000 ALTER TABLE `cmf_outstore` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_outstore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_outstore_info`
--

DROP TABLE IF EXISTS `cmf_outstore_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_outstore_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '入库单',
  `oid` varchar(50) NOT NULL COMMENT '出库单号',
  `seller_id` int(11) NOT NULL DEFAULT '0' COMMENT '售货员',
  `seller_name` varchar(50) NOT NULL DEFAULT '0',
  `buyer_id` int(11) NOT NULL DEFAULT '0' COMMENT '顾客',
  `buyer_name` varchar(50) NOT NULL DEFAULT '0',
  `store_id` int(11) NOT NULL DEFAULT '0' COMMENT '仓库',
  `store_name` varchar(50) NOT NULL DEFAULT '0',
  `time` int(11) NOT NULL COMMENT '更新时间',
  `cprice` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '总价',
  `cdsc` varchar(100) NOT NULL DEFAULT '' COMMENT '备注',
  `rdsc` varchar(100) NOT NULL DEFAULT '' COMMENT '审核备注',
  `count` int(11) NOT NULL DEFAULT '0' COMMENT '合计品种',
  `num` int(11) NOT NULL DEFAULT '0' COMMENT '合计数量',
  `aid0` int(11) NOT NULL DEFAULT '0' COMMENT '操作人',
  `aname0` varchar(50) NOT NULL DEFAULT '',
  `aid1` int(11) NOT NULL DEFAULT '0' COMMENT '审核人',
  `aname1` varchar(50) NOT NULL DEFAULT '',
  `status` smallint(1) NOT NULL DEFAULT '0' COMMENT '0未提交，1已提交，2已审核，3审核不通过',
  `insert_time` int(11) NOT NULL COMMENT '入库时间',
  `freight` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '0不负担运费，1负担运费',
  `is_freight` smallint(1) NOT NULL DEFAULT '0',
  `cprice1` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '出单总价',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_outstore_info`
--

LOCK TABLES `cmf_outstore_info` WRITE;
/*!40000 ALTER TABLE `cmf_outstore_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_outstore_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_plugin`
--

DROP TABLE IF EXISTS `cmf_plugin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_plugin` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '插件类型;1:网站;8:微信',
  `has_admin` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否有后台管理,0:没有;1:有',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态;1:开启;0:禁用',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '插件安装时间',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '插件标识名,英文字母(惟一)',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '插件名称',
  `demo_url` varchar(50) NOT NULL DEFAULT '' COMMENT '演示地址，带协议',
  `hooks` varchar(255) NOT NULL DEFAULT '' COMMENT '实现的钩子;以“,”分隔',
  `author` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '插件作者',
  `author_url` varchar(50) NOT NULL DEFAULT '' COMMENT '作者网站链接',
  `version` varchar(20) NOT NULL DEFAULT '' COMMENT '插件版本号',
  `description` varchar(255) NOT NULL COMMENT '插件描述',
  `config` text COMMENT '插件配置',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='插件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_plugin`
--

LOCK TABLES `cmf_plugin` WRITE;
/*!40000 ALTER TABLE `cmf_plugin` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_plugin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_portal_category`
--

DROP TABLE IF EXISTS `cmf_portal_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_portal_category` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '分类父id',
  `post_count` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '分类文章数',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态,1:发布,0:不发布',
  `delete_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '删除时间',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '分类名称',
  `description` varchar(255) NOT NULL COMMENT '分类描述',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '分类层级关系路径',
  `seo_title` varchar(100) NOT NULL DEFAULT '',
  `seo_keywords` varchar(255) NOT NULL DEFAULT '',
  `seo_description` varchar(255) NOT NULL DEFAULT '',
  `list_tpl` varchar(50) NOT NULL DEFAULT '' COMMENT '分类列表模板',
  `one_tpl` varchar(50) NOT NULL DEFAULT '' COMMENT '分类文章页模板',
  `more` text COMMENT '扩展属性',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='portal应用 文章分类表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_portal_category`
--

LOCK TABLES `cmf_portal_category` WRITE;
/*!40000 ALTER TABLE `cmf_portal_category` DISABLE KEYS */;
INSERT INTO `cmf_portal_category` VALUES (1,0,0,1,0,10000,'父','','0-1','','','','list','article','{\"thumbnail\":\"\"}');
/*!40000 ALTER TABLE `cmf_portal_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_portal_category_post`
--

DROP TABLE IF EXISTS `cmf_portal_category_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_portal_category_post` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '文章id',
  `category_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '分类id',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态,1:发布;0:不发布',
  PRIMARY KEY (`id`),
  KEY `term_taxonomy_id` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='portal应用 分类文章对应表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_portal_category_post`
--

LOCK TABLES `cmf_portal_category_post` WRITE;
/*!40000 ALTER TABLE `cmf_portal_category_post` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_portal_category_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_portal_post`
--

DROP TABLE IF EXISTS `cmf_portal_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_portal_post` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '父级id',
  `post_type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '类型,1:文章;2:页面',
  `post_format` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '内容格式;1:html;2:md',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '发表者用户id',
  `post_status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态;1:已发布;0:未发布;',
  `comment_status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '评论状态;1:允许;0:不允许',
  `is_top` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否置顶;1:置顶;0:不置顶',
  `recommended` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否推荐;1:推荐;0:不推荐',
  `post_hits` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '查看数',
  `post_like` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '点赞数',
  `comment_count` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '评论数',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `published_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '发布时间',
  `delete_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '删除时间',
  `post_title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'post标题',
  `post_keywords` varchar(150) NOT NULL DEFAULT '' COMMENT 'seo keywords',
  `post_excerpt` varchar(500) NOT NULL DEFAULT '' COMMENT 'post摘要',
  `post_source` varchar(150) NOT NULL DEFAULT '' COMMENT '转载文章的来源',
  `post_content` text COMMENT '文章内容',
  `post_content_filtered` text COMMENT '处理过的文章内容',
  `more` text COMMENT '扩展属性,如缩略图;格式为json',
  PRIMARY KEY (`id`),
  KEY `type_status_date` (`post_type`,`post_status`,`create_time`,`id`),
  KEY `post_parent` (`parent_id`),
  KEY `post_author` (`user_id`),
  KEY `post_date` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='portal应用 文章表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_portal_post`
--

LOCK TABLES `cmf_portal_post` WRITE;
/*!40000 ALTER TABLE `cmf_portal_post` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_portal_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_portal_tag`
--

DROP TABLE IF EXISTS `cmf_portal_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_portal_tag` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态,1:发布,0:不发布',
  `recommended` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否推荐;1:推荐;0:不推荐',
  `post_count` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '标签文章数',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '标签名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='portal应用 文章标签表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_portal_tag`
--

LOCK TABLES `cmf_portal_tag` WRITE;
/*!40000 ALTER TABLE `cmf_portal_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_portal_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_portal_tag_post`
--

DROP TABLE IF EXISTS `cmf_portal_tag_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_portal_tag_post` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tag_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '标签 id',
  `post_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '文章 id',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态,1:发布;0:不发布',
  PRIMARY KEY (`id`),
  KEY `term_taxonomy_id` (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='portal应用 标签文章对应表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_portal_tag_post`
--

LOCK TABLES `cmf_portal_tag_post` WRITE;
/*!40000 ALTER TABLE `cmf_portal_tag_post` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_portal_tag_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_recycle_bin`
--

DROP TABLE IF EXISTS `cmf_recycle_bin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_recycle_bin` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `object_id` int(11) DEFAULT '0' COMMENT '删除内容 id',
  `create_time` int(10) unsigned DEFAULT '0' COMMENT '创建时间',
  `table_name` varchar(60) DEFAULT '' COMMENT '删除内容所在表名',
  `name` varchar(255) DEFAULT '' COMMENT '删除内容名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT=' 回收站';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_recycle_bin`
--

LOCK TABLES `cmf_recycle_bin` WRITE;
/*!40000 ALTER TABLE `cmf_recycle_bin` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_recycle_bin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_role`
--

DROP TABLE IF EXISTS `cmf_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_role` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父角色ID',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态;0:禁用;1:正常',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `list_order` float NOT NULL DEFAULT '0' COMMENT '排序',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '角色名称',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `parentId` (`parent_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COMMENT='角色表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_role`
--

LOCK TABLES `cmf_role` WRITE;
/*!40000 ALTER TABLE `cmf_role` DISABLE KEYS */;
INSERT INTO `cmf_role` VALUES (1,0,1,1329633709,1329633709,0,'超级管理员','拥有网站最高管理员权限！'),(2,0,1,1329633709,1329633709,0,'总管理员','网站最高管理员'),(3,0,1,0,0,0,'总经理','除角色管理、数据库操作其他权限都有'),(4,0,1,0,0,0,'入库员','有入库权限，可以查看产品、出库等信息'),(5,0,1,0,0,0,'出库员','有出库权限，可以查看入库信息、产品、库存等信息');
/*!40000 ALTER TABLE `cmf_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_role_user`
--

DROP TABLE IF EXISTS `cmf_role_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_role_user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '角色 id',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  PRIMARY KEY (`id`),
  KEY `group_id` (`role_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='用户角色对应表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_role_user`
--

LOCK TABLES `cmf_role_user` WRITE;
/*!40000 ALTER TABLE `cmf_role_user` DISABLE KEYS */;
INSERT INTO `cmf_role_user` VALUES (2,2,3),(3,3,4),(4,5,5),(5,4,5);
/*!40000 ALTER TABLE `cmf_role_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_route`
--

DROP TABLE IF EXISTS `cmf_route`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_route` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '路由id',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态;1:启用,0:不启用',
  `type` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'URL规则类型;1:用户自定义;2:别名添加',
  `full_url` varchar(255) NOT NULL DEFAULT '' COMMENT '完整url',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '实际显示的url',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='url路由表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_route`
--

LOCK TABLES `cmf_route` WRITE;
/*!40000 ALTER TABLE `cmf_route` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_route` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_slide`
--

DROP TABLE IF EXISTS `cmf_slide`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_slide` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态,1:显示,0不显示',
  `delete_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '删除时间',
  `name` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '幻灯片分类',
  `remark` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '分类备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='幻灯片表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_slide`
--

LOCK TABLES `cmf_slide` WRITE;
/*!40000 ALTER TABLE `cmf_slide` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_slide` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_slide_item`
--

DROP TABLE IF EXISTS `cmf_slide_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_slide_item` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `slide_id` int(11) NOT NULL DEFAULT '0' COMMENT '幻灯片id',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态,1:显示;0:隐藏',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '幻灯片名称',
  `image` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '幻灯片图片',
  `url` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '幻灯片链接',
  `target` varchar(10) NOT NULL DEFAULT '' COMMENT '友情链接打开方式',
  `description` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT '幻灯片描述',
  `content` text CHARACTER SET utf8 COMMENT '幻灯片内容',
  `more` text COMMENT '链接打开方式',
  PRIMARY KEY (`id`),
  KEY `slide_cid` (`slide_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='幻灯片子项表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_slide_item`
--

LOCK TABLES `cmf_slide_item` WRITE;
/*!40000 ALTER TABLE `cmf_slide_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_slide_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_store`
--

DROP TABLE IF EXISTS `cmf_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_store` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '仓库id',
  `name` varchar(50) NOT NULL,
  `sort` smallint(1) NOT NULL DEFAULT '5',
  `insert_time` int(11) NOT NULL DEFAULT '0',
  `time` int(11) NOT NULL DEFAULT '0',
  `dsc` varchar(100) NOT NULL DEFAULT '',
  `status` smallint(1) NOT NULL DEFAULT '1' COMMENT '默认1正常，0废弃',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_store`
--

LOCK TABLES `cmf_store` WRITE;
/*!40000 ALTER TABLE `cmf_store` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_supplier`
--

DROP TABLE IF EXISTS `cmf_supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_supplier` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '供货商id',
  `name` varchar(50) NOT NULL,
  `sort` smallint(1) NOT NULL DEFAULT '5',
  `insert_time` int(11) NOT NULL DEFAULT '0',
  `time` int(11) NOT NULL DEFAULT '0',
  `dsc` varchar(100) NOT NULL DEFAULT '',
  `status` smallint(1) NOT NULL DEFAULT '1' COMMENT '默认1正常，0废弃',
  `tel` varchar(20) NOT NULL DEFAULT '',
  `address` varchar(200) NOT NULL DEFAULT '',
  `pic` varchar(100) NOT NULL DEFAULT '',
  `pics` text COMMENT '资质材料等',
  `phone` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_supplier`
--

LOCK TABLES `cmf_supplier` WRITE;
/*!40000 ALTER TABLE `cmf_supplier` DISABLE KEYS */;
INSERT INTO `cmf_supplier` VALUES (1,'徽农1',5,1514430850,1515728937,'',1,'15122222222','的点点滴滴多多多多','admin/20180108/ff74431023272c855b619a9cf8040acf.png','admin/20180108/a763898341b29dfb908e6760f39e52eb.png','15211122233'),(2,'供应商2',5,1514430850,1515229373,'',0,'','','',NULL,'');
/*!40000 ALTER TABLE `cmf_supplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_theme`
--

DROP TABLE IF EXISTS `cmf_theme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_theme` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '安装时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后升级时间',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '模板状态,1:正在使用;0:未使用',
  `is_compiled` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否为已编译模板',
  `theme` varchar(20) NOT NULL DEFAULT '' COMMENT '主题目录名，用于主题的维一标识',
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '主题名称',
  `version` varchar(20) NOT NULL DEFAULT '' COMMENT '主题版本号',
  `demo_url` varchar(50) NOT NULL DEFAULT '' COMMENT '演示地址，带协议',
  `thumbnail` varchar(100) NOT NULL DEFAULT '' COMMENT '缩略图',
  `author` varchar(20) NOT NULL DEFAULT '' COMMENT '主题作者',
  `author_url` varchar(50) NOT NULL DEFAULT '' COMMENT '作者网站链接',
  `lang` varchar(10) NOT NULL DEFAULT '' COMMENT '支持语言',
  `keywords` varchar(50) NOT NULL DEFAULT '' COMMENT '主题关键字',
  `description` varchar(100) NOT NULL DEFAULT '' COMMENT '主题描述',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_theme`
--

LOCK TABLES `cmf_theme` WRITE;
/*!40000 ALTER TABLE `cmf_theme` DISABLE KEYS */;
INSERT INTO `cmf_theme` VALUES (19,0,0,0,0,'simpleboot3','simpleboot3','1.0.2','http://demo.thinkcmf.com','','ThinkCMF','http://www.thinkcmf.com','zh-cn','ThinkCMF模板','ThinkCMF默认模板');
/*!40000 ALTER TABLE `cmf_theme` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_theme_file`
--

DROP TABLE IF EXISTS `cmf_theme_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_theme_file` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `is_public` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否公共的模板文件',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `theme` varchar(20) NOT NULL DEFAULT '' COMMENT '模板名称',
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '模板文件名',
  `action` varchar(50) NOT NULL DEFAULT '' COMMENT '操作',
  `file` varchar(50) NOT NULL DEFAULT '' COMMENT '模板文件，相对于模板根目录，如Portal/index.html',
  `description` varchar(100) NOT NULL DEFAULT '' COMMENT '模板文件描述',
  `more` text COMMENT '模板更多配置,用户自己后台设置的',
  `config_more` text COMMENT '模板更多配置,来源模板的配置文件',
  `draft_more` text COMMENT '模板更多配置,用户临时保存的配置',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=113 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_theme_file`
--

LOCK TABLES `cmf_theme_file` WRITE;
/*!40000 ALTER TABLE `cmf_theme_file` DISABLE KEYS */;
INSERT INTO `cmf_theme_file` VALUES (105,0,10,'simpleboot3','文章页','portal/Article/index','portal/article','文章页模板文件','{\"vars\":{\"hot_articles_category_id\":{\"title\":\"Hot Articles\\u5206\\u7c7bID\",\"name\":\"hot_articles_category_id\",\"value\":\"1\",\"type\":\"text\",\"tip\":\"\",\"rule\":[]}}}','{\"vars\":{\"hot_articles_category_id\":{\"title\":\"Hot Articles\\u5206\\u7c7bID\",\"name\":\"hot_articles_category_id\",\"value\":\"1\",\"type\":\"text\",\"tip\":\"\",\"rule\":[]}}}',NULL),(106,0,10,'simpleboot3','联系我们页','portal/Page/index','portal/contact','联系我们页模板文件','{\"vars\":{\"baidu_map_info_window_text\":{\"title\":\"\\u767e\\u5ea6\\u5730\\u56fe\\u6807\\u6ce8\\u6587\\u5b57\",\"name\":\"baidu_map_info_window_text\",\"value\":\"ThinkCMF<br\\/><span class=\'\'>\\u5730\\u5740\\uff1a\\u4e0a\\u6d77\\u5e02\\u5f90\\u6c47\\u533a\\u659c\\u571f\\u8def2601\\u53f7<\\/span>\",\"type\":\"text\",\"tip\":\"\\u767e\\u5ea6\\u5730\\u56fe\\u6807\\u6ce8\\u6587\\u5b57,\\u652f\\u6301\\u7b80\\u5355html\\u4ee3\\u7801\",\"rule\":[]},\"company_location\":{\"title\":\"\\u516c\\u53f8\\u5750\\u6807\",\"value\":\"\",\"type\":\"location\",\"tip\":\"\",\"rule\":{\"require\":true}},\"address_cn\":{\"title\":\"\\u516c\\u53f8\\u5730\\u5740\",\"value\":\"\\u4e0a\\u6d77\\u5e02\\u5f90\\u6c47\\u533a\\u659c\\u571f\\u8def0001\\u53f7\",\"type\":\"text\",\"tip\":\"\",\"rule\":{\"require\":true}},\"address_en\":{\"title\":\"\\u516c\\u53f8\\u5730\\u5740\\uff08\\u82f1\\u6587\\uff09\",\"value\":\"NO.0001 Xie Tu Road, Shanghai China\",\"type\":\"text\",\"tip\":\"\",\"rule\":{\"require\":true}},\"email\":{\"title\":\"\\u516c\\u53f8\\u90ae\\u7bb1\",\"value\":\"catman@thinkcmf.com\",\"type\":\"text\",\"tip\":\"\",\"rule\":{\"require\":true}},\"phone_cn\":{\"title\":\"\\u516c\\u53f8\\u7535\\u8bdd\",\"value\":\"021 1000 0001\",\"type\":\"text\",\"tip\":\"\",\"rule\":{\"require\":true}},\"phone_en\":{\"title\":\"\\u516c\\u53f8\\u7535\\u8bdd\\uff08\\u82f1\\u6587\\uff09\",\"value\":\"+8621 1000 0001\",\"type\":\"text\",\"tip\":\"\",\"rule\":{\"require\":true}},\"qq\":{\"title\":\"\\u8054\\u7cfbQQ\",\"value\":\"478519726\",\"type\":\"text\",\"tip\":\"\\u591a\\u4e2a QQ\\u4ee5\\u82f1\\u6587\\u9017\\u53f7\\u9694\\u5f00\",\"rule\":{\"require\":true}}}}','{\"vars\":{\"baidu_map_info_window_text\":{\"title\":\"\\u767e\\u5ea6\\u5730\\u56fe\\u6807\\u6ce8\\u6587\\u5b57\",\"name\":\"baidu_map_info_window_text\",\"value\":\"ThinkCMF<br\\/><span class=\'\'>\\u5730\\u5740\\uff1a\\u4e0a\\u6d77\\u5e02\\u5f90\\u6c47\\u533a\\u659c\\u571f\\u8def2601\\u53f7<\\/span>\",\"type\":\"text\",\"tip\":\"\\u767e\\u5ea6\\u5730\\u56fe\\u6807\\u6ce8\\u6587\\u5b57,\\u652f\\u6301\\u7b80\\u5355html\\u4ee3\\u7801\",\"rule\":[]},\"company_location\":{\"title\":\"\\u516c\\u53f8\\u5750\\u6807\",\"value\":\"\",\"type\":\"location\",\"tip\":\"\",\"rule\":{\"require\":true}},\"address_cn\":{\"title\":\"\\u516c\\u53f8\\u5730\\u5740\",\"value\":\"\\u4e0a\\u6d77\\u5e02\\u5f90\\u6c47\\u533a\\u659c\\u571f\\u8def0001\\u53f7\",\"type\":\"text\",\"tip\":\"\",\"rule\":{\"require\":true}},\"address_en\":{\"title\":\"\\u516c\\u53f8\\u5730\\u5740\\uff08\\u82f1\\u6587\\uff09\",\"value\":\"NO.0001 Xie Tu Road, Shanghai China\",\"type\":\"text\",\"tip\":\"\",\"rule\":{\"require\":true}},\"email\":{\"title\":\"\\u516c\\u53f8\\u90ae\\u7bb1\",\"value\":\"catman@thinkcmf.com\",\"type\":\"text\",\"tip\":\"\",\"rule\":{\"require\":true}},\"phone_cn\":{\"title\":\"\\u516c\\u53f8\\u7535\\u8bdd\",\"value\":\"021 1000 0001\",\"type\":\"text\",\"tip\":\"\",\"rule\":{\"require\":true}},\"phone_en\":{\"title\":\"\\u516c\\u53f8\\u7535\\u8bdd\\uff08\\u82f1\\u6587\\uff09\",\"value\":\"+8621 1000 0001\",\"type\":\"text\",\"tip\":\"\",\"rule\":{\"require\":true}},\"qq\":{\"title\":\"\\u8054\\u7cfbQQ\",\"value\":\"478519726\",\"type\":\"text\",\"tip\":\"\\u591a\\u4e2a QQ\\u4ee5\\u82f1\\u6587\\u9017\\u53f7\\u9694\\u5f00\",\"rule\":{\"require\":true}}}}',NULL),(107,0,5,'simpleboot3','首页','portal/Index/index','portal/index','首页模板文件','{\"vars\":{\"top_slide\":{\"title\":\"\\u9876\\u90e8\\u5e7b\\u706f\\u7247\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"admin\\/Slide\\/index\",\"multi\":false},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u9876\\u90e8\\u5e7b\\u706f\\u7247\",\"tip\":\"\",\"rule\":{\"require\":true}}},\"widgets\":{\"features\":{\"title\":\"\\u5feb\\u901f\\u4e86\\u89e3ThinkCMF\",\"display\":\"1\",\"vars\":{\"sub_title\":{\"title\":\"\\u526f\\u6807\\u9898\",\"value\":\"Quickly understand the ThinkCMF\",\"type\":\"text\",\"placeholder\":\"\\u8bf7\\u8f93\\u5165\\u526f\\u6807\\u9898\",\"tip\":\"\",\"rule\":{\"require\":true}},\"features\":{\"title\":\"\\u7279\\u6027\\u4ecb\\u7ecd\",\"value\":[{\"title\":\"MVC\\u5206\\u5c42\\u6a21\\u5f0f\",\"icon\":\"bars\",\"content\":\"\\u4f7f\\u7528MVC\\u5e94\\u7528\\u7a0b\\u5e8f\\u88ab\\u5206\\u6210\\u4e09\\u4e2a\\u6838\\u5fc3\\u90e8\\u4ef6\\uff1a\\u6a21\\u578b\\uff08M\\uff09\\u3001\\u89c6\\u56fe\\uff08V\\uff09\\u3001\\u63a7\\u5236\\u5668\\uff08C\\uff09\\uff0c\\u4ed6\\u4e0d\\u662f\\u4e00\\u4e2a\\u65b0\\u7684\\u6982\\u5ff5\\uff0c\\u53ea\\u662fThinkCMF\\u5c06\\u5176\\u53d1\\u6325\\u5230\\u4e86\\u6781\\u81f4\\u3002\"},{\"title\":\"\\u7528\\u6237\\u7ba1\\u7406\",\"icon\":\"group\",\"content\":\"ThinkCMF\\u5185\\u7f6e\\u4e86\\u7075\\u6d3b\\u7684\\u7528\\u6237\\u7ba1\\u7406\\u65b9\\u5f0f\\uff0c\\u5e76\\u53ef\\u76f4\\u63a5\\u4e0e\\u7b2c\\u4e09\\u65b9\\u7ad9\\u70b9\\u8fdb\\u884c\\u4e92\\u8054\\u4e92\\u901a\\uff0c\\u5982\\u679c\\u4f60\\u613f\\u610f\\u751a\\u81f3\\u53ef\\u4ee5\\u5bf9\\u5355\\u4e2a\\u7528\\u6237\\u6216\\u7fa4\\u4f53\\u7528\\u6237\\u7684\\u884c\\u4e3a\\u8fdb\\u884c\\u8bb0\\u5f55\\u53ca\\u5206\\u4eab\\uff0c\\u4e3a\\u60a8\\u7684\\u8fd0\\u8425\\u51b3\\u7b56\\u63d0\\u4f9b\\u6709\\u6548\\u53c2\\u8003\\u6570\\u636e\\u3002\"},{\"title\":\"\\u4e91\\u7aef\\u90e8\\u7f72\",\"icon\":\"cloud\",\"content\":\"\\u901a\\u8fc7\\u9a71\\u52a8\\u7684\\u65b9\\u5f0f\\u53ef\\u4ee5\\u8f7b\\u677e\\u652f\\u6301\\u4e91\\u5e73\\u53f0\\u7684\\u90e8\\u7f72\\uff0c\\u8ba9\\u4f60\\u7684\\u7f51\\u7ad9\\u65e0\\u7f1d\\u8fc1\\u79fb\\uff0c\\u5185\\u7f6e\\u5df2\\u7ecf\\u652f\\u6301SAE\\u3001BAE\\uff0c\\u6b63\\u5f0f\\u7248\\u5c06\\u5bf9\\u4e91\\u7aef\\u90e8\\u7f72\\u8fdb\\u884c\\u8fdb\\u4e00\\u6b65\\u4f18\\u5316\\u3002\"},{\"title\":\"\\u5b89\\u5168\\u7b56\\u7565\",\"icon\":\"heart\",\"content\":\"\\u63d0\\u4f9b\\u7684\\u7a33\\u5065\\u7684\\u5b89\\u5168\\u7b56\\u7565\\uff0c\\u5305\\u62ec\\u5907\\u4efd\\u6062\\u590d\\uff0c\\u5bb9\\u9519\\uff0c\\u9632\\u6cbb\\u6076\\u610f\\u653b\\u51fb\\u767b\\u9646\\uff0c\\u7f51\\u9875\\u9632\\u7be1\\u6539\\u7b49\\u591a\\u9879\\u5b89\\u5168\\u7ba1\\u7406\\u529f\\u80fd\\uff0c\\u4fdd\\u8bc1\\u7cfb\\u7edf\\u5b89\\u5168\\uff0c\\u53ef\\u9760\\uff0c\\u7a33\\u5b9a\\u7684\\u8fd0\\u884c\\u3002\"},{\"title\":\"\\u5e94\\u7528\\u6a21\\u5757\\u5316\",\"icon\":\"cubes\",\"content\":\"\\u63d0\\u51fa\\u5168\\u65b0\\u7684\\u5e94\\u7528\\u6a21\\u5f0f\\u8fdb\\u884c\\u6269\\u5c55\\uff0c\\u4e0d\\u7ba1\\u662f\\u4f60\\u5f00\\u53d1\\u4e00\\u4e2a\\u5c0f\\u529f\\u80fd\\u8fd8\\u662f\\u4e00\\u4e2a\\u5168\\u65b0\\u7684\\u7ad9\\u70b9\\uff0c\\u5728ThinkCMF\\u4e2d\\u4f60\\u53ea\\u662f\\u589e\\u52a0\\u4e86\\u4e00\\u4e2aAPP\\uff0c\\u6bcf\\u4e2a\\u72ec\\u7acb\\u8fd0\\u884c\\u4e92\\u4e0d\\u5f71\\u54cd\\uff0c\\u4fbf\\u4e8e\\u7075\\u6d3b\\u6269\\u5c55\\u548c\\u4e8c\\u6b21\\u5f00\\u53d1\\u3002\"},{\"title\":\"\\u514d\\u8d39\\u5f00\\u6e90\",\"icon\":\"certificate\",\"content\":\"\\u4ee3\\u7801\\u9075\\u5faaApache2\\u5f00\\u6e90\\u534f\\u8bae\\uff0c\\u514d\\u8d39\\u4f7f\\u7528\\uff0c\\u5bf9\\u5546\\u4e1a\\u7528\\u6237\\u4e5f\\u65e0\\u4efb\\u4f55\\u9650\\u5236\\u3002\"}],\"type\":\"array\",\"item\":{\"title\":{\"title\":\"\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"icon\":{\"title\":\"\\u56fe\\u6807\",\"value\":\"\",\"type\":\"text\"},\"content\":{\"title\":\"\\u63cf\\u8ff0\",\"value\":\"\",\"type\":\"textarea\"}},\"tip\":\"\"}}},\"last_news\":{\"title\":\"\\u6700\\u65b0\\u8d44\\u8baf\",\"display\":\"1\",\"vars\":{\"last_news_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true}}}}}}','{\"vars\":{\"top_slide\":{\"title\":\"\\u9876\\u90e8\\u5e7b\\u706f\\u7247\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"admin\\/Slide\\/index\",\"multi\":false},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u9876\\u90e8\\u5e7b\\u706f\\u7247\",\"tip\":\"\",\"rule\":{\"require\":true}}},\"widgets\":{\"features\":{\"title\":\"\\u5feb\\u901f\\u4e86\\u89e3ThinkCMF\",\"display\":\"1\",\"vars\":{\"sub_title\":{\"title\":\"\\u526f\\u6807\\u9898\",\"value\":\"Quickly understand the ThinkCMF\",\"type\":\"text\",\"placeholder\":\"\\u8bf7\\u8f93\\u5165\\u526f\\u6807\\u9898\",\"tip\":\"\",\"rule\":{\"require\":true}},\"features\":{\"title\":\"\\u7279\\u6027\\u4ecb\\u7ecd\",\"value\":[{\"title\":\"MVC\\u5206\\u5c42\\u6a21\\u5f0f\",\"icon\":\"bars\",\"content\":\"\\u4f7f\\u7528MVC\\u5e94\\u7528\\u7a0b\\u5e8f\\u88ab\\u5206\\u6210\\u4e09\\u4e2a\\u6838\\u5fc3\\u90e8\\u4ef6\\uff1a\\u6a21\\u578b\\uff08M\\uff09\\u3001\\u89c6\\u56fe\\uff08V\\uff09\\u3001\\u63a7\\u5236\\u5668\\uff08C\\uff09\\uff0c\\u4ed6\\u4e0d\\u662f\\u4e00\\u4e2a\\u65b0\\u7684\\u6982\\u5ff5\\uff0c\\u53ea\\u662fThinkCMF\\u5c06\\u5176\\u53d1\\u6325\\u5230\\u4e86\\u6781\\u81f4\\u3002\"},{\"title\":\"\\u7528\\u6237\\u7ba1\\u7406\",\"icon\":\"group\",\"content\":\"ThinkCMF\\u5185\\u7f6e\\u4e86\\u7075\\u6d3b\\u7684\\u7528\\u6237\\u7ba1\\u7406\\u65b9\\u5f0f\\uff0c\\u5e76\\u53ef\\u76f4\\u63a5\\u4e0e\\u7b2c\\u4e09\\u65b9\\u7ad9\\u70b9\\u8fdb\\u884c\\u4e92\\u8054\\u4e92\\u901a\\uff0c\\u5982\\u679c\\u4f60\\u613f\\u610f\\u751a\\u81f3\\u53ef\\u4ee5\\u5bf9\\u5355\\u4e2a\\u7528\\u6237\\u6216\\u7fa4\\u4f53\\u7528\\u6237\\u7684\\u884c\\u4e3a\\u8fdb\\u884c\\u8bb0\\u5f55\\u53ca\\u5206\\u4eab\\uff0c\\u4e3a\\u60a8\\u7684\\u8fd0\\u8425\\u51b3\\u7b56\\u63d0\\u4f9b\\u6709\\u6548\\u53c2\\u8003\\u6570\\u636e\\u3002\"},{\"title\":\"\\u4e91\\u7aef\\u90e8\\u7f72\",\"icon\":\"cloud\",\"content\":\"\\u901a\\u8fc7\\u9a71\\u52a8\\u7684\\u65b9\\u5f0f\\u53ef\\u4ee5\\u8f7b\\u677e\\u652f\\u6301\\u4e91\\u5e73\\u53f0\\u7684\\u90e8\\u7f72\\uff0c\\u8ba9\\u4f60\\u7684\\u7f51\\u7ad9\\u65e0\\u7f1d\\u8fc1\\u79fb\\uff0c\\u5185\\u7f6e\\u5df2\\u7ecf\\u652f\\u6301SAE\\u3001BAE\\uff0c\\u6b63\\u5f0f\\u7248\\u5c06\\u5bf9\\u4e91\\u7aef\\u90e8\\u7f72\\u8fdb\\u884c\\u8fdb\\u4e00\\u6b65\\u4f18\\u5316\\u3002\"},{\"title\":\"\\u5b89\\u5168\\u7b56\\u7565\",\"icon\":\"heart\",\"content\":\"\\u63d0\\u4f9b\\u7684\\u7a33\\u5065\\u7684\\u5b89\\u5168\\u7b56\\u7565\\uff0c\\u5305\\u62ec\\u5907\\u4efd\\u6062\\u590d\\uff0c\\u5bb9\\u9519\\uff0c\\u9632\\u6cbb\\u6076\\u610f\\u653b\\u51fb\\u767b\\u9646\\uff0c\\u7f51\\u9875\\u9632\\u7be1\\u6539\\u7b49\\u591a\\u9879\\u5b89\\u5168\\u7ba1\\u7406\\u529f\\u80fd\\uff0c\\u4fdd\\u8bc1\\u7cfb\\u7edf\\u5b89\\u5168\\uff0c\\u53ef\\u9760\\uff0c\\u7a33\\u5b9a\\u7684\\u8fd0\\u884c\\u3002\"},{\"title\":\"\\u5e94\\u7528\\u6a21\\u5757\\u5316\",\"icon\":\"cubes\",\"content\":\"\\u63d0\\u51fa\\u5168\\u65b0\\u7684\\u5e94\\u7528\\u6a21\\u5f0f\\u8fdb\\u884c\\u6269\\u5c55\\uff0c\\u4e0d\\u7ba1\\u662f\\u4f60\\u5f00\\u53d1\\u4e00\\u4e2a\\u5c0f\\u529f\\u80fd\\u8fd8\\u662f\\u4e00\\u4e2a\\u5168\\u65b0\\u7684\\u7ad9\\u70b9\\uff0c\\u5728ThinkCMF\\u4e2d\\u4f60\\u53ea\\u662f\\u589e\\u52a0\\u4e86\\u4e00\\u4e2aAPP\\uff0c\\u6bcf\\u4e2a\\u72ec\\u7acb\\u8fd0\\u884c\\u4e92\\u4e0d\\u5f71\\u54cd\\uff0c\\u4fbf\\u4e8e\\u7075\\u6d3b\\u6269\\u5c55\\u548c\\u4e8c\\u6b21\\u5f00\\u53d1\\u3002\"},{\"title\":\"\\u514d\\u8d39\\u5f00\\u6e90\",\"icon\":\"certificate\",\"content\":\"\\u4ee3\\u7801\\u9075\\u5faaApache2\\u5f00\\u6e90\\u534f\\u8bae\\uff0c\\u514d\\u8d39\\u4f7f\\u7528\\uff0c\\u5bf9\\u5546\\u4e1a\\u7528\\u6237\\u4e5f\\u65e0\\u4efb\\u4f55\\u9650\\u5236\\u3002\"}],\"type\":\"array\",\"item\":{\"title\":{\"title\":\"\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"icon\":{\"title\":\"\\u56fe\\u6807\",\"value\":\"\",\"type\":\"text\"},\"content\":{\"title\":\"\\u63cf\\u8ff0\",\"value\":\"\",\"type\":\"textarea\"}},\"tip\":\"\"}}},\"last_news\":{\"title\":\"\\u6700\\u65b0\\u8d44\\u8baf\",\"display\":\"1\",\"vars\":{\"last_news_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true}}}}}}',NULL),(108,0,10,'simpleboot3','文章列表页','portal/List/index','portal/list','文章列表模板文件','{\"vars\":[],\"widgets\":{\"hottest_articles\":{\"title\":\"\\u70ed\\u95e8\\u6587\\u7ae0\",\"display\":\"1\",\"vars\":{\"hottest_articles_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true}}}},\"last_articles\":{\"title\":\"\\u6700\\u65b0\\u53d1\\u5e03\",\"display\":\"1\",\"vars\":{\"last_articles_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true}}}}}}','{\"vars\":[],\"widgets\":{\"hottest_articles\":{\"title\":\"\\u70ed\\u95e8\\u6587\\u7ae0\",\"display\":\"1\",\"vars\":{\"hottest_articles_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true}}}},\"last_articles\":{\"title\":\"\\u6700\\u65b0\\u53d1\\u5e03\",\"display\":\"1\",\"vars\":{\"last_articles_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true}}}}}}',NULL),(109,0,10,'simpleboot3','单页面','portal/Page/index','portal/page','单页面模板文件','{\"widgets\":{\"hottest_articles\":{\"title\":\"\\u70ed\\u95e8\\u6587\\u7ae0\",\"display\":\"1\",\"vars\":{\"hottest_articles_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true}}}},\"last_articles\":{\"title\":\"\\u6700\\u65b0\\u53d1\\u5e03\",\"display\":\"1\",\"vars\":{\"last_articles_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true}}}}}}','{\"widgets\":{\"hottest_articles\":{\"title\":\"\\u70ed\\u95e8\\u6587\\u7ae0\",\"display\":\"1\",\"vars\":{\"hottest_articles_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true}}}},\"last_articles\":{\"title\":\"\\u6700\\u65b0\\u53d1\\u5e03\",\"display\":\"1\",\"vars\":{\"last_articles_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true}}}}}}',NULL),(110,0,10,'simpleboot3','搜索页面','portal/search/index','portal/search','搜索模板文件','{\"vars\":{\"varName1\":{\"title\":\"\\u70ed\\u95e8\\u641c\\u7d22\",\"value\":\"1\",\"type\":\"text\",\"tip\":\"\\u8fd9\\u662f\\u4e00\\u4e2atext\",\"rule\":{\"require\":true}}}}','{\"vars\":{\"varName1\":{\"title\":\"\\u70ed\\u95e8\\u641c\\u7d22\",\"value\":\"1\",\"type\":\"text\",\"tip\":\"\\u8fd9\\u662f\\u4e00\\u4e2atext\",\"rule\":{\"require\":true}}}}',NULL),(111,1,0,'simpleboot3','模板全局配置','public/Config','public/config','模板全局配置文件','{\"vars\":{\"enable_mobile\":{\"title\":\"\\u624b\\u673a\\u6ce8\\u518c\",\"value\":1,\"type\":\"select\",\"options\":{\"1\":\"\\u5f00\\u542f\",\"0\":\"\\u5173\\u95ed\"},\"tip\":\"\"}}}','{\"vars\":{\"enable_mobile\":{\"title\":\"\\u624b\\u673a\\u6ce8\\u518c\",\"value\":1,\"type\":\"select\",\"options\":{\"1\":\"\\u5f00\\u542f\",\"0\":\"\\u5173\\u95ed\"},\"tip\":\"\"}}}',NULL),(112,1,1,'simpleboot3','导航条','public/Nav','public/nav','导航条模板文件','{\"vars\":{\"company_name\":{\"title\":\"\\u516c\\u53f8\\u540d\\u79f0\",\"name\":\"company_name\",\"value\":\"ThinkCMF\",\"type\":\"text\",\"tip\":\"\",\"rule\":[]}}}','{\"vars\":{\"company_name\":{\"title\":\"\\u516c\\u53f8\\u540d\\u79f0\",\"name\":\"company_name\",\"value\":\"ThinkCMF\",\"type\":\"text\",\"tip\":\"\",\"rule\":[]}}}',NULL);
/*!40000 ALTER TABLE `cmf_theme_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_third_party_user`
--

DROP TABLE IF EXISTS `cmf_third_party_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_third_party_user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '本站用户id',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `expire_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'access_token过期时间',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '绑定时间',
  `login_times` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '登录次数',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态;1:正常;0:禁用',
  `nickname` varchar(50) NOT NULL DEFAULT '' COMMENT '用户昵称',
  `third_party` varchar(20) NOT NULL DEFAULT '' COMMENT '第三方惟一码',
  `app_id` varchar(64) NOT NULL DEFAULT '' COMMENT '第三方应用 id',
  `last_login_ip` varchar(15) NOT NULL DEFAULT '' COMMENT '最后登录ip',
  `access_token` varchar(512) NOT NULL DEFAULT '' COMMENT '第三方授权码',
  `openid` varchar(40) NOT NULL DEFAULT '' COMMENT '第三方用户id',
  `union_id` varchar(64) NOT NULL DEFAULT '' COMMENT '第三方用户多个产品中的惟一 id,(如:微信平台)',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='第三方用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_third_party_user`
--

LOCK TABLES `cmf_third_party_user` WRITE;
/*!40000 ALTER TABLE `cmf_third_party_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_third_party_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_user`
--

DROP TABLE IF EXISTS `cmf_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '用户类型;1:admin;2:会员',
  `sex` tinyint(2) NOT NULL DEFAULT '0' COMMENT '性别;0:保密,1:男,2:女',
  `birthday` int(11) NOT NULL DEFAULT '0' COMMENT '生日',
  `last_login_time` int(11) NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `score` int(11) NOT NULL DEFAULT '0' COMMENT '用户积分',
  `coin` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '金币',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '注册时间',
  `user_status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '用户状态;0:禁用,1:正常,2:未验证',
  `user_login` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `user_pass` varchar(64) NOT NULL DEFAULT '' COMMENT '登录密码;cmf_password加密',
  `user_nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '用户昵称',
  `user_email` varchar(100) NOT NULL DEFAULT '' COMMENT '用户登录邮箱',
  `user_url` varchar(100) NOT NULL DEFAULT '' COMMENT '用户个人网址',
  `avatar` varchar(255) NOT NULL DEFAULT '' COMMENT '用户头像',
  `signature` varchar(255) NOT NULL DEFAULT '' COMMENT '个性签名',
  `last_login_ip` varchar(15) NOT NULL DEFAULT '' COMMENT '最后登录ip',
  `user_activation_key` varchar(60) NOT NULL DEFAULT '' COMMENT '激活码',
  `mobile` varchar(20) NOT NULL DEFAULT '' COMMENT '用户手机号',
  `more` text COMMENT '扩展属性',
  `session` varchar(100) NOT NULL DEFAULT '' COMMENT '记录session-id，用于控制唯一登录',
  PRIMARY KEY (`id`),
  KEY `user_login` (`user_login`),
  KEY `user_nickname` (`user_nickname`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_user`
--

LOCK TABLES `cmf_user` WRITE;
/*!40000 ALTER TABLE `cmf_user` DISABLE KEYS */;
INSERT INTO `cmf_user` VALUES (1,1,1,-28800,1515745789,0,0,1511837497,1,'super','###31be300c119b92c9e29be71692fee7c8','似懂非懂','infinitezheng@qq.com','','','','127.0.0.1','','',NULL,'6bcdf28b050c02bf96016f580d875585e5e9d7fa8ef34457c2bd6cb638154898'),(3,1,0,0,1515738854,0,0,0,1,'admin0','###2ea0c0704a042e1a4aa1b72d3753991f','','infinitezheng11@qq.com','','','','127.0.0.1','','',NULL,'3732a7fa4f72d3620cb68447e1bae8304db7bba2653a8dc3dce549e1c945f40f'),(4,1,0,-28800,1515736232,0,0,0,1,'manager','###2ea0c0704a042e1a4aa1b72d3753991f','总经理','manager@cc.om','','','','127.0.0.1','','',NULL,'79fbaa22af61b8afd3f79d60a9dd0c9e64a681af67dd465e7d02cc6b93c88c65'),(5,1,0,0,1515739164,0,0,0,1,'store','###2ea0c0704a042e1a4aa1b72d3753991f','','store@cc.com','','','','127.0.0.1','','',NULL,'9656d9bccc9bbddc0e4d6e8ba13b8b1935295415f3688a21927712047261bf88');
/*!40000 ALTER TABLE `cmf_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_user_action`
--

DROP TABLE IF EXISTS `cmf_user_action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_user_action` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `score` int(11) NOT NULL DEFAULT '0' COMMENT '更改积分，可以为负',
  `coin` int(11) NOT NULL DEFAULT '0' COMMENT '更改金币，可以为负',
  `reward_number` int(11) NOT NULL DEFAULT '0' COMMENT '奖励次数',
  `cycle_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '周期类型;0:不限;1:按天;2:按小时;3:永久',
  `cycle_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '周期时间值',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '用户操作名称',
  `action` varchar(50) NOT NULL DEFAULT '' COMMENT '用户操作名称',
  `app` varchar(50) NOT NULL DEFAULT '' COMMENT '操作所在应用名或插件名等',
  `url` text COMMENT '执行操作的url',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户操作表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_user_action`
--

LOCK TABLES `cmf_user_action` WRITE;
/*!40000 ALTER TABLE `cmf_user_action` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_user_action` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_user_action_log`
--

DROP TABLE IF EXISTS `cmf_user_action_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_user_action_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '访问次数',
  `last_visit_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后访问时间',
  `object` varchar(100) NOT NULL DEFAULT '' COMMENT '访问对象的id,格式:不带前缀的表名+id;如posts1表示xx_posts表里id为1的记录',
  `action` varchar(50) NOT NULL DEFAULT '' COMMENT '操作名称;格式:应用名+控制器+操作名,也可自己定义格式只要不发生冲突且惟一;',
  `ip` varchar(15) NOT NULL DEFAULT '' COMMENT '用户ip',
  PRIMARY KEY (`id`),
  KEY `user_object_action` (`user_id`,`object`,`action`),
  KEY `user_object_action_ip` (`user_id`,`object`,`action`,`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='访问记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_user_action_log`
--

LOCK TABLES `cmf_user_action_log` WRITE;
/*!40000 ALTER TABLE `cmf_user_action_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_user_action_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_user_favorite`
--

DROP TABLE IF EXISTS `cmf_user_favorite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_user_favorite` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户 id',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '收藏内容的标题',
  `url` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '收藏内容的原文地址，不带域名',
  `description` varchar(500) CHARACTER SET utf8 DEFAULT '' COMMENT '收藏内容的描述',
  `table_name` varchar(64) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '收藏实体以前所在表,不带前缀',
  `object_id` int(10) unsigned DEFAULT '0' COMMENT '收藏内容原来的主键id',
  `create_time` int(10) unsigned DEFAULT '0' COMMENT '收藏时间',
  PRIMARY KEY (`id`),
  KEY `uid` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户收藏表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_user_favorite`
--

LOCK TABLES `cmf_user_favorite` WRITE;
/*!40000 ALTER TABLE `cmf_user_favorite` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_user_favorite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_user_login_attempt`
--

DROP TABLE IF EXISTS `cmf_user_login_attempt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_user_login_attempt` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `login_attempts` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '尝试次数',
  `attempt_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '尝试登录时间',
  `locked_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '锁定时间',
  `ip` varchar(15) NOT NULL DEFAULT '' COMMENT '用户 ip',
  `account` varchar(100) NOT NULL DEFAULT '' COMMENT '用户账号,手机号,邮箱或用户名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='用户登录尝试表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_user_login_attempt`
--

LOCK TABLES `cmf_user_login_attempt` WRITE;
/*!40000 ALTER TABLE `cmf_user_login_attempt` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_user_login_attempt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_user_score_log`
--

DROP TABLE IF EXISTS `cmf_user_score_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_user_score_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用户 id',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `action` varchar(50) NOT NULL DEFAULT '' COMMENT '用户操作名称',
  `score` int(11) NOT NULL DEFAULT '0' COMMENT '更改积分，可以为负',
  `coin` int(11) NOT NULL DEFAULT '0' COMMENT '更改金币，可以为负',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户操作积分等奖励日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_user_score_log`
--

LOCK TABLES `cmf_user_score_log` WRITE;
/*!40000 ALTER TABLE `cmf_user_score_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_user_score_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_user_token`
--

DROP TABLE IF EXISTS `cmf_user_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_user_token` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用户id',
  `expire_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT ' 过期时间',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `token` varchar(64) NOT NULL DEFAULT '' COMMENT 'token',
  `device_type` varchar(10) NOT NULL DEFAULT '' COMMENT '设备类型;mobile,android,iphone,ipad,web,pc,mac,wxapp',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COMMENT='用户客户端登录 token 表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_user_token`
--

LOCK TABLES `cmf_user_token` WRITE;
/*!40000 ALTER TABLE `cmf_user_token` DISABLE KEYS */;
INSERT INTO `cmf_user_token` VALUES (3,1,1531297789,1515745789,'6bcdf28b050c02bf96016f580d875585e5e9d7fa8ef34457c2bd6cb638154898','web'),(4,2,1530956305,1515404305,'3c89208fb31983b7fa88956de8698dc800be7d84285f44640616555851f7c6fe','web'),(5,3,1531290854,1515738854,'3732a7fa4f72d3620cb68447e1bae8304db7bba2653a8dc3dce549e1c945f40f','web'),(6,4,1531288232,1515736232,'79fbaa22af61b8afd3f79d60a9dd0c9e64a681af67dd465e7d02cc6b93c88c65','web'),(7,5,1531291164,1515739164,'9656d9bccc9bbddc0e4d6e8ba13b8b1935295415f3688a21927712047261bf88','web');
/*!40000 ALTER TABLE `cmf_user_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_verification_code`
--

DROP TABLE IF EXISTS `cmf_verification_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_verification_code` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '表id',
  `count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '当天已经发送成功的次数',
  `send_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后发送成功时间',
  `expire_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '验证码过期时间',
  `code` varchar(8) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '最后发送成功的验证码',
  `account` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '手机号或者邮箱',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='手机邮箱数字验证码表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_verification_code`
--

LOCK TABLES `cmf_verification_code` WRITE;
/*!40000 ALTER TABLE `cmf_verification_code` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_verification_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmf_worker`
--

DROP TABLE IF EXISTS `cmf_worker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmf_worker` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '购货员，销售员',
  `dsc` varchar(100) NOT NULL DEFAULT '' COMMENT '描述',
  `sort` smallint(1) NOT NULL DEFAULT '5' COMMENT '排序',
  `time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `insert_time` int(11) NOT NULL DEFAULT '0',
  `type` smallint(1) NOT NULL DEFAULT '1' COMMENT '1购货员,2销售员，3购销一体',
  `status` smallint(1) NOT NULL DEFAULT '1' COMMENT '默认1正常，0废弃',
  `phone` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmf_worker`
--

LOCK TABLES `cmf_worker` WRITE;
/*!40000 ALTER TABLE `cmf_worker` DISABLE KEYS */;
/*!40000 ALTER TABLE `cmf_worker` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-01-12 16:41:29

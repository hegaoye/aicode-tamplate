# AI-Code模板仓库

#### 项目介绍
aicode的各个框架的仓库，通过不同的目录来分开管理

#### 软件架构
软件架构说明


#### 安装教程

1. xxxx
2. xxxx
3. xxxx
###1.运行方法：
请修改项目中的jdbc.properties 文件将数据库链接修改成自己的数据地址即可
如:jdbc.url=jdbc:mysql://192.168.10.250:3306/ai_code_simple?useUnicode=true&characterEncoding=utf-8&zeroDateTimeBehavior=round&allowMultiQueries=true
前提是执行了ai-code.sql 脚本，执行后会有原始数据被导入，用于生成过程中的必要数据，请务必保证数据完整未被修改


###2.编写模板说明：
模板采用freemarker 
模板可以拿到如下数据：
${projectName} //项目英文名
${model}   //模块中的模型 -> ${basePackage}.${model}.service
${module} //模块 一个项目的模块化 不参与java的包定义只是项目管理分离办法

${basePackage}  //包名

${table}  //表对象
${tableName}  //表名

${classes}  //类信息对象  集合
${class}  //类对象
${className}  //类名
${classNameLower}  //类名小写

${columns}  //列对象  集合
${pkColumns}  //主键数据信息
${notPkColumns}  //非主键数据信息


${fields}  //类属性  集合
${pkFields}  //主键数据信息
${notPkFields}  //非主键主键数据信息

${notes}  //类注释
${copyright}  //项目版权
${author}  //作者

#### 使用说明
FreeMarker   的内建函数有：
chunk,  is_date,  last,  root,  j_string,  round,   contains ,  is_hash,  long,  float,  ends_with,  namespace,  matches,  time,  values,  seq_last_index_of,  uncap_first,  byte,  substring,  is_transform,  web_safe,  groups,  seq_contains,  is_macro,  index_of,  word_list,  int,  is_method,  eval,  parent,  xml,  number,  capitalize,  if_exists,  rtf,  node_type,  double,  is_directive,  url,  size,  default,  floor,  ceiling, is_boolean,  split,  node_name,  is_enumerable,  seq_index_of,  is_sequence,  sort,  is_node,   
sort_by,  left_pad,  cap_first,  interpret,  children,  node_namespace,  chop_linebreak, date,  short,  last_index_of,  is_collection,  ancestors,  length,  trim,  datetime, is_string,  reverse,  c,  keys,  upper_case,  js_string,  has_content,  right_pad,  replace,  is_hash_ex,  new,  is_number,  lower_case,  is_indexable,  string,  exists,  html,  first
1. xxxx
2. xxxx
3. xxxx

#### 参与贡献

1. Fork 本项目
2. 新建 Feat_xxx 分支
3. 提交代码
4. 新建 Pull Request


#### 码云特技

1. 使用 Readme\_XXX.md 来支持不同的语言，例如 Readme\_en.md, Readme\_zh.md
2. 码云官方博客 [blog.gitee.com](https://blog.gitee.com)
3. 你可以 [https://gitee.com/explore](https://gitee.com/explore) 这个地址来了解码云上的优秀开源项目
4. [GVP](https://gitee.com/gvp) 全称是码云最有价值开源项目，是码云综合评定出的优秀开源项目
5. 码云官方提供的使用手册 [http://git.mydoc.io/](http://git.mydoc.io/)
6. 码云封面人物是一档用来展示码云会员风采的栏目 [https://gitee.com/gitee-stars/](https://gitee.com/gitee-stars/)
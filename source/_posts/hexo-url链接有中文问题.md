---
title: hexo-url链接有中文问题
comments: true
date: 2019-06-17 19:53:40
categories: hexo
tags: 
  - hexo
  - permalink
---

# 使用hexo-abbrlink这个插件来解决url链接有中文乱码问题。

## 安装插件

``` javascript
npm install hexo-abbrlink --save
```

## 配置站点配置文件`_config.yml`

``` yml
permalink: post/:abbrlink.html
abbrlink:
  alg: crc32  # 算法：crc16(default) and crc32
  rep: hex    # 进制：dec(default) and hex
```
<!-- more -->
## 可以修改scaffolds里的模版文件，修改post.md为:

```
---
title: {{ title }}
date: {{ date }}
comments: true
categories:
tags:
---
```
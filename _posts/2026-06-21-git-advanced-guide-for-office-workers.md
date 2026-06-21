---
layout: post
title: "办公文员的Git进阶课：从会用GitHub到不被GitHub卡脖子"
subtitle: "上一篇教你Git是什么，这一篇教你怎么真正用起来——GitHub全攻略+国内替代方案+进阶操作"
date: 2026-06-21
author: "老墨"
header-img: "img/post-bg-unix-linux.jpg"
tags:
  - Git
  - GitHub
  - Gitee
  - 版本管理
  - 办公自动化
  - 教程
categories:
  - 工具教程
---

之前我写过一篇 [《Git到底是个啥？给电脑小白讲的版本管理入门课》](/2026/06/16/git-for-beginners/)，讲了Git的基本概念和五个核心命令。

不少同事看完跟我说："道理我都懂了，但具体怎么用GitHub？公司网络打不开GitHub怎么办？遇到冲突怎么办？"

这些问题非常实在。今天这篇就是来解决这些问题的——**从GitHub的注册使用，到国内替代平台的选择搭建，再到日常工作中真正会遇到的进阶操作**，一步步讲清楚。

不需要你是程序员。只要你会用电脑、会上网、会打字，就能学会。

---

## 第一部分：GitHub 从零到日常使用

### 1. GitHub 是什么？

上一篇文章说过，Git 是"时光机"，帮你记住文件的每次修改。而 **GitHub 就是把这台时光机的存档放到网上**，让你在任何电脑上都能访问，还能跟别人协作。

打个比方：Git 是你手机里的相册，GitHub 就是百度网盘——本地存一份，云端再备份一份，还能分享给别人看。

GitHub 是全球最大的代码托管平台，但它不只是给程序员用的。很多写作者用它管理文档，设计师用它管理设计稿，老师用它管理课件。**任何需要版本管理和协作的东西，都可以放上去。**

### 2. 注册账号

打开 https://github.com ，点击右上角 **Sign up**：

1. **Username（用户名）**：起一个英文名，比如 `dalihaif`。这个名字以后就是你的个人主页地址：`github.com/dalihaif`
2. **Email（邮箱）**：填你常用的邮箱，QQ邮箱、163邮箱都行
3. **Password（密码）**：至少15位，或者至少8位但要包含数字和小写字母

注册完成后，GitHub 会发一封验证邮件到你的邮箱，点击验证链接就好了。

> 建议：用户名一旦注册就不能改，建议用真名拼音或者好记的英文名，别用 `xiaoming123` 这种。

### 3. 安装 Git 并关联 GitHub

首先在你电脑上安装 Git：

- **Windows**：打开 https://git-scm.com/download/win ，下载安装，一路"下一步"
- **macOS**：打开终端（Terminal），输入 `git --version`，系统会自动提示你安装

装好后，打开 **Git Bash**（Windows）或 **终端**（Mac），输入两行命令告诉 Git 你是谁：

```bash
git config --global user.name "你的名字"
git config --global user.email "你的邮箱"
```

比如：

```bash
git config --global user.name "老墨"
git config --global user.email "dlaihaif@qq.com"
```

这两行只做一次就行，以后每次提交都会自动用这个名字和邮箱。

### 4. 创建你的第一个仓库

**在 GitHub 网页上操作：**

1. 登录 GitHub，点击右上角 **+** → **New repository**
2. **Repository name**：给仓库起个名字，比如 `my-blog`、`work-documents`
3. **Description**：可选，写一句描述
4. 勾选 **Public**（公开）或 **Private**（私密）
5. 勾选 **Add a README file**
6. 点击 **Create repository**

恭喜！你的第一个云端仓库就创建好了。

### 5. 把云端仓库拉到本地

在仓库页面，点击绿色的 **Code** 按钮，复制那个 HTTPS 地址（类似 `https://github.com/你的用户名/仓库名.git`）。

然后在你电脑上打开 Git Bash，输入：

```bash
cd 你想放的目录
git clone https://github.com/你的用户名/仓库名.git
```

比如：

```bash
cd D:\work
git clone https://github.com/dalihaif/work-documents.git
```

这会在你的 `D:\work` 下面创建一个 `work-documents` 文件夹，里面已经有了你在 GitHub 上创建的那个 README 文件。**以后你就在这个文件夹里工作。**

### 6. 日常工作四步走

进入仓库文件夹后，每天的流程是这样的：

```bash
# 第一步：拉取最新（上班第一件事）
git pull

# 第二步：干活（改文件、写东西……）

# 第三步：存档（做完了或者到了一个小节点）
git add .
git commit -m "今天改了什么"

# 第四步：推上去（下班前或者做完一个完整功能）
git push
```

**拉 → 干 → 存 → 推**，这四步够你用到退休。

---

## 第二部分：GitHub 常用功能详解

### 1. README 文件——仓库的门面

每个仓库根目录下都应该有一个 `README.md` 文件。这个文件的内容会直接显示在仓库首页，相当于你这个项目的"说明书"。

你可以用它写项目介绍、使用说明、更新日志，任何你想让访客看到的内容。`.md` 是 Markdown 格式，简单说就是用纯文本写、但能显示粗体、标题、列表、图片等格式的轻量级排版语言。

### 2. Issues——问题追踪和任务管理

Issues 是 GitHub 自带的"任务清单"。你可以用它：

- 记录要做的事（待办清单）
- 记录发现的问题
- 讨论方案

点击仓库页面上方的 **Issues** 标签，点 **New issue** 就能创建一条。可以给每条 issue 加标签（Label）、指派负责人（Assignee）、设置里程碑（Milestone）。

**办公场景举例：** 你在做一个档案数字化项目，可以在 Issues 里建这些任务：
- "扫描2024年以前的文书档案" → 标签：待办
- "OCR识别率太低，需要调研更好的方案" → 标签：问题
- "对接医院HIS系统的接口文档" → 标签：文档

### 3. Fork——复制别人的仓库

看到别人的仓库觉得不错，想拿来改改自己用？点仓库右上角的 **Fork** 按钮，GitHub 会把整个仓库复制一份到你的账号下。你就可以随便改了，不影响原作者。

### 4. Pull Request（PR）——请求合并修改

这是 GitHub 协作的核心。流程是这样的：

1. 你 Fork 了别人的仓库
2. 你在自己的副本里做了修改
3. 你觉得改得不错，想让原作者采纳
4. 你发起一个 **Pull Request**（简称 PR），告诉原作者"我改了这些，你看看要不要合并进去"
5. 原作者审查你的修改，觉得OK就点 **Merge**，你的修改就合并到原仓库了

**听起来很程序员？** 其实不是。假设你同事建了一个仓库管理科室的制度文件，你 Fork 了一份，改了几个条款，发起 PR，同事审查后合并——这就是一个完整的协作流程，全程在 GitHub 上完成，不用来回发文件。

### 5. GitHub Pages——免费建站

如果你把仓库设置为 GitHub Pages，GitHub 会自动把你仓库里的 HTML 或 Markdown 文件变成一个网站。

**我现在的博客就是这么搭的**——Jekyll 模板 + GitHub Pages，零成本、零服务器、全球可访问。

设置方法：仓库 → Settings → Pages → Source 选择你的分支 → Save。等几分钟，你的网站就上线了。

---

## 第三部分：GitHub 不好用？这些替代方案你得知道

在国内使用 GitHub，最大的痛点就是——**网速慢、经常打不开、push 失败**。这不是你的问题，是网络环境导致的。

以下是几个靠谱的替代方案，各有优劣。

### 方案一：Gitee（码云）——国内最推荐

**地址：** https://gitee.com

Gitee 是国内最大的代码托管平台，界面跟 GitHub 很像，服务器在国内，速度飞快。

**优点：** 速度快、中文界面、免费额度够用、支持私有仓库
**缺点：** 国际知名度不如 GitHub、部分高级功能需要付费

**注册和使用流程：**

1. 打开 https://gitee.com 注册账号（支持手机号注册）
2. 创建仓库：点右上角 **+** → **新建仓库**
3. 在本地关联 Gitee 仓库：

```bash
# 如果之前关联的是 GitHub，先删掉旧的远程地址
git remote remove origin

# 添加 Gitee 的远程地址
git remote add origin https://gitee.com/你的用户名/仓库名.git

# 推送代码
git push -u origin master
```

就这么简单，跟用 GitHub 一模一样的操作，只是换了个地址。

### 方案二：GitLab——适合团队自建

**地址：** https://gitlab.com（在线版）或自己搭建

GitLab 比 GitHub 功能更强，特别是 CI/CD（自动化部署）方面。它既有在线版（gitlab.com），也可以下载到自己公司的服务器上搭建私有版。

**适合场景：** 公司内部有服务器，想搭一套内部的代码/文档管理平台，数据完全掌控在自己手里。

**自建简单步骤（给公司IT参考）：**

```bash
# 用 Docker 一键部署（需要有 Docker 环境）
docker run --detach \
  --hostname gitlab.company.com \
  --publish 443:443 --publish 80:80 --publish 22:22 \
  --name gitlab \
  --restart always \
  --volume /srv/gitlab/config:/etc/gitlab \
  --volume /srv/gitlab/logs:/var/log/gitlab \
  --volume /srv/gitlab/data:/var/opt/gitlab \
  gitlab/gitlab-ce:latest
```

搭好之后，公司内部所有人访问 `http://gitlab.company.com` 就能用了，速度跟访问局域网一样快。

### 方案三：Coding（腾讯云）——国内项目协作

**地址：** https://coding.net

Coding 是腾讯云旗下的 DevOps 平台，不只是代码托管，还有项目管理、文档管理、CI/CD 等功能。

**适合场景：** 国内团队做项目管理和协作，特别是需要跟腾讯云生态打通的场景。

### 方案四：同时用 GitHub + Gitee 双保险

这是我最推荐的方式——**两个平台都维护，哪个能连就用哪个**。

设置方法：

```bash
# 添加 GitHub 远程仓库（命名为 github）
git remote add github https://github.com/你的用户名/仓库名.git

# 添加 Gitee 远程仓库（命名为 gitee）
git remote add gitee https://gitee.com/你的用户名/仓库名.git

# 推送到 GitHub
git push github master

# 推送到 Gitee
git push gitee master

# 或者一次推到两个平台
git push github master && git push gitee master
```

查看当前有哪些远程仓库：

```bash
git remote -v
```

输出类似：

```
gitee   https://gitee.com/dalihaif/blog.git (fetch)
gitee   https://gitee.com/dalihaif/blog.git (push)
github  https://github.com/dalihaif/blog.git (fetch)
github  https://github.com/dalihaif/blog.git (push)
```

这样你就有了双保险——GitHub 连不上就用 Gitee，Gitee 有问题就用 GitHub。

### 五个平台对比

| 特性 | GitHub | Gitee | GitLab | Coding | Gitea |
|------|--------|-------|--------|--------|-------|
| 国内访问速度 | 慢/不稳定 | 快 | 中等 | 快 | 自建极快 |
| 中文界面 | 有 | 有 | 有 | 有 | 有 |
| 免费私有仓库 | 有 | 有（限量） | 有 | 有 | 不限 |
| 适合谁 | 个人/开源项目 | 国内个人/小团队 | 中大型团队 | 国内团队 | 有IT的公司 |
| 自建 | 不支持 | 不支持 | 支持 | 不支持 | 支持 |
| 项目管理 | Issues | Issues+任务 | Issues+看板 | 完整 | Issues |

---

## 第四部分：Git 进阶操作——办公文员也能学会

以下是一些你日常真会用到的进阶操作，用大白话讲清楚。

### 1. 分支管理——安全地"试错"

分支（Branch）就像平行宇宙。你在主宇宙（master分支）上正常干活，需要试验一个新方案时，开一条新分支去试，试好了合并回来，试坏了直接扔掉——主线完全不受影响。

```bash
# 查看所有分支
git branch

# 创建并切换到新分支
git checkout -b 新方案试验

# 在新分支上干活、提交
git add .
git commit -m "试验了新方案"

# 试好了，切回主线，合并
git checkout master
git merge 新方案试验

# 试坏了，切回主线，删掉分支
git checkout master
git branch -D 新方案试验
```

**办公场景：** 领导让你出一版"精简版汇报材料"，你不确定最终用不用。开一条分支改，改完让领导看，采纳了就合并，不采纳就删掉分支，主线材料一字不动。

### 2. 冲突处理——两人改了同一个地方

两个人改了同一个文件的同一个位置，Git 不知道听谁的，就会报"冲突"（Conflict）。

冲突不可怕，Git 会在文件里标出冲突的位置：

```
<<<<<<< HEAD
这是你改的内容
=======
这是同事改的内容
>>>>>>> origin/master
```

你只需要：
1. 打开文件，找到 `<<<<<<<` 和 `>>>>>>>` 之间的内容
2. 判断保留哪个（或两个都保留、或重新写）
3. 删掉 `<<<<<<<`、`=======`、`>>>>>>>` 这三行标记
4. 保存文件，然后正常 `git add` 和 `git commit`

**记住：冲突永远是人来解决的，Git 只是帮你标出来。**

### 3. 查看历史——谁在什么时候改了什么

```bash
# 看提交历史（按时间倒序）
git log

# 看简洁版（一行一个提交）
git log --oneline

# 看某个文件的历史
git log -- 汇报材料.doc

# 看某次提交具体改了什么
git show 提交编号

# 看某个文件每一行是谁最后改的（"谁写的这锅代码"）
git blame 文件名
```

`git blame` 特别好用——比如你发现某个文件里有一段莫名其妙的内容，blame 一下就知道是谁在什么时候加的，方便你去找他问清楚。

### 4. 暂存修改——干了一半被叫走

正在改东西，领导突然叫你去处理另一件事。当前改了一半，又不想提交（还没做完），怎么办？

```bash
# 把当前修改暂存起来（像放进冰箱）
git stash

# 去干别的事……干完了，取回来继续
git stash pop
```

这个操作在上一篇里提过，但我要强调：**这是你日常用得最频繁的进阶操作之一**。每次被打断、每次要临时切分支、每次想试试别的方法又不想丢了当前的进度，`stash` 都是你的好朋友。

### 5. 撤销操作——改错了怎么救

根据你"错到哪一步了"，救法不同：

**改了文件，还没 `add`：**

```bash
git checkout -- 文件名    # 恢复到上次提交的状态
```

**已经 `add` 了，还没 `commit`：**

```bash
git reset HEAD 文件名     # 从暂存区移出来
git checkout -- 文件名    # 再恢复文件内容
```

**已经 `commit` 了，还没 `push`：**

```bash
git reset --soft HEAD~1   # 撤回提交，修改还在
```

**已经 `push` 了：**

```bash
git revert 提交编号        # 生成一个"反向提交"来抵消
```

`revert` 和 `reset` 的区别：`reset` 是假装那次提交没发生过（改历史），`revert` 是再加一笔新记录来说"那次提交的不算"（不改历史）。**已经推到远程的，用 `revert`，别用 `reset`。**

### 6. .gitignore——告诉Git哪些文件别管

有些文件你不想让 Git 跟踪，比如临时文件、系统生成的缓存文件、包含密码的配置文件等。在项目根目录创建一个 `.gitignore` 文件，把不想跟踪的文件或目录写进去：

```
# 忽略所有 .tmp 文件
*.tmp

# 忽略整个 build 文件夹
build/

# 忽略 .DS_Store（Mac 系统的垃圾文件）
.DS_Store

# 忽略 Thumbs.db（Windows 系统的缩略图缓存）
Thumbs.db
```

每加一条规则，Git 就不会再跟踪这些文件了。**建议每个项目都建一个 `.gitignore`，这是好习惯。**

### 7. 标签（Tag）——给重要节点打标记

有些提交特别重要，你想给它"挂个牌子"方便以后找，比如"定稿版""v1.0""领导审批通过"：

```bash
# 给当前提交打标签
git tag -a v1.0 -m "第一版定稿"

# 查看所有标签
git tag

# 把标签也推送到远程
git push origin --tags
```

**办公场景：** 年度总结材料终于定稿了，打个 `tag` 标记"2025年度总结-定稿"。以后领导说"还是用回定稿那版"，你一条命令就能找回来，不用在一堆提交记录里大海捞针。

---

## 第五部分：常见问题急救手册

### Q1：`git push` 被拒绝，提示"rejected"

**原因：** 远程仓库有别人推的新内容，你本地是旧的。

**解法：**

```bash
git pull --rebase origin master
git push
```

如果拉取时出现冲突，按上面"冲突处理"的方法解决，然后 `git rebase --continue`，再 push。

### Q2：`git push` 超时，连不上 GitHub

**原因：** 网络问题。

**解法一：** 如果你有 Gitee 等备份平台，直接推那边：

```bash
git push gitee master
```

**解法二：** 配置 Git 使用代理（如果你有科学上网工具）：

```bash
git config --global http.proxy http://127.0.0.1:7890
git config --global https.proxy http://127.0.0.1:7890
```

用完后取消代理：

```bash
git config --global --unset http.proxy
git config --global --unset https.proxy
```

**解法三：** 增大超时时间：

```bash
git config --global http.lowSpeedLimit 0
git config --global http.lowSpeedTime 999999
```

### Q3：不小心把密码或敏感信息提交了

如果还没 push：

```bash
git reset --soft HEAD~1    # 撤回提交
# 然后修改文件，删掉敏感信息
# 重新提交
```

如果已经 push 了——这个比较麻烦。提交历史里的密码即使你删掉了，别人翻历史还是能看到。建议：
1. **立刻修改密码/密钥**（这是最重要的）
2. 通知相关人员
3. 用 `git revert` 撤回那次提交

**教训：敏感信息永远不要写进代码里，用 `.gitignore` 忽略包含敏感信息的文件。**

### Q4：想把仓库从 GitHub 迁移到 Gitee

```bash
# 1. 在 Gitee 上创建一个空的同名仓库

# 2. 在本地，克隆 GitHub 仓库（如果已有就跳过）
git clone --mirror https://github.com/你的用户名/仓库名.git

# 3. 进入仓库目录
cd 仓库名.git

# 4. 推送到 Gitee
git push --mirror https://gitee.com/你的用户名/仓库名.git
```

`--mirror` 会把所有分支、标签、历史记录完整迁移过去。

### Q5：想看看两个版本之间差了什么

```bash
# 比较当前修改和上次提交
git diff

# 比较两个提交之间的差异
git diff 提交编号1 提交编号2

# 比较当前和远程的差异
git diff HEAD origin/master
```

---

## 第六部分：养成好习惯——Git 使用的几条铁律

用了这么多年 Git，总结几条我认为最重要的习惯：

**1. 勤提交，小步走。** 不要攒了一天的修改才提交一次。每完成一个小功能、小改动就提交一次。提交越细，出了问题越容易定位和回退。就像游戏存档——你不会等打到最终Boss才存第一次档吧？

**2. 提交说明写人话。** `git commit -m "更新"` 这种说明跟没写一样。写清楚你改了什么、为什么改。三个月后你翻历史，会感谢现在的自己。

**3. 提交前先 `git status`。** 养成习惯：每次提交前看一眼状态，确认要提交的文件对不对，有没有不小心把临时文件、垃圾文件加进去。

**4. 每天上班第一件事 `git pull`。** 不要闷头干了一上午，下午发现同事早就改了同一个文件，合并时冲突一大堆。

**5. 重要节点打 Tag。** 定稿了、上线了、领导审批了——这些关键时刻打个标签，以后找起来一目了然。

**6. 永远不要在 master 上直接改。** 养成开分支的习惯。master 分支永远是"稳定版"，所有修改在新分支上做，做好了再合并回来。哪怕只有你一个人用，这个习惯也能帮你避免很多低级错误。

---

## 写在最后

很多人觉得 Git 是程序员才需要学的东西。其实不是。**Git 解决的核心问题是"文件版本管理和多人协作"——这个问题，办公文员比程序员更头疼。**

"最终版""最终版2""打死不改版"——每个做过材料的人都经历过这种痛苦。Git 就是来终结这种痛苦的。

而 GitHub（或者 Gitee 这类平台）解决的是"把 Git 的能力搬到云端"——让你在任何地方都能访问、任何时间都能回退、任何人都能协作。

不需要你是技术出身。会用 Word，就会用 Git。区别只是 Word 用鼠标点，Git 用键盘敲——但敲的也就那几行命令，背都背得下来。

**拉 → 干 → 存 → 推。** 从今天开始，让你的文件管理告别混乱。

---

> *老墨，大理大学第一附属医院档案室，2026年6月*

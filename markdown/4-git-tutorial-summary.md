廖学峰「Git教程」github,gitbook version, [click me](http://lvwzhen.github.io/Git-Tutorial/)

## 创建版本库

- 初始化一个Git仓库，使用git init命令。
- 添加文件到Git仓库，分两步：
	- 第一步，使用命令`git add` ，注意，可反复多次使用，添加多个文件；
	- 第二步，使用命令`git commit`，完成。

## 状态

- 要随时掌握工作区的状态，使用`git status`命令(`git status -s`)。
- 如果`git status`告诉你有文件被修改过，用`git diff`可以查看修改内容(`git diff --cached, git diff HEAD`)。

## 版本回退

- `HEAD`指向的版本就是当前版本，因此，Git允许我们在版本的历史之间穿梭，使用命令`git reset --hard commit_id`。
- 穿梭前，用`git log`可以查看提交历史，以便确定要回退到哪个版本。
- 要重返未来，用`git reflog`查看命令历史，以便确定要回到未来的哪个版本。

## 工作区和缓存区

- 用`git add`把文件添加进去，实际上就是把文件修改添加到暂存区；
- 用`git commit`提交更改，实际上就是把暂存区的所有内容提交到当前分支。

## 撤销修改

- 场景1：当你改乱了工作区某个文件的内容，想直接丢弃工作区的修改时，用命令`git checkout -- file`。
- 场景2：当你不但改乱了工作区某个文件的内容，还添加到了暂存区时，想丢弃修改，分两步，第一步用命令`git reset HEAD file`，就回到了场景1，第二步按场景1操作。
- 场景3：已经提交了不合适的修改到版本库时，想要撤销本次提交，参考版本回退一节，不过前提是没有推送到远程库。

## 远程仓库

- 要关联一个远程库，使用命令`git remote add origin git@server-name:path/repo-name.git`;
- 关联后，使用命令`git push -u origin master`第一次推送master分支的所有内容；
- 此后，每次本地提交后，只要有必要，就可以使用命令`git push origin master`推送最新修改；

## 分支创建与合并

- 查看分支：`git branch`
- 创建分支：`git branch name`
- 切换分支：`git checkout name`
- 创建+切换分支：`git checkout -b name`
- 合并某分支到当前分支：`git merge name`
- 删除分支：`git branch -d name`

## 分支建议

- 无法自动合并分支时，就必须首先解决冲突。解决冲突后，再提交，合并完成。
- 用git log --graph命令可以看到分支合并图。
- 合并分支时，加上`--no-ff`参数就可以用普通模式合并，合并后的历史有分支，能看出来曾经做过合并，而fast forward合并就看不出来曾经做过合并。
- 当手头工作没有完成时，先把工作现场`git stash`一下，然后去修复bug，修复后，再`git stash pop`(`git stash list` 查看)，回到工作现场。
- 开发一个新feature，最好新建一个分支;如果要丢弃一个没有被合并过的分支，可以通过git branch -D name强行删除。

## 多人合作

- 查看远程库信息，使用`hgit remote -v`;
- 本地新建的分支如果不推送到远程，对其他人就是不可见的；
- 从本地推送分支，使用`git push origin branch-name`，如果推送失败，先用`git pull`(个人偏向与`git fetch, git merge`)抓取远程的新提交；
- 在本地创建和远程分支对应的分支，使用`git checkout -b branch-name origin/branch-name`，本地和远程分支的名称最好一致；
- 建立本地分支和远程分支的关联，使用`git branch --set-upstream branch-name origin/branch-name`；
- 从远程抓取分支，使用`git pull`，如果有冲突，要先处理冲突。

## 标签

- `git tag name`用于新建一个标签，默认为`HEAD1，也可以指定一个commit id；
- `-a tagname -m "blablabla...`可以指定标签信息；
- `-s tagname -m "blablabla...`以用PGP签名标签；
- `git tag`可以查看所有标签；
- `git tag`t push origin tagname可以推送一个本地标签；
- `git push origin --tags`可以推送全部未推送过的本地标签；
- `git tag -d tagname-`可以删除一个本地标签；
- `git push origin :refs/tags/tagname`可以删除一个远程标签。

## 搭建Git服务器

1. 安装git

	`sudo yum install git` or `sudo apt-get install gito`

2. 创建一个git用户，用来运行git服务

	`sudo adduser git`
	`passwd git`

3. 创建证书登录

收集所有需要登录的用户的公钥，就是他们自己的id_rsa.pub文件，
把所有公钥导入到/home/git/.ssh/authorized_keys文件里，一行一个。

4. 初始化Git仓库

选定一个目录作为git仓库，假定是/srv/sample.git，在/srv目录下输入：

	`sudo git init --bare sample.git`

git就会创建一个裸仓库，裸仓库没有工作区，因为服务器上的Git仓库纯粹是为了共享，
所以不让用户直接登录到服务器上去改工作区，并且服务器上的Git仓库通常都以.git结尾。
然后，把owner改为git：

	`sudo chown -R git:git sample.git`

5. 禁用shell登录
	- `sudo vipw`
	- `git:x:1001:1001:,,,:/home/git:/bin/bash` --> `git:x:1001:1001:,,,:/home/git:/usr/bin/git-shell` 

6. 克隆远程仓库

	`$ git clone git@server:/srv/sample.git`



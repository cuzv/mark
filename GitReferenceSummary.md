```
git clone https://github.com/atcuan/test.git
git branch
git checkout branch origin/feature
```


## 分支合并冲突解决

- 注意切换分支前先commit(提交快照后，另外分支不会出现新提交的文件，防止错误发生)
- 处理冲突前不能切换分支
- 产生冲突文件的文件不能删除，按照提示修改(git diff)
- 如果不小心删除了，再次merge不会合并过来的，只能拷贝一份过来
- 解决冲突了后记得git add <filename>


##############################

```
git fetch origin  
get merge origin/feature  

git push origin feature  

git checkout master  
git merge feature  
git push origin master  
```

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

远程的都要加origin.使用这种形式访问origin/feature   本地直接写feature(branch)  
早上到公司

`git checkout feature`    
`git fetch origin`  
`git diff feature origin/feature` //看差异 
`git merge origin/feature`  

// coding
走之前  
`git push origin feature`     

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

`git add // 缓存`  
`git commit -m “” // 快照`  

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

## 基本快照  

####git add 添加文件到缓存    
####git status 查看你的文件在工作目录与缓存的状态  
####git diff 尚未缓存的改动  

- *如果没有其他参数，git diff 会以规范化的 diff 格式（一个补丁）显示自从你上次提交快照之后尚未缓存的所有更改*  

- *git status显示你上次提交更新至后所更改或者写入缓存的改动，而 git diff 一行一行地显示这些改动具体是啥。* 
- *通常执行完 git status 之后接着跑一下 git diff 是个好习惯。*

####git diff --cached 查看已缓存的改动  
####git diff HEAD 查看已缓存的与未缓存的所有改动  
####git diff --stat 显示摘要而非整个 diff  
####git commit 记录缓存内容的快照  
####git commit -a 自动将在提交前将已记录、修改的文件放入缓存区
####git reset HEAD 取消缓存已缓存的内容

- `*git reset HEAD -- file —— 它用来告诉 Git 这时你已经不再列选项，剩下的是文件路径了*`    
- `*执行 git reset HEAD 以取消之前 git add 添加，但不希望包含在下一提交快照中的缓存* `  
   
####git rm 将文件从缓存区移除

- *`git mv git rm --cached orig; mv orig new; git add new*`     
 
####git  reset --hard 撤销commit

- `*git reset --hard <commit>* commit id 可以通过git log获取 `   
- `*git reset --hard HEAD~ *`
- `*git push origin HEAD --force*`      
- `*如果错误的合并之后又有了新的提交，可以在完成前述正确的合并之后，通过 git rebase --onto <错误的合并提交> <正确的合并提交> <新提交所在分支> 来在正确的合并提交上重建新的提交。git rebase --onto 命令所重建的提交序列最好是线性的，否则非线性的提交会变成线性的。*`  
   


**示例代码：**
```
touch file   
git status -s    

git add .    
git status -s     

// git reset HEAD  

vim file    

git status -s   
git status

git diff 
git diff --cached
git diff HEAD  

git config --global user.name "atcuan"
git config --global user.email "atcuan@gmail.com"

git add file
git commit -m "commit file"
git status
git status -s


vim file
git status -s
git commit -m "change file"
git commit -am "change file"


vim hello
vim bbbb
git add .
git commit -m ""
vim bbbb
git status -s

git add .
git status -s

git reset HEAD --bbbb
git status -s  
```

## 基本快照

####git branch 列出、创建与管理工作上下文
####git checkout 切换到新的分支上下文
####git merge 将分支合并到你的当前分支
####git log 显示一个分支中提交的更改记录

- `*git log --oneline 查看历史记录的紧凑简洁的版本*`   
- `*git log --oneline --graph 开启了拓扑图选项*`   
- `*git log --oneline --graph <branch> 查看具体分支*`  
- `*git log --oneline feature ^master 查看feature分支但不在主分支中的提交*` 
- `git log --oneline --decorate --graph 查看标签`  

####git tag 给历史记录中的某个重要的一点打上标签

####

**示例代码：**

```
git branch
git branch feature // 创建新分支

echo 'test content' > test.txt
echo 'more content' > more.txt
git add *.txt
git commit -m 'added two files'
ls

git checkout feature
ls // 发现新加的刚提交的更新文件这个分支里面没有

git checkout -b newb //创建新分支并切换
git branch
ls
git rm test.txt more.txt
git commit -am "remove txt files"
git checkout master
ls


git branch -d newb // 删除分支
git branch

/*
// 远程分支
git branch -r 
git branch -a

git push origin --delete feature
// or git push origin :feature
git push origin --delete tag <tagname>
*/

git log
git log --oneline
git log --oneline --graph master
*git log --oneline feature ^master

git log -a V1.0
it log --oneline --decorate --graph
```






























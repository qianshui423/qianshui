[Git子模块](https://git-scm.com/book/zh/v2/Git-%E5%B7%A5%E5%85%B7-%E5%AD%90%E6%A8%A1%E5%9D%97)

# 子模块解决的问题

存在两个独立的项目，同时需要在一个项目中使用另一个  
子模块允许将一个Git仓库作为另一个Git仓库的子目录，可以将另一个仓库克隆到自己的项目中，同时还保持提交的独立

# 开始使用子模块

以OpenSpace为例，添加一个新的子模块，默认会将OpenSpace放在工程根目录,如果想放到其他位置，可以在命令结尾添加一个不同的路径

```
$ git submodule add https://github.com/qianshui423/OpenSpace.git
```

查看一下工作区状态

```
$ git status
On branch master
Your branch is up-to-date with 'origin/master'.
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

        new file:   .gitmodules
        new file:   OpenSpace
```

查看自动生成的.gitmodules

```
$ cat .gitmodules
[submodule "OpenSpace"]
        path = OpenSpace
        url = https://github.com/qianshui423/OpenSpace.git

```
注意：在./.git/config中同样记录了submodule  
可以执行git config submodule.OpenSpace.url <私有URL> 来覆盖submodule地址，同样可以覆盖path

查看主工程改动，在主工程根目录之行

```
$ git diff --cached OpenSpace
diff --git a/OpenSpace b/OpenSpace
new file mode 160000
index 0000000..5d6818c
--- /dev/null
+++ b/OpenSpace
@@ -0,0 +1 @@
+Subproject commit 5d6818cd28bd8b5d389f107c492b34a771df7323
```

注意：Git不会跟踪它的内容，而是把它看作该仓库中的一个特殊提交

查看更漂亮的差异输出

```
$ git diff --cached --submodule
diff --git a/.gitmodules b/.gitmodules
new file mode 100644
index 0000000..52b0d53
--- /dev/null
+++ b/.gitmodules
@@ -0,0 +1,3 @@
+[submodule "OpenSpace"]
+       path = OpenSpace
+       url = https://github.com/qianshui423/OpenSpace.git
Submodule OpenSpace 0000000...5d6818c (new submodule)
```

提交

```
$ git commit -am 'added OpenSpace module'
[master e294040] added OpenSpace module
 2 files changed, 4 insertions(+)
 create mode 100644 .gitmodules
 create mode 160000 OpenSpace
```

注意：160000模式是Git中的一种特殊模式，将一次提交记作一个项目记录的，而非记录成一个子目录或者一个文件

# 克隆含有子模块的项目

```
$ git clone https://github.com/qianshui423/GreatInRxJava.git
Cloning into 'GreatInRxJava'...
remote: Counting objects: 226, done.
remote: Compressing objects: 100% (136/136), done.
remote: Total 226 (delta 34), reused 221 (delta 31), pack-reused 0
Receiving objects: 100% (226/226), 124.43 KiB | 88.00 KiB/s, done.
Resolving deltas: 100% (34/34), done.
$ cd GreatInRxJava/
$ ls -la
total 72
drwxr-xr-x  16 liuxuehao  staff   544  4 28 18:26 .
drwxr-xr-x   5 liuxuehao  staff   170  4 28 18:26 ..
drwxr-xr-x  13 liuxuehao  staff   442  4 28 18:26 .git
-rw-r--r--   1 liuxuehao  staff   452  4 28 18:26 .gitignore
-rw-r--r--   1 liuxuehao  staff    94  4 28 18:26 .gitmodules
drwxr-xr-x   2 liuxuehao  staff    68  4 28 18:26 OpenSpace
-rw-r--r--   1 liuxuehao  staff    29  4 28 18:26 README.md
drwxr-xr-x   6 liuxuehao  staff   204  4 28 18:26 app
drwxr-xr-x   6 liuxuehao  staff   204  4 28 18:26 baselib
-rw-r--r--   1 liuxuehao  staff   571  4 28 18:26 build.gradle
drwxr-xr-x   3 liuxuehao  staff   102  4 28 18:26 gradle
-rw-r--r--   1 liuxuehao  staff   730  4 28 18:26 gradle.properties
-rwxr-xr-x   1 liuxuehao  staff  4971  4 28 18:26 gradlew
-rw-r--r--   1 liuxuehao  staff  2404  4 28 18:26 gradlew.bat
drwxr-xr-x   6 liuxuehao  staff   204  4 28 18:26 rxbus
-rw-r--r--   1 liuxuehao  staff    37  4 28 18:26 settings.gradle
$ cd OpenSpace/
$ ls
$
```

注意：OpenSpace目录是空的，执行 git submodule init 用来初始化本地配置文件，然后执行 git submodule update 从该项目中抓取所有数据并检出父项目中列出的合适的提交

```
$ git submodule init
Submodule 'OpenSpace' (https://github.com/qianshui423/OpenSpace.git) registered for path 'OpenSpace/OpenSpace'
$ git submodule update
Cloning into '/Users/liuxuehao/Documents/dasouche/GreatInWhere/test/GreatInRxJava/OpenSpace'...
Submodule path './': checked out '5d6818cd28bd8b5d389f107c492b34a771df7323'
```

注意：现在OpenSpace子目录是处在和之前提交时相同的状态

更简单的方式克隆含有子模块的项目

```
$ git clone --recursive https://github.com/qianshui423/GreatInRxJava.git
```

在子模块上工作，并可以同时与在主项目和子模块项目上的队员协作开发

## 拉取上游修改

首先在OpenSpace上做一次提交并push，然后在GreatRxJava的OpenSpace目录下执行fetch和merge命令

```
$ git fetch
remote: Counting objects: 3, done.
remote: Total 3 (delta 1), reused 1 (delta 1), pack-reused 2
Unpacking objects: 100% (3/3), done.
From https://github.com/qianshui423/OpenSpace
   5d6818c..3390a66  master     -> origin/master
$ git merge origin/master
Updating 5d6818c..3390a66
Fast-forward
 testSubmoudles | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 testSubmoudles
```

返回主工程执行

```
$ git diff --submodule
Submodule OpenSpace 5d6818c..3390a66:
  > test submoudles
```

可以看到子模块被更新的同时获得一个包含新添加提交列表，可以将diff.submodule设置为‘log’来作为默认行为

```
$ git config --global diff.submodule log
$ git diff
Submodule OpenSpace 5d6818c..3390a66:
  > test submoudles
```

如果在此时提交，会将子模块锁定为其他人更新时的新代码  

如果不想在子目录中手动抓取与合并，还可以git submodule update --remote OpenSpace，Git会进入子模块然后抓取并更新

```
$ git submodule update --remote
remote: Counting objects: 3, done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
Unpacking objects: 100% (3/3), done.
From https://github.com/qianshui423/OpenSpace
   3390a66..81ad63c  master     -> origin/master
Submodule path 'OpenSpace': checked out '81ad63c601faf3a7247f09e51bebdffbd1f9622b'
```

注意：命令结尾可以添加子模块名，不添加默认抓取并更新全部子模块  

如果需要设置OpenSpace子模块跟踪仓库的其他分支，如‘stable’分支，有两种方式，一种是在.gitmodules文件中设置（其他人也可以跟踪），另一种只在本地的.git/config文件中设置  

在.gitmodules文件中设置修改

```
$ git config -f .gitmodules submodule.OpenSpace.branch stable
$ git submodule update --remote
From https://github.com/qianshui423/OpenSpace
 * [new branch]      stable     -> origin/stable
```

如果不用-f .gitmodules选项，那么这个修改只会本地做修改。但是在仓库中保留跟踪信息意义更大，因为其他人也可以同步修改  

执行git status，Git会显示子模块有‘新提交’

```
$ git status
On branch master
Your branch is up-to-date with 'origin/master'.
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

	modified:   .gitmodules
	modified:   OpenSpace (new commits)

no changes added to commit (use "git add" and/or "git commit -a")
```

如果设置了配置选项status.submodulesummary，Git会显示子模块的更改摘要

```
$ git config status.submodulesummary 1
$ git status
On branch master
Your branch is up-to-date with 'origin/master'.
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

	modified:   .gitmodules
	modified:   OpenSpace (new commits)

Submodules changed but not updated:

* OpenSpace 5d6818c...81ad63c (2):
  > test submodules 1

no changes added to commit (use "git add" and/or "git commit -a")
```

此时运行git diff，可以看到刚刚修改.gitmodules文件，同时还会携带几个已拉取的提交，需要提交到当前工程的子模块项目中

```
$ git diff
diff --git a/.gitmodules b/.gitmodules
index 52b0d53..e360107 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -1,3 +1,4 @@
 [submodule "OpenSpace"]
        path = OpenSpace
        url = https://github.com/qianshui423/OpenSpace.git
+       branch = stable
Submodule OpenSpace 5d6818c..81ad63c:
  > test submodules 1
  > test submoudles
```

提交之后，执行git log -p可以查看这个信息

```
$ git log -p --submodule
commit fbbaf01700b6e6d7f1510e570726a0942d64571e
Author: liuxuehao <liuxuehao@souche.com>
Date:   Fri Apr 28 19:19:39 2017 +0800

    modified submodules

diff --git a/.gitmodules b/.gitmodules
index 52b0d53..e360107 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -1,3 +1,4 @@
 [submodule "OpenSpace"]
        path = OpenSpace
        url = https://github.com/qianshui423/OpenSpace.git
+       branch = stable
Submodule OpenSpace 5d6818c..81ad63c:
  > test submodules 1
  > test submoudles
```

当运行git submodule update --remote时，Git会默认尝试更新所有子模块，如果更新某个子模块的话，则传递该子模块的名字

## 在子模块上工作

截止目前操作，OpenSpace子模块处在‘游离的HEAD’状态，还无法跟踪改动  

为了将子模块设置得更容易修改，需要做两件事：第一，进入每个子模块并检出其相应的工作分支，第二，执行git submodule update --remote来从上游拉取新工作，可以手动指定merge参数，此时可以看到一行插入改变（要先在OpenSpace分支提交push一个改变）

```
$ git checkout stable
Branch stable set up to track remote branch stable from origin.
Switched to a new branch 'stable'
$ git status
On branch stable
Your branch is up-to-date with 'origin/stable'.
nothing to commit, working tree clean
$ cd ..
$ git submodule update --remote --merge
remote: Counting objects: 3, done.
remote: Compressing objects: 100% (3/3), done.
remote: Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
Unpacking objects: 100% (3/3), done.
From https://github.com/qianshui423/OpenSpace
   81ad63c..af0bba6  stable     -> origin/stable
Updating 81ad63c..af0bba6
Fast-forward
 testSubmoudles | 2 ++
 1 file changed, 2 insertions(+)
Submodule path 'OpenSpace': merged in 'af0bba615450c56ef057e4902c39e2fc8dd7bd12'
```

如果在OpenSpace子模块做一些本地改动，同时其他人推送另外一个修改到上游，会出现的状况

```
$ cd OpenSpace/
$ vim testSubmoudles 
$ git commit -am 'test submodules 4'
[stable 9f1f426] test submodules 4
 1 file changed, 2 insertions(+)
```

如果此时更新子模块，会看到在本地做更改时，上游也有一个改动，需要将它并入本地

```
$ git submodule update --remote --rebase
remote: Counting objects: 3, done.
remote: Compressing objects: 100% (3/3), done.
remote: Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
Unpacking objects: 100% (3/3), done.
From https://github.com/qianshui423/OpenSpace
   af0bba6..7219826  stable     -> origin/stable
First, rewinding head to replay your work on top of it...
Applying: test submodules 4
Using index info to reconstruct a base tree...
M	testSubmoudles
Falling back to patching base and 3-way merge...
Auto-merging testSubmoudles
CONFLICT (content): Merge conflict in testSubmoudles
error: Failed to merge in the changes.
Patch failed at 0001 test submodules 4
The copy of the patch that failed is found in: /Users/liuxuehao/Documents/dasouche/GreatInWhere/test/GreatInRxJava/.git/modules/OpenSpace/rebase-apply/patch

When you have resolved this problem, run "git rebase --continue".
If you prefer to skip this patch, run "git rebase --skip" instead.
To check out the original branch and stop rebasing, run "git rebase --abort".

Unable to rebase '72198269caacafe8d7e43b78a18a880209fb50c4' in submodule path 'OpenSpace'
```

由于同时修改了同一个文件，产生了冲突，进入子模块解决冲突，执行git add [file]，标记冲突已解决，然后执行git rebase --continue即可

如果在执行git submodule update --remote --rebase时忘记--rebase或--merge，Git会将子模块更新为服务器上的状态，并且会将项目重置为一个游离的HEAD状态  

即时发生了也可以解决，只需进入到子模块中再次检出你的分支，然后手动合并或变基origin/stable（或者任何一个你需要的远程分支）即可

如果没有提交子模块改动，执行子模块更新不会出问题，此时Git只会抓取更改，而不会覆盖子模块目录中未保存的工作

## 发布子模块改动

在主工程目录执行git diff发现子模块的改动还没有推送

```
$ git diff
Submodule OpenSpace 81ad63c..7cc9c32:
  > test submodules 4
  > test submodules 3
  > test submodules 2
```

注意：主项目提交并推送并不会推送子模块的改动，其他尝试检出我们修改的队员会遇到麻烦，因为他们无法得到依赖的子模块改动。子模块改动此时只存在我们的本地拷贝中

为了确保Git在推送到主项目前检查所有子模块是否已推送。git push命令接受可以设置为‘check’或‘on-demand’的--recurse-submodules参数。如果任何提交的子模块改动没有推送，会直接使push操作失败

```
git push --recurse-submodules=check
```

官网说会出现如下提示，而我并没有出现这个提示信息（git版本－2.12.2）

```
The following submodule paths contain changes that can
not be found on any remote:
  DbConnector

Please try

	git push --recurse-submodules=on-demand

or cd to the path and use

	git push

to push them to a remote.
```

## 合并子模块改动

如果你和队员同时改动了一个子模块的引用，可能会遇到一些问题。也就是说，如果子模块的历史已经分叉并且在父项目中分别提交到了分叉的分支上，那么你需要单独做一些工作来修复这种情况  

如果一个提交是另一个的直接祖先（一个快进式合并），那么Git会简单地选择之后的提交来合并

另一个场景，假如A和B协作开发
A修改子模块后，在提交改变并把主工程也提交改变。B在子模块内部pull并解决冲突后，子模块内部push可以成功，主工程执行git push会产生如下错误信息，然后git pull后的情况如下，可以解决，然后push到远程成功

```
$ git push
To https://github.com/qianshui423/GreatInRxJava.git
 ! [rejected]        master -> master (fetch first)
error: failed to push some refs to 'https://github.com/qianshui423/GreatInRxJava.git'
hint: Updates were rejected because the remote contains work that you do
hint: not have locally. This is usually caused by another repository pushing
hint: to the same ref. You may want to first integrate the remote changes
hint: (e.g., 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.
$ git pull
remote: Counting objects: 2, done.
remote: Compressing objects: 100% (1/1), done.
remote: Total 2 (delta 1), reused 2 (delta 1), pack-reused 0
Unpacking objects: 100% (2/2), done.
From https://github.com/qianshui423/GreatInRxJava
   12e1d82..c90aca0  master     -> origin/master
Merge made by the 'recursive' strategy.
```

而后，A也会存在冲突，在执行pull后，信息如下

```
$ git pull
remote: Counting objects: 3, done.
remote: Compressing objects: 100% (1/1), done.
remote: Total 3 (delta 2), reused 3 (delta 2), pack-reused 0
Unpacking objects: 100% (3/3), done.
From https://github.com/qianshui423/GreatInRxJava
   c90aca0..b9d83ae  master     -> origin/master
Fetching submodule OpenSpace
From https://github.com/qianshui423/OpenSpace
   b3ff504..f3ea347  stable     -> origin/stable
Updating c90aca0..b9d83ae
Fast-forward
 OpenSpace | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
```

这时候，A需要进入子模块重新pull拉取后，即可正常开发  

注意：理解主工程的特殊提交，再结合Git提示，就可以正确解决冲突问题  

关于子模块引用改变的问题后续补充

## 子模块技巧－可以理解为全局操作

未完待续

## 分支切换引起的问题

未完待续
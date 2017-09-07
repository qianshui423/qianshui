1. 删除远程分支
> git push origin  :branch_name 或 git push --delete origin branch_name

2. 新建远程分支
> git push origin local_branch:remote_branch

3. 新建并切换本地新分支
> git checkout -b new_branch

4. 删除本地分支
> git branch -d local_branch(-D强制删除本地分支)

5. 重新确定提交到新分支
> git push --set-upstream origin remote_branch

6. 与远程分支建立关联
> git branch --set-upstream-to=origin/remote_branch local_branch

7. 忽略工作区所有修改
> git checkout -f

8. 强制推向远程分支
> git push -f origin master

9. 删除远程标签
> git push origin --delete tag <tagname>

10. 删除本地标签
> git tag -d <tagname>

11. 删除掉没有与远程分支对应的本地分支
> git fetch -p

12. 修改本地分支名称
> git branch -m devel develop
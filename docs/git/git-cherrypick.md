提取一个commit

```
git cherry-pick [commitID]
```

提取一个commit到另一个commit之间的所有commit，不包括start-commitID，包括end-commitID

```
git cherry-pick [start-commitID]..[end-commitID]
```

提取一个commit到另一个commit之间的所有commit，包括start-commitID，包括end-commitID

```
git cherry-pick start-commitID]^..[end-commitID]
```
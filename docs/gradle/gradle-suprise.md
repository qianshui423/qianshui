* dependsOn可以依赖其他任务，格式如下：

```
task test(dependsOn: [compile, compileTest]) {
	doLast {
		println 'running unit test'
	}
}
```

注意：每个被依赖任务只被执行一次

* gradle taskA -x taskB 可以排除掉taskB任务的依赖树

* --continue 可以忽略错误继续编译

* 可以缩写任务名，只写前边几个字母，如果是驼峰式的任务名，可以简写首字母，注意要保证简写的唯一性,如下：

```
dist -> di

compileTest -> cT
```

* 执行子工程的非build.gradle的build文件

```
gradle -q -b subdir/myproject.gradle taskA
```

如果子工程中的build文件名为build.gradle，则可使用如下：

```
gradle -q -p subdir taskA
```

* 强制任务重新执行

```
gradle --rerun-tasks taskA
```
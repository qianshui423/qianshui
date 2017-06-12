[Gradle官网](https://gradle.org/)

1. 查看依赖树
> ./gradlew app:dependencies

2. 上传arr包
> ./gradlew uploadArchives

3. 防止上传arr包出现问题（切换分支可能引起）
> ./gradlew clean uploadArchives

4. 查看模块依赖
> ./gradlew -q dependencies &#60;module-name&#62;:dependencies --configuration compile

5. 查看可用任务
> gradle tasks

6. 查看关于wrapper任务的细节(也可以是其他任务)
> gradle help --task wrapper

7. 生成一个wrapper
> gradle wrapper --gradle-version 2.0

8. 查看工程属性
> ./gradlew properties

9. 查看所有任务
> ./gradlew tasks --all

10. 执行指定任务
> ./gradlew taskName

11. 执行压缩任务
> ./gradlew zip

12. 执行清除任务
> ./gradlew clean

13. 列出所有项目,并展示每个项目的描述信息
> gradle -q projects

14. 获取任务的信息，不包括未分组的任务
> gradle -q tasks

15. 获取更多的任务信息
> gradle -q tasks --all

16. 获取任务的帮助
> gradle -q help --task taskA

17. 查看依赖信息
> gradle -q dependencies api:dependencies

18. 过滤依赖结果信息
> gradle -q api:dependencies --configuration testCompile

19. 查看指定依赖信息
> gradle -q api:dependencyInsight --dependency groovy --configuration compile

20. 查看项目属性信息
> gradle -q api:properties

21. 记录一些有用的时间信息，并输出到/build.reports/profile目录
> gradle --profile

22. 查看clean命令在compile
> gradle -m clean compile

23. 获取守护进程的列表和状态
> gradle --status

24. 在用户目录下的.gradle/gradle.properties中添加代码禁用守护进程
> org.gradle.daemon=false

25. 停止存在的守护进程
> gradle --stop






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

6. 查看关于wrapper任务的细节
> gradle help --task wrapper

7. 生成一个wrapper
> gradle wrapper

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








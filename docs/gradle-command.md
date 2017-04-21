[Gradle官网](https://gradle.org/)

1. 查看依赖树
> ./gradlew app:dependencies

2. 上传arr包
> ./gradlew uploadArchives

3. 防止上传arr包出现问题（切换分支可能引起）
> ./gradlew clean uploadArchives

4. 查看模块依赖
> ./gradlew -q dependencies &#60;module-name&#62;:dependencies --configuration compile
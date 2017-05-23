[Proguard下载地址](https://www.guardsquare.com/en/proguard#download)

# ProGuard技术的功能

1. 压缩（shrinks）：检查并移除代码中无用的类、字段、方法、属性

2. 优化（optimizes）：对字节码进行优化，移除无用的指令

3. 混淆（obfuscates）：使用a、b、c、d等简短而无意义的名称，对类、字段和方法进行重命名

4. 预检测（preveirfy）：在Java平台上对处理后的代码进行再次检测

# 用例

运行ProGuard

```
java -jar proguard.jar options ...
```

ProGuard jar包在下载的文件夹的lib目录，也使用bin目录下的脚本执行。典型的场景是将更多的配置放入一个配置文件中，如myconfig.pro

```
java -jar proguard.jar @myconfig.pro
```

可以结合文件和命令行的配置

```
java -jar proguard.jar @myconfig.pro -verbose
```

以#号开头的行为注释，仅支持单行注释

在单词和分隔符之间的多余的空格会被忽略，包含空格或特殊字符的文件名字必须用单引号或者双引号引起来

命令行和配置文件的配置可以任意组合，也就是说，可以将命令行的任意部分用引号引起来，为了避免特殊字符的引申义


# 输入输出选项

1. @filename  
'-include filename'的简写

2. -include filename    
从filename文件中读取配置

3. -basedirectory directoryname   
指定配置文件中的文件名字是基于directoryname路径

4. -injars class_path  
指定要处理的jar包（或aars, wars, ears, zips, apks, 或directories）。非class文件不做处理，injars可多次使用

5. -outjars class_path  
指定输出jar（或aars, wars, ears, zips, apks, 或directories）包的名字

6. -libraryjars class_path  
指定依赖的jar包库，这些jar包不需要被处理，并且不会被包含到输出jar包中

7. -skipnonpubliclibraryclasses  
忽略类库中的非public修饰的类，加快ProGuard处理速度，降低ProGuard内存占用。ProGuard默认读取non-public和public类  
注意：有些编程人员在编写代码时，代码与类库中的类在同一个包下，而且对该包的非public类进行了使用，这样就不能使用该选项

8. -dontskipnonpubliclibraryclasses  
指定不忽略类库中的non-public修饰的类，在4.5版本默认设置了该选项

9. -dontskipnonpubliclibraryclassmembers  
指定不忽略非pulic类中的成员和方法，ProGuard默认会忽略类库中非pulic类中的成员和方法

10. -keepdirectories [directory_filter]  
指定要保留在输出文件的目录（或aars, wars, ears, zips, apks, 或directories），ProGuard会移除入口目录。 举例：-keepdirectories mydirectory 匹配指定的目录，-keepdirectories mydirectory/＊ 匹配直接子目录, -keepdirectories mydirectory/＊＊ 匹配所有子目录

11. -target version  
指定被处理class文件所使用的Java版本，举例：1.0, 1.1, 1.2, 1.3, 1.4, 1.5 (或5), 1.6 (或6), 1.7 (或7), 1.8 (或8)

12. -forceprocessing  
强制输出，即使输出文件已经是最新状态

# Keep选项

1. -keep [,modifier,...] class_specification  
保留指定的类文件和类的成员

2. -keepclassmembers [,modifier,...] class_specification  
保留指定类的成员，注意类名会被混淆

3. -keepclasseswithmembers [,modifier,...] class_specification  
如果指定的类和类的成员存在，则保留该类名和类的方法，未指定的方法依然会被混淆

4. -keepnames class_specification  
-keep,allowshrinking class_specification的简写。如果在压缩阶段该类没有被移除，指定的类和类的成员名字会被保留

5. -keepclassmembernames class_specification  
-keepclassmembers,allowshrinking class_specification的简写。如果在压缩阶段该类没有被移除，指定类的成员名字会被保留

6. -keepclasseswithmembernames class_specification  
-keepclasseswithmembers,allowshrinking class_specification的简写。在压缩后指定的类成员仍存在的情况下，则保留指定的类和类成员

7. -printseeds [filename]  
列出类和类的成员-keep选项的清单，标准输出到给定的文件

# 压缩选项

1. -dontshrink  
不压缩输入的类文件

2. -printusage [filename]  
指定列出输入类文件的dead code，该列表打印到标准输出或给定文件

3. -whyareyoukeeping class_specification  
指定打印类和类成员被保留的理由

# 优化选项

1. -dontoptimize  
不优化输入的类文件

2. -optimizations optimization_filter  
在细粒度级别设置启用或禁用的优化选项

3. -optimizationpasses n  
n次优化，如果在一次优化后，没有任何提升，将停止优化

4. -assumenosideeffects class_specification  
优化指定的代码，例如移除log代码

5. -allowaccessmodification  
优化时允许访问并修改有修饰符的类和类的成员

6. -mergeinterfacesaggressively  
指定接口可以合并，即使实现类没有实现所有的方法 

# 混淆选项

1. -dontobfuscate  
不混淆输入的类文件

2. -printmapping [filename]  
输出类和类成员新旧名字之间的映射到指定文件中

3. -applymapping filename  
重用映射，映射文件未列出的类和类成员会使用随机的名称

4. -obfuscationdictionary filename  
使用给定文件中的关键字作为要混淆方法的名称

5. -classobfuscationdictionary filename  
使用给定文件中的关键字作为要混淆类的名称

6. -packageobfuscationdictionary filename  
使用给定文件中的关键字作为要混淆包的名称

7. -overloadaggressively  
混淆时应用侵入式重载

8. -useuniqueclassmembernames  
方法同名混淆后亦同名，方法不同名混淆后亦 不同名

9. -dontusemixedcaseclassnames  
混淆时不生成大小写混合的类名

10. -keeppackagenames [package_filter]  
不混淆指定的包名

11. -flattenpackagehierarchy [package_name]  
重新包装所有重命名的包并放到给定的包中

12. -repackageclasses [package_name]  
重新包装所有重命名的类文件放到给定的包中

13. -keepattributes [attribute_filter]  
保护给定的可选属性，例如LineNumberTable, LocalVariableTable, SourceFile, Deprecated, Synthetic, Signature, and InnerClasses

14. -keepparameternames  
保留已保留方法的参数的名称及类型

15. -renamesourcefileattribute [string]  
指定一个常量字符串作为SourceFile（和SourceDir）属性的值。需要被-keepattributes选项指定保留

16. -adaptclassstrings [class_filter]  
混淆与完整类名一致的字符串。不指定过滤器时，所有符合现有类的完整类名的字符串常量均会混淆

17. -adaptresourcefilenames [file_filter]  
以混淆后的类文件作为样本重命名指定的源文件。没指定过滤器时，所有源文件都会重命名。只有开启混淆时可用

18. -adaptresourcefilecontents [file_filter]  
以混淆后的类文件作为样本混淆指定的源文件中与完整类名一致的内容。没指定过滤器时，所有源文件中与完整类名一致的内容均会混淆


# 预校验选项

1. -dontpreverify  
指定不对处理后的类文件进行预校验。默认情况下如果类文件的目标平台是 Java Micro Edition 或 Java 6 或更高时会进行预校验。目标平台是 Android 时没必要开启，关闭可减少处理时间

2. -microedition  
指定处理后的类文件目标平台是 Java Micro Edition


# 通用选项

1. -verbose  
指定处理期间打印更多相关信息

2. -dontnote [class_filter]  
指定配置中潜在错误或遗漏时不打印相关信息。类名错误或遗漏选项时这些信息可能会比较有用。class_filter 是一个可选的正则表达式。类名匹配时 ProGuard 不会输出这些类的相关信息

3. -dontwarn [class_filter]  
指定找不到引用或其他重要问题时不打印警告信息。class_filter 是一个可选的正则表达式。类名匹配时 ProGuard 不会输出这些类的相关信息  
注意：如果找不到引用的类或方法在处理过程中是必须的，处理后的代码将会无法正常运行

4. -ignorewarnings  
打印找不到引用或其他重要问题的警告信息，但继续处理代码  
注意：如果找不到引用的类或方法在处理过程中是必须的，处理后的代码将会无法正常运行。请明确该操作的影响时使用该选项

5. -printconfiguration [filename]  
将已解析过的配置标准输出到指定的文件。该选项可用于调试配置

6. -dump [filename]  
标准输出类文件的内部结构到给定的文件中。例如，要输出一个 jar 文件的内容而不需要进行任何处理


# 类路径

ProGuard允许通用的类路径书写方式来指定输入输出文件，类路径可以由输入文件和分隔符（Unix：':'，Windows：';'）组成。在重复的情况下，输入文件的顺序决定了他们的优先级  

输入路径项可以是：  
1. 一个类文件或资源  

2. 一个Apk文件  

3. 一个arr文件  

4. 一个war文件  

5. 一个ear文件  

6. 一个zip文件  

7. 一个目录  

直接路径下的类文件和资源会被忽略，所以类文件通常应该为jar、arr、war、ear、zip或者目录的一部分。除此之外，在归档文件或者目录中的类文件的路径不允许有额外的目录前缀

输出文件可以是
1. 一个类文件或资源  

2. 一个Apk文件  

3. 一个arr文件  

4. 一个war文件  

5. 一个ear文件  

6. 一个zip文件  

7. 一个目录  

在输出文件的过程中，ProGuard通常会按输入文件的结构打包结果  
将所有内容写到输出目录最直接的方式是：将输入文件的完整结构输出到指定目录  
打包是很复杂的过程：处理一个完整的程序，将zip文件和它的文档一起打包，再以zip格式输出  

除此之外，ProGuard支持基于文件名称来过滤类和内容。每个类路径文件可以指定7种文件过滤，过滤类型写在括号中，并用分号隔开  

1. 对所有arr文件的类名称过滤  

2. 对所有apk文件的类名称过滤  

3. 对所有zip文件的类名称过滤  

4. 对所有ear文件的类名称过滤  

5. 对所有war文件的类名称过滤  

6. 对所有jar文件的类名称过滤  

7. 对所有类文件名称和资源文件名称过滤  

如果指定少于7个过滤，他们会被设置为后边的过滤，空的过滤会被忽略。完整的过滤格式如下：

```
classpathentry([[[[[[aarfilter;]apkfilter;]zipfilter;]earfilter;]warfilter;]jarfilter;]filefilter)
```

方括号中的内容是可选的  

举例：  

1. 匹配java和javax目录下的所有类文件

```
rt.jar(java/**.class,javax/**.class)
```

2. 匹配images目录下的所有文件，排除git文件

```
input.jar(!**.gif,images/**)
```

不同的筛选类型会匹配相应的文件类型，与输入文件的嵌套层级无关，例如：  

3. 只匹配lib和support目录的类文件和gif文件

```
input.war(lib/**.jar,support/**.jar;**.class,**.gif)
```

# 文件名称

ProGuard允许使用文件、目录名称的绝对路径和相对路径。相对路径有以下理解方式：  

1. 相对于基本目录  

2. 相对于配置文件指定的目录  

3. 相对于工作空间目录  

路径名字可以包含Java系统属性（或Ant属性），用角括号（ '<' and '>'）括起来，这些属性可以被相应的值自动替换  

举例：  

&lt;java.home&gt;/lib/rt.jar 会自动扩展为 /usr/local/java/jdk/jre/lib/rt.jar。 类似地，&lt;user.home&gt;会自动扩展为用户home目录，&lt;user.dir&gt; 会自动扩展为当前工作目录  

如果名称中含有空格或括号，一定要用单或双印号括起来。如果是列表，每个文件名称要被单独括起来。当在命令行中使用的时候，为了避免命令被shell吞掉，引号需要被转义  

例如你可以使用像这样的格式：'-injars "my program.jar":"/your directory/your program.jar"'

# 文件过滤

像通用的文件过滤一样，文件过滤采用逗号分隔，并且名字中可以包含通配符。常用的通配符如下：  

| 通配符 |  说明                                      |
| ----- | :---------------------------------------- |
| ?     | 匹配任一单个字符                             |
| *     | 匹配不包含目录分隔符的文件名的任何部分           |
| **    | 匹配文件名的任何部分，可能包含任意数量的目录分隔符 |

此外，前边标记‘!’的文件名称会被排除掉  

例如，"!**.gif,images/**"可以匹配images目录下所有非git文件

# 过滤

ProGuard提供在不同配置层面上的过滤选项：文件名、目录、类、包、属性和优化等  

逗号分隔的名字可以包含通配符，只有名称匹配的项才会通过过滤器。常用的通配符如下：  

| 通配符 |  说明                                         |
| ----- | :--------------------------------------------|
| ?     | 匹配任一单个字符                                |
| *     | 匹配不包含包和目录分隔符的文件名的任何部分           |
| **    | 匹配文件名的任何部分，可能包含任意数量的包和目录分隔符 |

此外，前边标记‘!’的文件名称会被排除掉。

例如，"!foobar,*bar"可以匹配所有以bar结尾的排出foobar的所有文件名 

# Keep选项修改

1. includedescriptorclasses  
确保方法的参数类型不会重命名，确保方法签名不会被改变。一般用于保证native方法

2. allowshrinking  
指定对象可能会被压缩，即使被keep选项保留

3. allowoptimization  
指定对象可能会被优化，即使被keep选项保留

4. allowobfuscation  
指定对象可能会被混淆，即使被keep保留

# Keep选项概览

-keep选项在压缩和混淆方面理解起来会有一点疑惑，原理也是正则匹配。下面表格总结：

| 通配符 |  说明                                         |
| ----- | :--------------------------------------------|
| ?     | 匹配任一单个字符                                |
| *     | 匹配不包含包和目录分隔符的文件名的任何部分           |
| **    | 匹配文件名的任何部分，可能包含任意数量的包和目录分隔符 |

如果不确定需要哪个keep选项，则可以简单的使用-keep即可

# 类说明

类的说明即是类和类成员的模版，如下所示：

```
[@annotationtype] [[!]public|final|abstract|@ ...] [!]interface|class|enum classname  
	[extends|implements [@annotationtype] classname]  
[{  
	[@annotationtype] [[!]public|private|protected|static|volatile|transient ...] <fields> | (fieldtype fieldname);  

	[@annotationtype] [[!]public|private|protected|static|synchronized|native|abstract|strictfp ...] <methods> |   
	<init>(argumenttype,...) |  
	classname(argumenttype,...) |  
	(returntype methodname(argumenttype,...));  

	[@annotationtype] [[!]public|private|protected|static ... ] *;
	...
}]
```

方括号内的内容是可选的，省略号表示可重复任意数量的前边的选项，竖线表示选项之间的间隔，圆括号表示内部内容的组合，缩进模拟真实的类情况  

内部类用$分开，例如java.lang.Thread$State，类名也可以指定正则表达式，如下：  

| 通配符 |  说明                                         |
| ----- | :--------------------------------------------|
| ?     | 匹配任一单个字符                                |
| *     | 匹配不包含包和目录分隔符的文件名的任何部分           |
| **    | 匹配文件名的任何部分，可能包含任意数量的包和目录分隔符 |

变量和方法的说明也可以使用下面的通配符：

| 通配符          |  说明          ｜
| -------------- | :------------- |
| &lt;init&gt;   | 匹配任何构造方法  |
| &lt;fields&gt; | 匹配任何变量     |
| &lt;methods&gt;| 匹配匹配任何方法  |
| *              | 匹配任何变量或方法|

注意：上面的通配符没有返回类型，只有&lt;init&gt;通配符有参数列表  

变量和方法也可以使用正则表达式，名称中可以包含如下通配符：

| 通配符 |  说明             |
| ----- | :----------------|
| ?     | 匹配方法名的单个字符 |
| *     | 匹配方法名的任何部分 |

修饰符可以包含如下通配符：

| 通配符 |  说明                                       |
| ----- | :------------------------------------------|
| ％    | 匹配任一原始类型（boolean，int等，但不能匹配void）|
| ?     | 匹配类名中的单个字符                           |
| *     | 匹配不包含包分隔符的类名的任何部分                |
| **    | 匹配文件名的任何部分，可能包含任意数量的包分隔符    |
| ***   | 匹配任何类型（原始或非原始类型，数组或非数组）      |
| ...   | 匹配任何类型的任何数量的参数                     |

注意：?、\*和\*\*通配符不能匹配原始类型，此外，只有\*\*\*通配符能匹配任何维度的数组类型。例如‘\*\* get\*()’可以匹配'java.lang.Object getObject()'，但是不能匹配'float getFloat()'和'java.lang.Object[] getObjects()'  

构造器可以使用不带包名的短类名或完整类名指定，对于Java语言，构造器有参数列表，但是没有返回值类型  




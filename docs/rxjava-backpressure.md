# 番外篇

官方关于RxJava 1.x 的未来计划：
1. 2017年6月1日，将停止添加新的操作符，仅修复bug
2. 2018年3月31日，不再维护

# RxJava介绍

RxJava是响应式编程在Java虚拟机上的实践，核心概念是异步和数据流
不再需要关注的细节：线程、同步、线程安全、并发数据数据结构

# RxJava编程举例

一个简单的栗子：

```java
Observable.just(1, 2, 3)
    .subscribeOn(Schedulers.io())
    .observeOn(AndroidSchedulers.mainThread())
    .subscribe(new Observer<Integer>() {
        @Override
        public void onSubscribe(Disposable d) {}

        @Override
        public void onNext(Integer integer) {}

        @Override
        public void onError(Throwable e) {}

        @Override
        public void onComplete() {}
    });
```

说明：just、subscribeOn、observeOn、subscribe都是RxJava中的操作符
just负责创建一个Observable
subscribeOn负责切换Observable调度所在的线程
observeOn负责切换Observer调度所在的线程


# RxJava 1.x 迁移到 RxJava 2.x 应关注的问题
重中之重：RxJava 1.x 和 RxJava 2.x 的依赖不能共存

- 数据源nulls值问题，将会抛出NullPointerException

```java
Observable.just(null);

Single.just(null);

Observable.fromCallable(() -> null)
        .subscribe(System.out::println, Throwable::printStackTrace);

Observable.just(1).map(v -> null)
       .subscribe(System.out::println, Throwable::printStackTrace);
```

- 新增支持BackPressure的Flowable，原Observable不再支持BackPressure

- 新增Single，数据源只允许单值，可被多次订阅

```java
Single<Integer> single = Single.just(25);
single.subscribe(new SingleObserver<Integer>() {
        @Override
        public void onSubscribe(@NonNull Disposable d) {}

        @Override
        public void onSuccess(@NonNull Integer integer) {
            Log.w("TAG", "onSuccess " + integer);
        }

        @Override
        public void onError(@NonNull Throwable e) {}
        });
```

- Completable被重写

```java
CompletableOnSubscribe completableOnSubscribe = new CompletableOnSubscribe() {
        @Override
        public void subscribe(@NonNull CompletableEmitter e) throws Exception {}
        };

Completable completable = Completable.create(completableOnSubscribe);

completable.subscribe(new CompletableObserver() {
        @Override
        public void onSubscribe(@NonNull Disposable d) {}

        @Override
        public void onComplete() {}

        @Override
        public void onError(@NonNull Throwable e) {}
        });
```

- Maybe，理解为Single和Completable的结合
暂时看起来过度设计了

```java
Maybe<Boolean> maybe = Maybe.just(true);

maybe.subscribe(new MaybeObserver<Boolean>() {
        @Override
        public void onSubscribe(@NonNull Disposable d) {}

        @Override
        public void onSuccess(@NonNull Boolean aBoolean) {}

        @Override
        public void onError(@NonNull Throwable e) {}

        @Override
        public void onComplete() {}
        });
```

- Base reactive interfaces
上层被观察者需要实现接口

```java
interface ObservableSource<T> {
    void subscribe(Observer<? super T> observer);
}

interface SingleSource<T> {
    void subscribe(SingleObserver<? super T> observer);
}

interface CompletableSource {
    void subscribe(CompletableObserver observer);
}

interface MaybeSource<T> {
    void subscribe(MaybeObserver<? super T> observer);
}
```

- Subjects和Processors
（1）Subject：AsyncSubject、BehaviorSubject、PublishSubject、ReplaySubject、UnicastSubject
具有Observable和Observer的特性（因为是继承了Observable，实现了Observer），不支持Backpressure
（2）Processor：AsyncProcessor、BehaviorProcessor、PublishProcessor、RepalyProcessor、UnicastProcessor
具有Flowable和FlowableSubscriber，支持Backpressure
（3）移除TestSubject、SerializedSubject不再是public class

- Other classes
（1）ConnectableObservable由ConnectableObservable<T> 和 ConnectableFlowable<T>取代
（2）GroupedObservable由GroupedObservable<T> 和 GroupedFlowable<T>取代

- Functionnal interfaces
（1）Actions：Action0由Action取代，不再使用Action3-Action9，ActionN由Consumer<Object[]>取代
（2）Functions：Func被Function和BiFunction，Func3-Func9改名为Function3-Function9，FuncN由Function<Object[],R>取代

- Subscriber
（1）轻量化（抽象成接口），去除1.x的默认实现
（2）增加上层抽象类：DefaultSubscriber、ResourceSubscriber、DisposableSubscriber
（3）关于Subscriber的一个有趣的问题，示例代码如下：
结论：将初始化操作在request之前完成，保证后续数据流正确
第一种情况：

```java
Flowable.range(1, 3).subscribe(new Subscriber<Integer>() {
    @Override
    public void onSubscribe(Subscription s) {
        System.out.println("OnSubscribe start");
        s.request(Long.MAX_VALUE);
        System.out.println("OnSubscribe end");
    }

    @Override
    public void onNext(Integer v) {
        System.out.println(v);
    }

    @Override
    public void onError(Throwable e) {
        e.printStackTrace();
    }

    @Override
    public void onComplete() {
        System.out.println("Done");
    }
});
```

输出结果：

```java
OnSubscribe start
1
2
3
Done
OnSubscribe end
```

第二种情况：

```java
Flowable.create((FlowableEmitter<Integer> emitter) -> {
            emitter.onNext(1);
            emitter.onNext(2);
            emitter.onNext(3);
            emitter.onComplete();
        }, BackpressureStrategy.BUFFER).subscribe(new Subscriber<Integer>() {
    @Override
    public void onSubscribe(Subscription s) {
        System.out.println("OnSubscribe start");
        s.request(Long.MAX_VALUE);
        System.out.println("OnSubscribe end");
    }

    @Override
    public void onNext(Integer v) {
        System.out.println(v);
    }

    @Override
    public void onError(Throwable e) {
        e.printStackTrace();
    }

    @Override
    public void onComplete() {
        System.out.println("Done");
    }
});
```
输出结果：

```java
OnSubscribe start
OnSubscribe end
1
2
3
Done
```

- Subscription
（1）Subscription由Disposable取代，为避免和reactivestreams里面的Subscription命名冲突
（2）CompositeSubscription由CompositeDisposable取代
（3）SerialSubscription和MultipleAssignmentSubscription由SerialDisposable取代
（4）移除RefCountSubscription

- Backpressure

- Reactice-Streams compliance

- Runtime hooks
（1）支持动态改变运行hooks，移除移除RxJavaObservableHook，RxJavaHooks功能被合并到RxJavaPlugins
RxJavaPlugins，可以设置全局ErrorHandler、SchedulerHandler等
（2）由于RxJavaPlugins是全局资源，不建议自行设置这部分功能

- Error handling
2.0.6版本后，OnErrorNotImplementedException、ProtocolViolationException、UndeliverableException
这些RuntimeException不再被无脑地吞掉

- Schedulers：移除immediate和test Scheduler

- 绝大多数类都添加了RxJava内部测试的相应方法
不作为代码维护者不需要关注
在阅读一些源码的过程中，容易发现，优秀的开源库都有相当完备的测试代码

# Backpressure

- In RxJava it is not difficult to get into a situation in which an Observable is emitting items more rapidly than an operator or subscriber can consume them. This presents the problem of what to do with such a growing backlog of unconsumed items.
- Backpressure是解决异步场景下被观察者和观察者速度不一致问题的一种策略：下游观察者通知上游的被观察者发送数据

## 使用操作符作为Backpressure的替代方案

应用场景：突发且间断发出的数据流


![Paste_Image.png](http://upload-images.jianshu.io/upload_images/2694702-2c1068de00b1f106.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- Throttling 节流
操作符：sample、throttleLast、throttleFirst、throttleWithTimeout、debounce
作用：控制被观察者的发射速率

（1）sample or throttleLast

![A97860E4-5CED-4884-B67C-68632B617F1C.png](http://upload-images.jianshu.io/upload_images/2694702-d258c7bc2429cf26.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

```java
Observable<Integer> burstySampled = bursty.sample(500, TimeUnit.MILLISECONDS);
```

（2）throttleFirst

![0E7DAD10-A73E-46F8-9E0F-B17474643276.png](http://upload-images.jianshu.io/upload_images/2694702-8202301f41e4ee86.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

```java
Observable<Integer> burstyThrottled = bursty.throttleFirst(500, TimeUnit.MILLISECONDS);
```

（3）debunce or throttleWithTimeout

![CFD0415E-E464-4062-9D37-C1B787B91B30.png](http://upload-images.jianshu.io/upload_images/2694702-44b27450bd014cfe.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

```java
Observable<Integer> burstyDebounced = bursty.debounce(10, TimeUnit.MILLISECONDS);
``` 

- Buffers and Windows 缓存

（1）buffer

![34F2632D-2398-4F3D-9911-00098FD675AB.png](http://upload-images.jianshu.io/upload_images/2694702-95c45163920f27d5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


也可以结合debounce使用，将数据缓存下来，打包发射一串数据

![AC4147FB-23C3-4DBC-93FA-67C4F76A595F.png](http://upload-images.jianshu.io/upload_images/2694702-572942373b5919eb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

```java
// we have to multicast the original bursty Observable so we can use it 
// both as our source and as the source for our buffer closing selector: 
Observable<Integer> burstyMulticast = bursty.publish().refCount();
// burstyDebounced will be our buffer closing selector: 
Observable<Integer> burstyDebounced = burstMulticast.debounce(10, TimeUnit.MILLISECONDS); 
// and this, finally, is the Observable of buffers we're interested in: 
Observable<List<Integer>> burstyBuffered = burstyMulticast.buffer(burstyDebounced);
``` 

（2）window

![28B03A56-4B6C-4D9A-88AB-E0358EC4A9DB.png](http://upload-images.jianshu.io/upload_images/2694702-587d1875ee01845e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

```java
Observable<Observable<Integer>> burstyWindowed = bursty.window(500, TimeUnit.MILLISECONDS);
``` 

![22BF17ED-A359-44C7-A9AA-902D653BB5A6.png](http://upload-images.jianshu.io/upload_images/2694702-d13f833831c82595.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

```java
Observable<Observable<Integer>> burstyWindowed = bursty.window(5);
``` 

## Backpressure策略－－响应式拉模式

```java
someObservable.subscribe(new Subscriber<t>() {
    @Override
    public void onStart() {
      request(1);
    }

    @Override
    public void onCompleted() {
      // gracefully handle sequence-complete
    }

    @Override
    public void onError(Throwable e) {
      // gracefully handle error
    }

    @Override
    public void onNext(t n) {
      // do something with the emitted item "n"
      // request another item:
      request(1);
    }
});
```

注意事项：
request(Long.MAX_VALUE) 取消Backpressure策略
request(0) 无作用
request(<0) 抛出异常

## Backpressure的补充策略
由于Flowable的不同的操作符对Backpressure的支持程度不同，仍可能会抛出MissingBackpressureException
所以可以使用下面的操作符作为Backpressure补充处理
（1）onBackpressureBuffer：缓冲当前无法消费的数据，直到观察者可以处理为止。由于缓冲区为无界大小，所以可能会出现OOM
（2）onBackpressureDrop：当观察者无法处理数据时，则把该数据丢弃掉
（3）onBackpressureLatest：观察者会接收Observable最新发出的item进行处理

# 最后
明确RxJava2.x Backpressure的几个问题：
1. Backpressure是怎么解决被观察者发射数据过快的问题？
使用响应拉模式
2. Rxjava 1.x 版本的MissingBackpressureException在RxJava 2.x 中被完美解决了吗？
这个问题非常不恰当，RxJava 2.x不是解决了MissingBackpressureException，简单来说，RxJava 2.x 中拆分被观察者为两部分，Observable（no Backpressure）和Flowable（Backpressure），同时在Flowable的操作符实现中，不同程度地尊重了下游的消费能力
3. Flowable的所有操作符安全并正确地实现了Backpressure吗？
没有！！！
Flowable不同的操作符对Backpressure支持程度不同，在BackpressureKind类中定义了Backpressure的种类：
（1）PASS_THROUGH：不响应Backpressure策略，例如filter
（2）FULL：完全支持Backpressure策略，可以响应下游request操作，例如range
（3）SPECIAL：支持特殊的Backpressure策略，例如take
（4）UNBOUNDED_IN：向上游请求Long.MAX_VALUE，但考虑下游的消费能力，例如toList
（5）ERROR：如果下游消费能力不够或者不及时，则发射MissingBackpressureException，例如interval
（6）NONE：忽略所有Backpressure策略，可能会淹没下游，例如toObservable
4. 如何在实际场景中使用Backpressure？
根据实际场景，正确评估被观察者发射速率的量级和观察者的消费能力，在两者之间做合适的权衡，避免出现MissingBackpressureException和OutOfMemoryError
（1）官方推荐使用Observable的场景：
数据流最多不超过1000个元素，内存基本不会出现溢出
鼠标或触摸事件，由于数据发射的突发性，很难合理使用背压策略（可以结合 sampling/debouncing 操作）
如果处理同步数据流而且Java平台不支持Java Stream，使用Observable比Flowable性能更好
（2）官方推荐使用Flowable的场景：
解决10k+的元素的场景
从磁盘中读（解析）文件，如读取指定行数的请求
通过JDBC读取数据库
网络IO流
阻塞的或基于拉模式的数据源，最终需要转换成非阻塞接口的场景
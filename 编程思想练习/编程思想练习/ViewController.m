//
//  ViewController.m
//  编程思想练习
//
//  Created by mac mini on 16/5/18.
//  Copyright © 2018年 何少博. All rights reserved.
//

#import "ViewController.h"

#import "CalculatorMaker.h"
#import "KVOClass.h"
#import "Calculator.h"

static void * KvoNameContext1 = &KvoNameContext1;
static void * KvoNameContext2 = &KvoNameContext2;
static void * KvoNameContext3 = &KvoNameContext3;
static void * KvoNameContext4 = &KvoNameContext4;
static void * KvoNameContext5 = &KvoNameContext5;

@interface ViewController ()


@property(nonatomic,strong) KVOClass *kvo;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ///链接： https://www.jianshu.com/p/87ef6720a096 作者：袁峥
    /*
     先简单介绍下目前咱们已知的编程思想。
     
     1 面向过程：处理事情以过程为核心，一步一步的实现。
     
     2 面向对象：万物皆对象
     
     3 链式编程思想：是将多个操作（多行代码）通过点号(.)链接在一起成为一句代码,使代码可读性好。a(1).b(2).c(3)
     链式编程特点：方法的返回值是block,block必须有返回值（本身对象），block参数（需要操作的值）
     代表：masonry框架。
     模仿masonry，写一个加法计算器，练习链式编程思想。
     
     4 响应式编程思想：不需要考虑调用顺序，只需要知道考虑结果，类似于蝴蝶效应，产生一个事件，会影响很多东西，这些事件像流一样的传播出去，然后影响结果，借用面向对象的一句话，万物皆是流。
     代表：KVO运用。
     
     5 函数式编程思想：是把操作尽量写成一系列嵌套的函数或者方法调用。
     函数式编程特点：每个方法必须有返回值（本身对象）,把函数或者Block当做参数,block参数（需要操作的值）block返回值（操作结果）
     代表：ReactiveCocoa。
     用函数式编程实现，写一个加法计算器,并且加法计算器自带判断是否等于某个值.
     */
    
    ///链式编程计算器
    double result = [CalculatorMaker makeCalculators:^(CalculatorMaker *make) {
        make.add(5).sub(2).muilt(10).divide(2);/// （ 5 - 2 ）* 10 / 2
    }];
    NSLog(@"result = %f",result);
    
    ///响应式编程 KVO
    /*
     一、KVO (Key-Value Observing)
     KVO 是 Objective-C 对观察者模式（Observer Pattern）的实现。也是 Cocoa Binding 的基础。当被观察对象的某个属性发生更改时，观察者对象会获得通知。
     
     有意思的是，你不需要给被观察的对象添加任何额外代码，就能使用 KVO 。这是怎么做到的？
     
     二、 KVO内部实现原理
     KVO是基于runtime机制实现的
     当某个类的属性对象第一次被观察时，系统就会在运行期动态地创建该类的一个派生类，在这个派生类中重写基类中任何被观察属性的setter 方法。派生类在被重写的setter方法内实现真正的通知机制
     如果原类为Person，那么生成的派生类名为NSKVONotifying_Person
     每个类对象中都有一个isa指针指向当前类，当一个类对象的第一次被观察，那么系统会偷偷将isa指针指向动态生成的派生类，从而在给被监控属性赋值时执行的是派生类的setter方法
     键值观察通知依赖于NSObject 的两个方法: willChangeValueForKey: 和 didChangevlueForKey:；在一个被观察属性发生改变之前， willChangeValueForKey:一定会被调用，这就 会记录旧的值。而当改变发生后，didChangeValueForKey:会被调用，继而 observeValueForKey:ofObject:change:context: 也会被调用。
     补充：KVO的这套实现机制中苹果还偷偷重写了class方法，让我们误认为还是使用的当前类，从而达到隐藏生成的派生类
     
     
     链接：https://www.jianshu.com/p/829864680648 作者：Mg明明就是你
     链接：https://github.com/renjinkui2719/DIS_KVC_KVO
     */
    self.kvo = [KVOClass new];
    self.kvo.kvo = [KVOClass new];
    
    ///函数式编程
    
    Calculator * calcultor = [Calculator new];
    ///判断 2 + 5 == 10
    BOOL isEqual =
    [[calcultor calculator:^int(int result) {
        result = 2 + 5;
        return result;
    }] equal:^BOOL(int result) {
        return result == 10;
    }].isEqual ;
    NSLog(@"isEqual = %d",isEqual);
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self addObserver];
    self.kvo.name = @"2345678";
    self.kvo.kvo.name = @"wertyu";
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self removeObserver];
}


-(void)addObserver
{
    /*
     调用者-> 要监听的对象
     Observer->观察者即负责监听的对象
     KeyPath-> 被观察的属性名
     options-> 观察的选项（观察新、旧值，也可以都观察）
     context-> 上下文，用于传递数据，可以利用上下文区分不同的监听
     */
    [self addObserver:self
           forKeyPath:@"kvo.name"
              options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
              context:KvoNameContext1];
    
    [self.kvo addObserver:self
               forKeyPath:@"name"
                  options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
                  context:KvoNameContext2];
    
    [self.kvo addObserver:self
               forKeyPath:@"kvo.name"
                  options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
                  context:KvoNameContext3];
    
    [self.kvo.kvo addObserver:self
                   forKeyPath:@"name"
                      options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
                      context:KvoNameContext4];
    
    [self addObserver:self
           forKeyPath:@"kvo.kvo.name"
              options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
              context:KvoNameContext5];
    
}
-(void)removeObserver{
    [self removeObserver:self
              forKeyPath:@"kvo.name"
                 context:KvoNameContext1];
    
    [self.kvo removeObserver:self
                  forKeyPath:@"name"
                     context:KvoNameContext2];
    
    [self.kvo removeObserver:self
                  forKeyPath:@"kvo.name"
                     context:KvoNameContext3];
    
    [self.kvo.kvo removeObserver:self
                      forKeyPath:@"name"
                         context:KvoNameContext4];
    
    [self removeObserver:self
              forKeyPath:@"kvo.kvo.name"
                 context:KvoNameContext5];

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    id oldValue = change[NSKeyValueChangeOldKey];
    id newValue = change[NSKeyValueChangeNewKey];
    NSLog(@"oldValue = %@",oldValue);
    //    if ([keyPath isEqualToString:@"name"] && object == self.kvo) {
    //          可以使用这种判断逻辑，也可以使用context
    //    }
    if (context == KvoNameContext1) {
        if ( newValue && newValue != [NSNull null] ) {
            NSLog(@"KvoNameContext1");
            NSLog(@"newValue = %@",newValue);
        }
    }
    else if (context == KvoNameContext2){
        if ( newValue && newValue != [NSNull null] ) {
            NSLog(@"KvoNameContext2");
            NSLog(@"newValue = %@",newValue);
        }
    }
    else if (context == KvoNameContext3){
        if ( newValue && newValue != [NSNull null] ) {
            NSLog(@"KvoNameContext3");
            NSLog(@"newValue = %@",newValue);
        }
    }
    else if (context == KvoNameContext4){
        if ( newValue && newValue != [NSNull null] ) {
            NSLog(@"KvoNameContext4");
            NSLog(@"newValue = %@",newValue);
        }
    }
    else if (context == KvoNameContext5){
        if ( newValue && newValue != [NSNull null] ) {
            NSLog(@"KvoNameContext5");
            NSLog(@"newValue = %@",newValue);
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

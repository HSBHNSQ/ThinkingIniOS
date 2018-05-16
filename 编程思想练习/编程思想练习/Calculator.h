//
//  Calculator.h
//  编程思想练习
//
//  Created by mac mini on 16/5/18.
//  Copyright © 2018年 何少博. All rights reserved.
//

#import <Foundation/Foundation.h>

///函数式编程例子
///函数式编程思想：是把操作尽量写成一系列嵌套的函数或者方法调用。
///函数式编程特点：每个方法必须有返回值（本身对象）,把函数或者Block当做参数,block参数（需要操作的值）block返回值（操作结果）
@interface Calculator : NSObject

@property (nonatomic,assign) BOOL isEqual;

@property (nonatomic,assign) int result;


-(Calculator *)calculator:(int(^)(int result))calcultor;

-(Calculator *)equal:(BOOL(^)(int result))operatioin;



@end

//
//  CalculatorMaker.h
//  编程思想练习
//
//  Created by mac mini on 16/5/18.
//  Copyright © 2018年 何少博. All rights reserved.
//

#import <Foundation/Foundation.h>

///链式编程计算器计算器例子
///链式编程思想：是将多个操作（多行代码）通过点号(.)链接在一起成为一句代码,使代码可读性好。a(1).b(2).c(3)
///链式编程特点：方法的返回值是block,block必须有返回值（本身对象），block参数（需要操作的值）
@interface CalculatorMaker : NSObject


@property (nonatomic,assign) double result;

+(double)makeCalculators:(void(^)(CalculatorMaker *make))calculatorMaker;

///加
-(CalculatorMaker *(^)(double))add;
///减
-(CalculatorMaker *(^)(double))sub;
///乘
-(CalculatorMaker *(^)(double))muilt;
///除
-(CalculatorMaker *(^)(double))divide;

@end

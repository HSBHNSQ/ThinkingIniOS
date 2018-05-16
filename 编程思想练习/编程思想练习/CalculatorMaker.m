//
//  CalculatorMaker.m
//  编程思想练习
//
//  Created by mac mini on 16/5/18.
//  Copyright © 2018年 何少博. All rights reserved.
//

#import "CalculatorMaker.h"

@implementation CalculatorMaker

//    <#returnType#>(^<#blockName#>)(<#parameterTypes#>) = ^(<#parameters#>) {
//        <#statements#>
//    };

+(double)makeCalculators:(void (^)(CalculatorMaker *))calculatorMaker{
    CalculatorMaker * maker = [CalculatorMaker new];
    calculatorMaker(maker);
    return maker.result;
}

-(CalculatorMaker *(^)(double))add
{
    __weak typeof(self) weakSelf = self;
    return ^CalculatorMaker *(double value){
        weakSelf.result += value;
        return weakSelf;
    };
}

-(CalculatorMaker *(^)(double))sub
{
    __weak typeof(self) weakSelf = self;
    return ^CalculatorMaker *(double value){
        weakSelf.result -= value;
        return weakSelf;
    };
}

-(CalculatorMaker *(^)(double))muilt
{
    __weak typeof(self) weakSelf = self;
    return ^CalculatorMaker *(double value){
        weakSelf.result *= value;
        return weakSelf;
    };
}

-(CalculatorMaker *(^)(double))divide
{
    __weak typeof(self) weakSelf = self;
    return ^CalculatorMaker *(double value){
        weakSelf.result /= value;
        return weakSelf;
    };
}
@end

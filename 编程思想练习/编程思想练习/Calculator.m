//
//  Calculator.m
//  编程思想练习
//
//  Created by mac mini on 16/5/18.
//  Copyright © 2018年 何少博. All rights reserved.
//

#import "Calculator.h"

@implementation Calculator

-(Calculator *)calculator:(int (^)(int))calcultor{
    self.result = calcultor(_result);
    return self;
}

-(Calculator *)equal:(BOOL (^)(int))operatioin{
    self.isEqual = operatioin(_result);
    return self;
}

@end

//
//  LEOperation.h
//  NSOperationTest
//
//  Created by lwp on 2017/1/12.
//  Copyright © 2017年 LE. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LEOperation, LEOperationQueue;

typedef void(^bLEResult)(BOOL finished);
typedef void(^bLEStartBlock)(LEOperation *op, bLEResult finished);

@interface LEOperation : NSOperation

/**
 LEOperationQueue
 */
@property(nonatomic, strong, readonly) LEOperationQueue *mainOperationQueue;

/**
 结束当前Operation后的回调函数
 */
@property(nonatomic, copy) void(^bLEOperationDidFinish)(void);

/**
 标识符
 */
@property(nonatomic, strong) NSString *identifier;

/**
 绑定的对象
 */
@property(nonatomic, strong) id obj;

/**
 创建
 */
+ (instancetype)operationWithStartBlock:(bLEStartBlock)startBlock;

/**
 结束当前Operation
 */
- (void)operationFinished;

@end

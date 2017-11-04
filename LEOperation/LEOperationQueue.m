//
//  LEOperationQueue.m
//  Pods
//
//  Created by mac on 2017/8/4.
//
//

#import "LEOperationQueue.h"

@interface LEOperation (LEPrivate)

@property(nonatomic, strong) LEOperationQueue *operationQueue;///父OperationQueue，LEOperationQueue调用设置

@end

@interface LEOperationQueue ()

@end

@implementation LEOperationQueue

#pragma mark - LazyLoad
#pragma mark - Super

- (void)addOperation:(LEOperation *)op {
    NSAssert([op isKindOfClass:[LEOperation class]], @"LEOperationQueue只能添加LEOperation");
    [super addOperation:op];
    op.operationQueue = self;
}

- (void)cancelAllOperations {
    [super cancelAllOperations];
    ///取消当前显示中的Operation
    [self.currentOperation operationFinished];
}

#pragma mark - Init
#pragma mark - PublicMethod

/**
 创建队列
 */
+ (instancetype)createOperationQueue {
    LEOperationQueue *orderQueue = [[LEOperationQueue alloc] init];
    orderQueue.maxConcurrentOperationCount = 1;
    return orderQueue;
}

/**
 队列池中的个数，包含正在显示的
 */
- (NSUInteger)le_operationCount {
    if (self.isSuspended) {
        return self.operationCount + 1;
    }
    return self.operationCount;
}

#pragma mark - PrivateMethod

/**
 设置当前显示中的LEOperation，LEOperation调用设置
 */
- (void)setCurrentOperation:(LEOperation *)currentOperation {
    _currentOperation = currentOperation;
}

#pragma mark - Events
#pragma mark - LoadFromService
#pragma mark - Delegate
#pragma mark - StateMachine

@end

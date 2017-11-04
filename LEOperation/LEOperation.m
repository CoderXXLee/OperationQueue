//
//  LEOperation.m
//  NSOperationTest
//
//  Created by lwp on 2017/1/12.
//  Copyright © 2017年 LE. All rights reserved.
//

#import "LEOperation.h"
#import "LEOperationQueue.h"

@interface LEOperationQueue (LEPrivate)

/**
 设置当前显示中的LEOperation
 */
- (void)setCurrentOperation:(LEOperation *)currentOperation;

@end

@interface LEOperation ()

@property (nonatomic, getter = isFinished)  BOOL finished;
@property (nonatomic, getter = isExecuting) BOOL executing;

@property(nonatomic, copy, readonly) bLEStartBlock startBlock;

@property(nonatomic, strong) LEOperationQueue *operationQueue;///父OperationQueue

@end

@implementation LEOperation

@synthesize finished = _finished;
@synthesize executing = _executing;

#pragma mark - LazyLoad
#pragma mark - Super

- (instancetype)init {
    self = [super init];
    if (self) {
        _executing = NO;
        _finished  = NO;
    }
    return self;
}

- (void)start {
    if ([self isCancelled]) {
        self.finished = YES;
        return;
    }
    self.executing = YES;
    ///设置当前显示中的LEOperation
    [self.operationQueue setCurrentOperation:self];

    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        if (self.startBlock) {
            self.startBlock(self, ^(BOOL finished){
                ///置空当前显示中的LEOperation
                [self.operationQueue setCurrentOperation:nil];
                self.finished = finished;
            });
        }
    }];
    
}

#pragma mark - Init

#pragma mark - PublicMethod

+ (instancetype)operationWithStartBlock:(bLEStartBlock)startBlock {
    LEOperation *op = [[LEOperation alloc] init];
    op->_startBlock = startBlock;
    return op;
}

/**
 结束当前队列
 */
- (void)operationFinished {
    ///置空当前显示中的LEOperation
    [self.operationQueue setCurrentOperation:nil];
    ///置空绑定的object
    self.obj = nil;
    ///结束当前operation
    self.finished = YES;
    ///回调
    if (self.bLEOperationDidFinish) {
        self.bLEOperationDidFinish();
        self.bLEOperationDidFinish = nil;
    }
}

/**
 LEOperationQueue
 */
- (LEOperationQueue *)mainOperationQueue {
    return self.operationQueue;
}

#pragma mark - PrivateMethod

#pragma mark - Events
#pragma mark - LoadFromService
#pragma mark - Delegate
#pragma mark - StateMachine

#pragma mark -  手动触发 KVO

- (void)setExecuting:(BOOL)executing {
    [self willChangeValueForKey:@"isExecuting"];
    _executing = executing;
    [self didChangeValueForKey:@"isExecuting"];
}

- (void)setFinished:(BOOL)finished {
    [self willChangeValueForKey:@"isFinished"];
    _finished = finished;
    [self didChangeValueForKey:@"isFinished"];
}

@end

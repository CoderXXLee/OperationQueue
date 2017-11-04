//
//  LEOperationQueue.h
//  Pods
//
//  Created by mac on 2017/8/4.
//
//

#import <Foundation/Foundation.h>
#import "LEOperation.h"

@interface LEOperationQueue : NSOperationQueue

/**
 队列池中的个数，包含正在显示的
 */
@property (readonly) NSUInteger le_operationCount;

/**
 显示中的LEOperation
 */
@property(nonatomic, strong, readonly) LEOperation *currentOperation;

/**
 创建队列
 */
+ (instancetype)createOperationQueue;

@end

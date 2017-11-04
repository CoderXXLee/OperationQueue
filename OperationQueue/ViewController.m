//
//  ViewController.m
//  OperationQueue
//
//  Created by mac on 2017/11/4.
//  Copyright © 2017年 le. All rights reserved.
//

#import "ViewController.h"
#import "LEOperationQueue.h"
#import "LEPresentViewController.h"

//weakSelf
#define LEWeakObject(name, obj) __weak __typeof (obj)name = obj;
//strongSelf
#define LEStrongObject(name, obj) __strong __typeof (obj)name = obj;

#define LEWself LEWeakObject(wself, self)
#define LESself LEStrongObject(sself, wself)

//切换到主线程
#define dispatch_main_sync_safe_le(block)\
if ([NSThread isMainThread]) {\
block();\
}\
else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}

@interface ViewController ()

@property (nonatomic, strong, readwrite) LEOperationQueue *orderQueue;///订单队列

@end

@implementation ViewController

#pragma mark - LazyLoad

- (LEOperationQueue *)orderQueue {
    if (_orderQueue == nil) {
        _orderQueue = [LEOperationQueue createOperationQueue];
    }
    return _orderQueue;
}

#pragma mark - Super

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Init
#pragma mark - PublicMethod
#pragma mark - PrivateMethod

/**
 添加新订单队列
 */
- (void)addOrderOperation:(LEPresentViewController *)vc {
    LEWself
    ///添加队列，依次执行快速多次点击情况
    LEOperation *opation = [LEOperation operationWithStartBlock:^(LEOperation *op, bLEResult finished) {
        LESself
        LEPresentViewController *vc = op.obj;
        dispatch_main_sync_safe_le(^{
            UINavigationController *root = [[UINavigationController alloc] initWithRootViewController:vc];
            [sself presentViewController:root animated:YES completion:nil];
        });
    }];
    opation.obj = vc;
    vc.operation = opation;
    ///回调
    opation.bLEOperationDidFinish = ^{
    };

    [self.orderQueue addOperation:opation];
}

#pragma mark - Events

- (IBAction)show:(id)sender {
    for (int i = 0; i < 5; i++) {
        LEPresentViewController *vc = [[LEPresentViewController alloc] init];
        vc.title = [NSString stringWithFormat:@"第%d个控制器", i];
        [self addOrderOperation:vc];
    }
}

#pragma mark - LoadFromService
#pragma mark - Delegate
#pragma mark - StateMachine

@end

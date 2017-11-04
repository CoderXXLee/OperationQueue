//
//  LEPresentViewController.m
//  OperationQueue
//
//  Created by mac on 2017/11/4.
//  Copyright © 2017年 le. All rights reserved.
//

#import "LEPresentViewController.h"

@interface LEPresentViewController ()

@end

@implementation LEPresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    int x = arc4random() % 255;
    int y = arc4random() % 255;
    int z = arc4random() % 255;

    self.view.backgroundColor = [UIColor colorWithRed:x/255.f green:y/255.f blue:z/255.f alpha:1];
}

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        [self.operation operationFinished];
    }];
}

- (void)dealloc {
    NSLog(@"%@销毁", self.title);
}

@end

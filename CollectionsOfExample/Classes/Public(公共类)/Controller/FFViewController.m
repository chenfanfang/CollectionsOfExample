//
//  FFViewController.m
//  CollectionsOfExample
//
//  Created by mac on 16/7/17.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFViewController.h"



@interface FFViewController ()

@end

@implementation FFViewController


/***********************************生命周期***********************************/
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
}


/***********************************事件处理***********************************/
#pragma mark - 事件处理
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


@end

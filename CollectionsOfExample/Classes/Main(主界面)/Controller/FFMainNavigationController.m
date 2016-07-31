//
//  FFMainNavigationController.m
//  CollectionsOfExample
//
//  Created by mac on 16/7/17.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFMainNavigationController.h"

//controller
#import "FFMainViewController.h"

@interface FFMainNavigationController ()

@end

@implementation FFMainNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

- (void)setup {
    
    self.navigationBar.translucent = NO;
    
//    self.navigationBar.tintColor = [UIColor whiteColor];
//    self.navigationBar.translucent = NO;
//    //设置导航栏文字
//    [self.navigationBar setTitleTextAttributes:@{
//                                                 NSFontAttributeName : [UIFont boldSystemFontOfSize:18],
//                                                 NSForegroundColorAttributeName : [UIColor whiteColor]
//                                                 
//                                                 }];
}




@end

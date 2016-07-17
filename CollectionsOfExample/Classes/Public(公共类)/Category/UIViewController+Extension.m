//
//  UIViewController+Extension.m
//  CollectionsOfExample
//
//  Created by mac on 16/7/17.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "UIViewController+Extension.h"

@implementation UIViewController (Extension)

+ (instancetype)viewControllerFromNib {
    UIViewController *viewController = [[self alloc] initWithNibName:NSStringFromClass([self class]) bundle:nil];
    return viewController;
}

@end

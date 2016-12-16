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
    UIImage *bgImage = [self imageWithColor:[UIColor colorWithRed:215 / 255.0 green:44 / 255.0 blue:53 / 255.0 alpha:1] size:CGSizeMake(1000, 100)];
    [self.navigationBar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.translucent = NO;
    self.navigationBar.shadowImage = [UIImage new];
    //设置导航栏文字
    [self.navigationBar setTitleTextAttributes:@{
                                                 NSFontAttributeName : [UIFont boldSystemFontOfSize:15],
                                                 NSForegroundColorAttributeName : [UIColor whiteColor]
                                                 
                                                 }];
}


/**根据颜色返回一张纯色的图片*/
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}



@end

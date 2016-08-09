//
//  FFClickStatusBarScrollToTopManager.m
//  CollectionsOfExample
//
//  Created by mac on 16/8/9.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFClickStatusBarScrollToTopManager.h"

@implementation FFClickStatusBarScrollToTopManager

static UIWindow *statusBarWindow;

+ (void)becomeEffective {
    if (statusBarWindow == nil) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            statusBarWindow = [[UIWindow alloc] init];
            statusBarWindow.frame = [UIApplication sharedApplication].statusBarFrame;
            statusBarWindow.backgroundColor = [UIColor clearColor];
            statusBarWindow.windowLevel = UIWindowLevelAlert;
            [statusBarWindow addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topWindowClick)]];
            statusBarWindow.hidden = NO;
            /*
             UIWindowLevelAlert > UIWindowLevelStatusBar > UIWindowLevelNormal
             1.级别越高的window，显示在越上面（越顶部）
             2.级别一样，后面创建显示的窗口会显示在上面
             */
        });
    }
    
    else {
        statusBarWindow.hidden = NO;
    }
}

+ (void)disabled {
    statusBarWindow.hidden = YES;
}

+ (void)topWindowClick {
    // 用递归的思想找到所有的UIScrollView
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [self searchAllScrollViewsInView:keyWindow];
}


/**
 *  找到view里面的所有UIScrollView
 */
+ (void)searchAllScrollViewsInView:(UIView *)view {
    
    // 这个for循环可以保证所有子控件都能传进来
    for (UIView *subview in view.subviews) {
        [self searchAllScrollViewsInView:subview];
    }
    
    // 如果不是UIScrollView，直接返回
    if (![view isKindOfClass:[UIScrollView class]]) return;
    
    
    //如果是scrollView则进行如下的处理
    UIScrollView *scrollView = (UIScrollView *)view;
    
    CGRect scrollViewRect = [scrollView convertRect:scrollView.bounds toView:nil];
    CGRect keyWindowRect = [UIApplication sharedApplication].keyWindow.bounds;
    
    // 如果scrollView的矩形框 跟 keywindow 没有重叠，直接返回
    if (!CGRectIntersectsRect(scrollViewRect, keyWindowRect)) return;

    
    // 若scrollView与keyWindow重叠让UIScrollView滚动到最前面
    [scrollView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
    
}

@end

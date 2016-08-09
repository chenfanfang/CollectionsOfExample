//
//  FFUIWindowUsage_ MultipleScrollView.m
//  CollectionsOfExample
//
//  Created by mac on 16/8/9.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFUIWindowUsage_MultipleScrollView.h"

//controller
#import "FFUIWindowUsage_SingleScrollViewVC.h"

//manager
#import "FFClickStatusBarScrollToTopManager.h"

@interface FFUIWindowUsage_MultipleScrollViewVC ()

@end

@implementation FFUIWindowUsage_MultipleScrollViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.dealwithStatusBarClick == YES) {
        [FFClickStatusBarScrollToTopManager becomeEffective];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    if (self.dealwithStatusBarClick == YES) {
        [FFClickStatusBarScrollToTopManager disabled];
    }
}


- (void)setup {
    self.navigationItem.title = @"有多个scrollView";
    
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.backgroundColor = [UIColor yellowColor];
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * 2, scrollView.contentSize.height);
    [self.view addSubview:scrollView];
    
    
    FFUIWindowUsage_SingleScrollViewVC *vc1 = [FFUIWindowUsage_SingleScrollViewVC new];
    vc1.sectionHeaderTitle = @"第一个scrollView";
    vc1.view.frame = CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height);
    [scrollView addSubview:vc1.view];
    [self addChildViewController:vc1];
    
    
    FFUIWindowUsage_SingleScrollViewVC *vc2 = [FFUIWindowUsage_SingleScrollViewVC new];
    vc2.sectionHeaderTitle = @"第二个scrollView";
    vc2.view.frame = CGRectMake(scrollView.frame.size.width, 0, scrollView.frame.size.width , scrollView.frame.size.height);
    [scrollView addSubview:vc2.view];
    [self addChildViewController:vc2];
    
    
    
}





@end

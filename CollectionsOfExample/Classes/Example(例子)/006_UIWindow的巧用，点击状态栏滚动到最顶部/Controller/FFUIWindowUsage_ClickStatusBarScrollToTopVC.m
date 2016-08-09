//
//  FFUIWindowUsage_ClickStatusBarScrollToTopVC.m
//  CollectionsOfExample
//
//  Created by mac on 16/8/9.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFUIWindowUsage_ClickStatusBarScrollToTopVC.h"

//controller
#import "FFUIWindowUsage_SingleScrollViewVC.h"
#import "FFUIWindowUsage_MultipleScrollView.h"



@interface FFUIWindowUsage_ClickStatusBarScrollToTopVC ()

@end

@implementation FFUIWindowUsage_ClickStatusBarScrollToTopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


/** 1、查看只有一个scrollView的效果 */
- (IBAction)singleScrollViewBtnClick {
    FFUIWindowUsage_SingleScrollViewVC *vc = [FFUIWindowUsage_SingleScrollViewVC new];
    vc.sectionHeaderTitle = @"只有一个scrollView";
    [self.navigationController pushViewController:vc animated:YES];
}


/** 2、查看有多个ScrollView不做处理的效果 */
- (IBAction)multipleScrollViewNoDealwithBtn {
    FFUIWindowUsage_MultipleScrollViewVC *vc = [FFUIWindowUsage_MultipleScrollViewVC new];
    vc.dealwithStatusBarClick = NO;
    [self.navigationController pushViewController:vc animated:YES];
}


/** 3、查看有多个ScrollView已经做过处理的效果 */
- (IBAction)multipleScrollViewDealwithBtn {
    FFUIWindowUsage_MultipleScrollViewVC *vc = [FFUIWindowUsage_MultipleScrollViewVC new];
    vc.dealwithStatusBarClick = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


@end

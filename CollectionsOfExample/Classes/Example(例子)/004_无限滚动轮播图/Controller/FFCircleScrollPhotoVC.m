//
//  FFCircleScrollPhotoVC.m
//  CollectionsOfExample
//
//  Created by mac on 16/7/31.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFCircleScrollPhotoVC.h"

//view
#import "FFCircleScrollPhotoView.h"

@interface FFCircleScrollPhotoVC ()

/** 图片名称数组 */
@property (nonatomic, strong) NSArray<NSString *> *imageNamesArr;



@end

@implementation FFCircleScrollPhotoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:138 / 255.0 green:43 / 255.0 blue:226 / 155.0 alpha:1.0];
    self.navigationItem.title = @"无限滚动轮播图";
    
    
    CGRect frame = CGRectMake(0, 150, self.view.bounds.size.width, 250);
    //创建轮播图
    FFCircleScrollPhotoView *view = [FFCircleScrollPhotoView circleScrollPhotoViewWithFrame:frame imageNames:self.imageNamesArr timerInterval:3];
    
    [self.view addSubview:view];
    
}

/***********************************懒加载***********************************/
#pragma mark - 懒加载
- (NSArray<NSString *> *)imageNamesArr {
    if (_imageNamesArr == nil) {
        _imageNamesArr = @[
                           @"advertisement0",
                           @"advertisement1",
                           @"advertisement2",
                           @"advertisement3",
                           @"advertisement4",
                           @"advertisement5",
                           ];
    }
    return _imageNamesArr;
}



@end

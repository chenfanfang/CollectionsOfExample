//
//  FFCircleScrollPhotoView.h
//  CollectionsOfExample
//
//  Created by mac on 16/7/31.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  无限滚动轮播图view
 */
@interface FFCircleScrollPhotoView : UIView

/**
 *  快速实例化一个无限轮播图对象
 *
 *  @param frame         frame
 *  @param imageNames    图片名称数组
 *  @param timerInterval 定时器的多久换一张图
 *
 *  @return 实例化的无限轮播图对象
 */
+ (instancetype)circleScrollPhotoViewWithFrame:(CGRect)frame imageNames:(NSArray *)imageNames timerInterval:(CGFloat)timerInterval;

@end

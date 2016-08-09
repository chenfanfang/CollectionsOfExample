//
//  FFClickStatusBarScrollToTopManager.h
//  CollectionsOfExample
//
//  Created by mac on 16/8/9.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  只要点击头部的状态栏，当前显示在眼前的scrollView就会移动到最初的位置
 */
@interface FFClickStatusBarScrollToTopManager : NSObject

/** 开始生效 */
+ (void)becomeEffective;

/** 失效 */
+ (void)disabled;

@end

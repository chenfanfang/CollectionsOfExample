//
//  FFTableSectionHeaderView.h
//  CollectionsOfExample
//
//  Created by mac on 16/7/17.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  tableView 每一组的headerView
 */
@interface FFTableSectionHeaderView : UIView

/** 标题 */
@property (nonatomic, copy) NSString *title;

- (void)setTitleColor:(UIColor *)titleColor;

@end

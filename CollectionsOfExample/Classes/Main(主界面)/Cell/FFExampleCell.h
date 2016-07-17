//
//  FFExampleCell.h
//  CollectionsOfExample
//
//  Created by mac on 16/7/17.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FFExampleModel;
/**
 *  主页例子的cell
 */
@interface FFExampleCell : UITableViewCell

/** 例子的模型 */
@property (nonatomic, strong) FFExampleModel *exampleModel;

@end

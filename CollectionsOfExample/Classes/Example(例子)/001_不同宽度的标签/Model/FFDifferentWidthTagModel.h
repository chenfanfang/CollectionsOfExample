//
//  FFDifferentWidthTagModel.h
//  CollectionsOfExample
//
//  Created by mac on 16/7/17.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  不同宽度标签的模型
 */
@interface FFDifferentWidthTagModel : NSObject

/** 标签数组 */
@property (nonatomic, strong) NSMutableArray<NSString *> *tagsArrM;

/** 标签数组对应label的frame 数组 */
@property (nonatomic, strong) NSMutableArray<NSValue *> *tagsLabelFramesM;

/** 名字 */
@property (nonatomic, copy) NSString *name;

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;



@end

//
//  FFCustomWithPlaceHolderTextView.h
//  CollectionsOfExample
//
//  Created by mac on 16/9/18.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  自定义带占位文字的TextView
 */
@interface FFCustomWithPlaceHolderTextView : UITextView

/** 占位文本label */
@property (nonatomic, strong) UILabel *placedLabel;

/** 文字变化的block */
@property (nonatomic, copy) void(^textChangedBlock)(NSString *text);

@end

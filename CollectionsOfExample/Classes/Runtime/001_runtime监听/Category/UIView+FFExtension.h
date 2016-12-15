//
//  UIView+FFExtension.h
//  CollectionsOfExample
//
//  Created by chenfanfang on 2016/12/15.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FFExtension)

/** addSubview之后的回调block */
@property (nonatomic, copy) void(^didAddsubView)();

@end

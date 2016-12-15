//
//  FFCustomView.h
//  CollectionsOfExample
//
//  Created by chenfanfang on 2016/12/15.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FFCustomView : UIView

/** addSubView完成的回调block */
@property (nonatomic, copy) void(^didAddSubView)();

@end

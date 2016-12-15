//
//  FFCustomView.m
//  CollectionsOfExample
//
//  Created by chenfanfang on 2016/12/15.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFCustomView.h"

@implementation FFCustomView

- (void)addSubview:(UIView *)view {
    
    [super addSubview:view];
    
    if (self.didAddSubView) {
        self.didAddSubView();
    }
}

@end

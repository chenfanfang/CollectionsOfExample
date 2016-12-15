//
//  FFProgressView.m
//  CollectionsOfExample
//
//  Created by chenfanfang on 2016/12/13.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFProgressView.h"


@interface FFProgressView ()

/** 前景view */
@property (nonatomic, strong) UIView *foregroundView;

@end

@implementation FFProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //背景色
        self.backgroundColor = [UIColor clearColor];
        
        self.foregroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 3)];
        
        //前景色
        self.foregroundView.backgroundColor = FFColor(54, 188, 37);
        [self addSubview:self.foregroundView];
        
    }
    return self;
}

/// 开始加载进度条
- (void)star {
    self.foregroundView.width = 0;
    self.hidden = NO;
    
    [UIView animateWithDuration:10 delay:0 usingSpringWithDamping:1.0f initialSpringVelocity:1.0f options:kNilOptions animations:^{
        self.foregroundView.width = FFScreenW * 0.8;
        
    } completion:nil];
}

/// 结束加载进度条
- (void)end {
    
    
    [UIView animateWithDuration:0.5 animations:^{
        self.foregroundView.width = FFScreenW;
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

@end

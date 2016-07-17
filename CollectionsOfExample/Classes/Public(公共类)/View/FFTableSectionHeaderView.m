//
//  FFTableSectionHeaderView.m
//  CollectionsOfExample
//
//  Created by mac on 16/7/17.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFTableSectionHeaderView.h"

@interface FFTableSectionHeaderView ()

/** 标题label */
@property (nonatomic, weak) UILabel *title_label;

@end

@implementation FFTableSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = FFGrayColor(240);
        
        UILabel *title_label = [[UILabel alloc] init];
        title_label.font = [UIFont systemFontOfSize:14];
        title_label.textColor = FFGrayColor(150);
        
        self.title_label = title_label;
        [self addSubview:title_label];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat labelX = 16;
    self.title_label.frame = CGRectMake(labelX, 0, self.width - labelX, self.height);
    
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.title_label.text = title;
}

- (void)setTitleColor:(UIColor *)titleColor {
    self.title_label.textColor = titleColor;
}

@end

//
//  FFDropDownMenuCustomCell.m
//  CollectionsOfExample
//
//  Created by mac on 16/8/7.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFDropDownMenuCustomCell.h"

//model
#import "FFDropDownMenuModel.h"

@interface FFDropDownMenuCustomCell ()

/** 图片 */
@property (weak, nonatomic) UIImageView *customImageView;

/** 标题 */
@property (weak, nonatomic) UILabel *customTitleLabel;

/** 底部分割线 */
@property (nonatomic, weak) UIView *separaterView;
@end

@implementation FFDropDownMenuCustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //初始化子控件
        UIImageView *customImageView = [[UIImageView alloc] init];
        customImageView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:customImageView];
        self.customImageView = customImageView;
        
        UILabel *customTitleLabel = [[UILabel alloc] init];
        customTitleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:customTitleLabel];
        self.customTitleLabel = customTitleLabel;
        
        UIView *separaterView = [[UIView alloc] init];
        separaterView.backgroundColor = [UIColor colorWithRed:25 / 255.0 green:168 / 255.0 blue:243 / 255.0 alpha:0.3];
        [self addSubview:separaterView];
        self.separaterView = separaterView;
    }
    return self;
}

- (void)layoutSubviews { //这个方法的主要任务是进行子控件frame的赋值
    [super layoutSubviews];
    //frame的赋值
    CGFloat separaterHeight = 1; //底部分割线高度
    
    //图片 customImageView
    CGFloat imageViewMargin = 3;
    CGFloat imageViewH = self.frame.size.height - 2 * imageViewMargin;
    self.customImageView.frame = CGRectMake(10, imageViewMargin, imageViewH, imageViewH);
    
    //标题
    CGFloat labelX = CGRectGetMaxX(self.customImageView.frame) + 10;
    self.customTitleLabel.frame = CGRectMake(labelX, 0, self.frame.size.width - labelX, self.frame.size.height - separaterHeight);
    
    //分割线
    self.separaterView.frame = CGRectMake(0, self.frame.size.height - separaterHeight, self.frame.size.width, separaterHeight);
}


/** 重写setMenuModel---对控件进行赋值 */
- (void)setMenuModel:(id)menuModel {
    _menuModel = menuModel;
    
    FFDropDownMenuModel *realMenuModel = (FFDropDownMenuModel *)menuModel;
    self.customTitleLabel.text = realMenuModel.menuItemTitle;
    //给imageView赋值
    self.customImageView.image = [UIImage imageNamed:realMenuModel.menuItemIconName];
}

@end

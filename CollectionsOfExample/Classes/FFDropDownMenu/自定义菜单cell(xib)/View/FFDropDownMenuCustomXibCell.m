//
//  FFDropDownMenuCustomXibCell.m
//  CollectionsOfExample
//
//  Created by mac on 16/8/7.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFDropDownMenuCustomXibCell.h"

//model
#import "FFDropDownMenuCustomXibCellModel.h"

@interface FFDropDownMenuCustomXibCell ()

/** 图标—-imageView */
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

/** 标题--label */
@property (weak, nonatomic) IBOutlet UILabel *title_Label;

@end

@implementation FFDropDownMenuCustomXibCell

/** 重写setMenuModel---对控件进行赋值 */
- (void)setMenuModel:(id)menuModel {
    _menuModel = menuModel;
    
    //在创建 FFDropDownMenu时候赋值的 menuModelsArray数组里放的是什么模型，下面就转换成什么模型
    FFDropDownMenuCustomXibCellModel *realMenuModel = (FFDropDownMenuCustomXibCellModel *)menuModel;
    
    //对控件进行属性的赋值
    self.iconImageView.image = [UIImage imageNamed:realMenuModel.iconName];
    
    self.title_Label.text = realMenuModel.title;
    
}

@end

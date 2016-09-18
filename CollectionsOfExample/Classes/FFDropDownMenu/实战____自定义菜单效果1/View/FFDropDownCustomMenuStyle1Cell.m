//
//  FFDropDownCustomMenuStyle1Cell.m
//  CollectionsOfExample
//
//  Created by mac on 16/8/12.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFDropDownCustomMenuStyle1Cell.h"

//model
#import "FFDropDownCustomMenuStyle1Model.h"

@interface FFDropDownCustomMenuStyle1Cell ()

@property (weak, nonatomic) IBOutlet UILabel *mainTitle_Label;

@property (weak, nonatomic) IBOutlet UILabel *subTitle_Label;

@end

@implementation FFDropDownCustomMenuStyle1Cell

- (void)setMenuModel:(id)menuModel {
    
    _menuModel = menuModel;
    
    //在这里将模型转成自定义的模型
    FFDropDownCustomMenuStyle1Model *realModel = (FFDropDownCustomMenuStyle1Model *)menuModel;
    
    self.mainTitle_Label.backgroundColor = realModel.mainTitleBgColor;
    
    self.mainTitle_Label.text = realModel.mainTitle;
    
    self.subTitle_Label.text = realModel.subTitle;
}

@end

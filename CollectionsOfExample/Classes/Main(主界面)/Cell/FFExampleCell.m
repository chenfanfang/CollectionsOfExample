//
//  FFExampleCell.m
//  CollectionsOfExample
//
//  Created by mac on 16/7/17.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFExampleCell.h"

//model
#import "FFExampleModel.h"

@interface FFExampleCell ()

/** 例子的名称Label */
@property (weak, nonatomic) IBOutlet UILabel *exampleName_Label;

/** 例子的图片imageView */
@property (weak, nonatomic) IBOutlet UIImageView *exampleImageView;

/** 例子对应的类的名称 */
@property (weak, nonatomic) IBOutlet UILabel *correspondClassName_Label;

@end

@implementation FFExampleCell

- (void)setExampleModel:(FFExampleModel *)exampleModel {
    _exampleModel = exampleModel;
    
    /** 例子的名称Label */
    self.exampleName_Label.text = exampleModel.exampleName;
    
    /** 例子的图片imageView */
    NSString *imageName = exampleModel.exampleImageName.length ? exampleModel.exampleImageName : @"exampleDefaultImg";
    self.exampleImageView.image = [UIImage imageNamed:imageName];
    
    /** 例子对应的类的名称 */
    self.correspondClassName_Label.text = [NSString stringWithFormat:@"例子对应的类:%@",exampleModel.correspondClassName];
}

@end

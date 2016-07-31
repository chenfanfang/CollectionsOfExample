//
//  FFDifferentWidthTagCell.m
//  CollectionsOfExample
//
//  Created by mac on 16/7/17.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFDifferentWidthTagCell.h"

//model
#import "FFDifferentWidthTagModel.h"

@interface FFDifferentWidthTagCell()

/** label的数组 */
@property (nonatomic, strong) NSMutableArray<UILabel *> *labelArrM;

/** 颜色的数组 */
@property (nonatomic, strong) NSMutableArray<UIColor *> *colorArrM;

@end

@implementation FFDifferentWidthTagCell

/***********************************set方法***********************************/
#pragma mark - set方法

- (void)setTagModel:(FFDifferentWidthTagModel *)tagModel {
    
    if (tagModel == _tagModel || tagModel == nil) {
        return;
    }
    
    _tagModel = tagModel;
    
    //移除所有标签label
    for (UILabel *label in self.labelArrM) {
        [label removeFromSuperview];
    }
    
    self.labelArrM = nil;
    
    
    //创建label
    for (int i = 0; i < tagModel.tagsArrM.count; i++) {
        NSValue *frameValue = tagModel.tagsLabelFramesM[i];
        CGRect frame = [frameValue CGRectValue];
        NSString *title = tagModel.tagsArrM[i];
        
        UILabel *label = [UILabel new];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.font = FFFont(17);
        label.frame = frame;
        label.layer.cornerRadius = frame.size.height * 0.5;
        label.clipsToBounds = YES;
        label.text = title;
        
        NSInteger randamNumber = arc4random_uniform((int)self.colorArrM.count);
        label.backgroundColor = self.colorArrM[randamNumber];
        [self addSubview:label];
        [self.labelArrM addObject:label];
    }
}

/***********************************懒加载***********************************/
#pragma mark - 懒加载
- (NSMutableArray<UILabel *> *)labelArrM {
    if (_labelArrM == nil) {
        _labelArrM = [NSMutableArray array];
    }
    return _labelArrM;
}



- (NSMutableArray<UIColor *> *)colorArrM {
    if (_colorArrM == nil) {
        _colorArrM = [NSMutableArray array];
        UIColor *redColor = FFColor(214, 67, 67);
        UIColor *blueColor = FFColor(74, 144, 226);
        UIColor *yellowColor = FFColor(245, 166, 35);
        UIColor *greenColor = FFColor(68, 186, 119);
        UIColor *purpleColor = [UIColor purpleColor];
        [_colorArrM addObject:redColor];
        [_colorArrM addObject:blueColor];
        [_colorArrM addObject:yellowColor];
        [_colorArrM addObject:greenColor];
        [_colorArrM addObject:purpleColor];
    }
    return _colorArrM;
}



@end

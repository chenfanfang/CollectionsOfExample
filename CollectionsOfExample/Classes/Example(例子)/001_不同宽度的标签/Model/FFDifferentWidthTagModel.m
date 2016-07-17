//
//  FFDifferentWidthTagModel.m
//  CollectionsOfExample
//
//  Created by mac on 16/7/17.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFDifferentWidthTagModel.h"

@implementation FFDifferentWidthTagModel

static CGFloat cellMarginY = 16;

- (void)setTagsArrM:(NSMutableArray<NSString *> *)tagsArrM {
    _tagsArrM = tagsArrM;
    
    CGFloat basedWidth = 37;
    CGFloat basedHeight = 30;
    CGFloat marginX = 16;
    CGFloat marginY = cellMarginY;
    
    CGFloat x = marginX;
    CGFloat y = marginY;
    CGFloat w;
    CGFloat h = basedHeight;
    
    for (int i = 0; i < tagsArrM.count; i++) {
        NSString *str = tagsArrM[i];
        CGSize size = [str sizeWithFont:FFFont(17) maxSize:CGSizeMake(FFScreenW, 22)];
        w = basedWidth + size.width;
        CGFloat maxX = x + w;
        if (maxX >= (FFScreenW - marginX)) {
            x = marginX;
            y = y + marginY + basedHeight;
        }
        
        //保存frame到数组中
        CGRect frame = CGRectMake(x, y, w, h);
        NSValue *frameValue = [NSValue valueWithCGRect:frame];
        [self.tagsLabelFramesM addObject:frameValue];
        
        x = x + marginX + w;
    }
    
}

/***********************************懒加载***********************************/
#pragma mark - 懒加载
- (NSMutableArray *)tagsLabelFramesM {
    if (_tagsLabelFramesM == nil) {
        _tagsLabelFramesM = [NSMutableArray array];
    }
    return _tagsLabelFramesM;
}

- (CGFloat)cellHeight {
    NSValue *frameValue = self.tagsLabelFramesM.lastObject;
    CGRect frame = [frameValue CGRectValue];
    CGFloat maxY = CGRectGetMaxY(frame);
    
    return maxY + cellMarginY;
    
}

@end

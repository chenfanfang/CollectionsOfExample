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


/**
 *  重写标签数组，根据字符串的内容，计算出字符串的size,再根据size计算出对应UILabel的frame,
 *  将计算好的frame存放到数组 tagsLabelFramesM中
 *
 */
- (void)setTagsArrM:(NSMutableArray<NSString *> *)tagsArrM {
    _tagsArrM = tagsArrM;
    
    CGFloat basedWidth = 37;
    CGFloat basedHeight = 30;
    //x坐标的边距
    CGFloat marginX = 16;
    //y坐标的边距
    CGFloat marginY = cellMarginY;
    
    CGFloat x = marginX; //x
    CGFloat y = marginY; //y
    CGFloat w; //宽
    CGFloat h = basedHeight; //高
    
    _tagsLabelFramesM = nil; //为了安全起见，将UILabel的frame置空
    for (int i = 0; i < tagsArrM.count; i++) {
        NSString *str = tagsArrM[i]; //取出标签的内容
        
        //FFFont是字体大小的宏 可以下载源码查看
        //FFScreenW是屏幕宽度的宏
        
        //计算标签内容的大小
        CGSize size = [str sizeWithFont:FFFont(17) maxSize:CGSizeMake(FFScreenW, 22)];
        w = basedWidth + size.width;
        CGFloat maxX = x + w;
        
        //maxX 超出这行所允许的范围，另起一行
        if (maxX >= (FFScreenW - marginX)) {
            x = marginX;
            y = y + marginY + basedHeight;
        }
        
        CGRect frame = CGRectMake(x, y, w, h);
        //CGrect是结构体，不能保存到数组，可以将CGrect转换成NSValue
        NSValue *frameValue = [NSValue valueWithCGRect:frame];
        //将转换好的frame存到数组中
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

//cellHeight的get方法
- (CGFloat)cellHeight {
    NSValue *frameValue = self.tagsLabelFramesM.lastObject;
    CGRect frame = [frameValue CGRectValue];
    CGFloat maxY = CGRectGetMaxY(frame);
    return maxY + cellMarginY;
    
}

@end

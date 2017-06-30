//
//  FFDrawStraightLineView.m
//  CollectionsOfExample
//
//  Created by chenfanfang on 2017/6/30.
//  Copyright © 2017年 chenfanfang. All rights reserved.
//

#import "FFDrawStraightLineView.h"

@implementation FFDrawStraightLineView


- (void)drawRect:(CGRect)rect {
    
    //获取跟View相关联的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //绘制路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    //设置起点
    [path moveToPoint:CGPointMake(10, 125)];
    
    //添加一根线到某个点
    [path addLineToPoint:CGPointMake(200, 125)];
    
    //把路径添加到上下文
    CGContextAddPath(ctx,path.CGPath);
    
    //把上下文的内容渲染到View上面.
    CGContextStrokePath(ctx);
}

@end

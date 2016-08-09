//
//  FFSnowflakesFallingView.m
//  CollectionsOfExample
//
//  Created by mac on 16/7/30.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFSnowflakesFallingView.h"

@interface FFSnowflakesFallingView ()

/** 背景图片imageView */
@property (nonatomic, strong) UIImageView *bgImageView;

/** 雪花图片的名称 */
@property (nonatomic, copy) NSString *snowImgName;

@end

@implementation FFSnowflakesFallingView

+ (instancetype)snowflakesFallingViewWithBackgroundImageName:(NSString *)bgImageName snowImageName:(NSString *)snowImageName frame:(CGRect)frame {
    FFSnowflakesFallingView *view = [[FFSnowflakesFallingView alloc] initWithFrame:frame];
    view.bgImageView.image = [UIImage imageNamed:bgImageName];
    view.snowImgName = snowImageName;
    
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        
        //添加背景图片的imageView
        self.bgImageView = [[UIImageView alloc] init];
        self.bgImageView.frame = self.bounds;
        self.bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:self.bgImageView];
    }
    return self;
}


/** 开始下雪 */
- (void)beginSnow {
    //启动定时器，使得一直调用setNeedsDisplay从而被动调用 - (void)drawRect:(CGRect)rect
    //不能手动调用 - (void)drawRect:(CGRect)rect
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(setNeedsDisplay)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)drawRect:(CGRect)rect {
    //控制雪花最多的个数
    if (self.subviews.count > 250) {
        return;
    }
    
    //雪花的宽度
    int width = arc4random() % 20;
    while (width < 5) {
        width = arc4random() % 20;
    }
    //雪花的速度
    int speed = arc4random() % 15;
    while (speed < 5) {
        speed = arc4random() % 15;
    }
    

    //雪花起点y
    int startY = - (arc4random() % 200);
    //雪花起点x
    int startX = arc4random() % (int)[UIScreen mainScreen].bounds.size.width;
    //雪花终点x
    int endX = arc4random() % (int)[UIScreen mainScreen].bounds.size.width;
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.snowImgName]];
    imageView.frame = CGRectMake(startX, startY, width, width);
    
    [self addSubview:imageView];
    
    [UIView animateWithDuration:speed animations:^{
        //设置雪花最终的frame
        imageView.frame = CGRectMake(endX, [UIScreen mainScreen].bounds.size.height, width, width);
        //设置雪花的旋转
        imageView.transform = CGAffineTransformRotate(imageView.transform, M_PI );
        //设置雪花透明度，使得雪花快落地的时候像快消失的一样
        imageView.alpha = 0.3;
    } completion:^(BOOL finished) {
        //完成动画，就将雪花的imageView给移除掉
        [imageView removeFromSuperview];
    }];
    
}


@end

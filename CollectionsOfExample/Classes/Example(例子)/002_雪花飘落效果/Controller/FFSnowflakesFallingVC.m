//
//  FFSnowflakesFallingVC.m
//  CollectionsOfExample
//
//  Created by mac on 16/7/30.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFSnowflakesFallingVC.h"

//view
#import "FFSnowflakesFallingView.h"

@interface FFSnowflakesFallingVC ()

@end

@implementation FFSnowflakesFallingVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"雪花飘落效果";
    
    //创建雪花飘落效果的view
    FFSnowflakesFallingView *snowflakesFallingView = [FFSnowflakesFallingView snowflakesFallingViewWithBackgroundImageName:@"snow_background" snowImageName:@"snow" frame:self.view.bounds];
    [snowflakesFallingView beginSnow];
    
    [self.view addSubview:snowflakesFallingView];
}



@end

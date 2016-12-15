//
//  FFRuntimeObserveController.m
//  CollectionsOfExample
//
//  Created by chenfanfang on 2016/12/13.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFRuntimeObserveController.h"
#import "FFCustomView.h"

@interface FFRuntimeObserveController ()

@end

@implementation FFRuntimeObserveController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //网络请求前开始加载进度条
    [self starProgress];
    
    
    //模拟网络延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //网络请求完成结束进度条的加载
        [self endProgress];
    });
    
    
    //测试添加一个view
    UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:view];
    
    
    /*
    FFCustomView *customView = (FFCustomView *)self.view;
    customView.didAddSubView = ^ {
        NSLog(@"addSubView啦");
        //addSubView之后需要做何处理的代码写在这即可
    };
    
    [self.view addSubview:[UIView new]];
     */
    
}



@end

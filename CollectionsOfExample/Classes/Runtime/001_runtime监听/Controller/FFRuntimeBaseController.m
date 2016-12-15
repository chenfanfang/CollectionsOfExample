//
//  FFRuntimeBaseController.m
//  CollectionsOfExample
//
//  Created by chenfanfang on 2016/12/13.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFRuntimeBaseController.h"

//view
#import "FFProgressView.h"
#import "FFCustomView.h"

//category
#import "UIView+FFExtension.h"

@interface FFRuntimeBaseController ()

/** 网络请求的进度条 */
@property (nonatomic, strong) FFProgressView *progressView;

@end

@implementation FFRuntimeBaseController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.view addSubview:[UIView new]];
}

//=================================================================
//                           懒加载
//=================================================================
#pragma mark - 懒加载

- (FFProgressView *)progressView {
    if (_progressView == nil) {
        _progressView = [FFProgressView new];
        [self.view addSubview:_progressView];
        
        _progressView.frame = CGRectMake(0, 0, FFScreenW, 3);
        
        
        //项目中用的是Masonry，由于写成博客，为了方便简书朋友们的实践，替换成了如上的frame
        /*
         [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.left.right.mas_equalTo(self.view);
         make.height.mas_equalTo(DDFloat_ProgressHeight);
         }];
         */
        
        _progressView.hidden = YES;
        
        __weak typeof(self) weakSelf = self;
        __weak typeof(_progressView) weakProgressView = _progressView;
        
        self.view.didAddsubView = ^ {
            
            NSLog(@"%@的view添加了新的控件",NSStringFromClass([weakSelf class]));
            //将进度条挪到最前面
            [weakSelf.view bringSubviewToFront:weakProgressView];
        };
        
    }
    
    return _progressView;
}



//=================================================================
//                           进度条
//=================================================================
#pragma mark - 进度条

- (void)starProgress {
    
    [self.progressView star];
}

- (void)endProgress {
    
    [self.progressView end];
}


@end

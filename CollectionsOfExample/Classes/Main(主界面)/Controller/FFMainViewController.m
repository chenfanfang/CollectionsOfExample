//
//  FFMainViewController.m
//  CollectionsOfExample
//
//  Created by mac on 16/7/17.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFMainViewController.h"

@interface FFMainViewController ()

/** 数据源数组 */
@property (nonatomic, strong) NSArray *dataSourceArr;

@end

@implementation FFMainViewController

/***********************************生命周期***********************************/
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    
}

/***********************************初始化***********************************/
#pragma mark - 初始化
- (void)setup {
    self.view.backgroundColor = FFColor(240, 240, 240);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //注册cell
}

/***********************************UITableViewDataSource***********************************/
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UITableViewCell new];
}


@end

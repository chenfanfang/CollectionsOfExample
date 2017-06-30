//
//  FFCustomViewController.m
//  CollectionsOfExample
//
//  Created by chenfanfang on 2017/6/30.
//  Copyright © 2017年 chenfanfang. All rights reserved.
//

#import "FFCustomViewController.h"

//cell
#import "FFCustomViewCell.h"

@interface FFCustomViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation FFCustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

static NSString *const FFCustomViewCellID = @"FFCustomViewCellID";
- (void)setup {
    self.navigationItem.title = @"自定义控件(绘图)";
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = self.view.bounds;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:tableView];
    
    //注册cell
    FFRegisterCellClass(tableView, FFCustomViewCell, FFCustomViewCellID);
}


//=================================================================
//                       UITableViewDataSource
//=================================================================
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [UITableViewCell new];
}


//=================================================================
//                       UITableViewDelegate
//=================================================================
#pragma mark - UITableViewDelegate

@end

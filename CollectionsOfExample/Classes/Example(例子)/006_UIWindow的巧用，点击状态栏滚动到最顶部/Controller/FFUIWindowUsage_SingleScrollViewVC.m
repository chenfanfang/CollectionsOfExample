//
//  FFUIWindowUsage_SingleScrollView.m
//  CollectionsOfExample
//
//  Created by mac on 16/8/9.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFUIWindowUsage_SingleScrollViewVC.h"

@interface FFUIWindowUsage_SingleScrollViewVC ()<UITableViewDataSource>

@end

@implementation FFUIWindowUsage_SingleScrollViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}


static NSString *const UITableViewCellID = @"UITableViewCell";
- (void)setup {
    self.navigationItem.title = @"只有一个scrollView的控制器";
    
    //创建UITableView  (tableView是scrollView的子类)
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.dataSource = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:UITableViewCellID];
    [self.view addSubview:tableView];
}

/***********************************UITableViewDataSource***********************************/
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UITableViewCellID];
    cell.textLabel.text = [NSString stringWithFormat:@"-----------%zd",indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sectionHeaderTitle;
}

@end

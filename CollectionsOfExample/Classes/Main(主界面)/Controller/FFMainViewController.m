//
//  FFMainViewController.m
//  CollectionsOfExample
//
//  Created by mac on 16/7/17.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFMainViewController.h"

//controller
#import "FFDifferentWidthTagVC.h"

//model
#import "FFExampleModel.h"

//cell
#import "FFExampleCell.h"

//view


@interface FFMainViewController ()

/** 数据源数组 */
@property (nonatomic, strong) NSArray<FFExampleModel *> *dataSourceArr;

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

static NSString *const FFExampleCellID = @"FFExampleCell";

- (void)setup {
    self.view.backgroundColor = FFColor(240, 240, 240);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //注册cell
    FFRegisterCell(self.tableView, FFExampleCell, FFExampleCellID);
}

/***********************************懒加载***********************************/
#pragma mark - 懒加载
- (NSArray *)dataSourceArr {
    if (_dataSourceArr == nil) {
        //example_001(不同宽度的标签)
        FFExampleModel *model1 = [FFExampleModel exampleModelWithExampleName:@"不同宽度的标签" exampleImageName:@"" correspondClassName:@"FFDifferentWidthTagVC"];
        
        _dataSourceArr = @[
                           model1
                           ];
    }
    return _dataSourceArr;
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
    FFExampleCell *cell = [tableView dequeueReusableCellWithIdentifier:FFExampleCellID];
    cell.exampleModel = self.dataSourceArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


/***********************************UITableViewDelegate***********************************/
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FFExampleModel *exampleModel = self.dataSourceArr[indexPath.row];
//    UIViewController *vc = [[UIViewController alloc] initWithNibName:exampleModel.correspondClassName bundle:nil];
    FFDifferentWidthTagVC *vc = [FFDifferentWidthTagVC new];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

@end

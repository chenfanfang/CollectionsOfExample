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
#import "FFVoicePlayTextController.h"
#import "FFSnowflakesFallingVC.h"

//model
#import "FFExampleModel.h"

//cell
#import "FFExampleCell.h"

//view


@interface FFMainViewController ()

/** 数据源数组 */
@property (nonatomic, strong) NSArray<NSArray *> *dataSourceArr;

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
        /**************************小例子**************************/
        
        //example_001(不同宽度的标签)
        FFExampleModel *model1 = [FFExampleModel exampleModelWithExampleName:@"不同宽度的标签" exampleImageName:@"" correspondClassName:@"FFDifferentWidthTagVC"];
        
        //example_002(雪花飘落效果)
        FFExampleModel *model2 = [FFExampleModel exampleModelWithExampleName:@"雪花飘落效果" exampleImageName:@"" correspondClassName:@"FFSnowflakesFallingVC"];
        
        NSArray *exampleArr = @[
                               model1,
                               model2
                               ];
        
        
        
        
        /**************************AVFoundation******************/
        
        FFExampleModel *afModel1 = [FFExampleModel exampleModelWithExampleName:@"语音播放文字内容" exampleImageName:@"" correspondClassName:@"FFVoicePlayTextController"];
        
        NSArray *avFoundationArr = @[
                                     afModel1
                                     ];
        
        
        //----------------
        //----------------
        _dataSourceArr = @[
                           exampleArr,
                           avFoundationArr
                           ];
        
    }
    return _dataSourceArr;
}

/***********************************UITableViewDataSource***********************************/
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSourceArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArr[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FFExampleCell *cell = [tableView dequeueReusableCellWithIdentifier:FFExampleCellID];
    cell.exampleModel = self.dataSourceArr[indexPath.section][indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


/***********************************UITableViewDelegate***********************************/
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) { //例子
        switch (indexPath.row) {
            case 0: //不同宽度的标签
            {
                FFDifferentWidthTagVC *vc = [FFDifferentWidthTagVC new];
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            case 1: //雪花飘落效果
            {
                FFSnowflakesFallingVC *vc = [FFSnowflakesFallingVC new];
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
                
            default:
                break;
        }
        
        
    }
    
    
    else if (indexPath.section == 1) {//AVFoundation
        switch (indexPath.row) {
            case 0: //语音播放文字内容
            {
                FFVoicePlayTextController *vc = [FFVoicePlayTextController viewControllerFromNib];
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            default:
                break;
        }
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    FFTableSectionHeaderView *headerView = [FFTableSectionHeaderView new];
    if (section == 0) {
        headerView.title = @"例子";
    }
    
    else if (section == 1) {
        headerView.title = @"AV Foundation";
    }
    
    return headerView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}


@end

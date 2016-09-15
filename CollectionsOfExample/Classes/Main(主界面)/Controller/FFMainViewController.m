//
//  FFMainViewController.m
//  CollectionsOfExample
//
//  Created by mac on 16/7/17.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFMainViewController.h"

//Controller

//------------------
//     例子
//------------------

#import "FFDifferentWidthTagVC.h"//不同宽度的标签
#import "FFSnowflakesFallingVC.h"//雪花飘落效果控制器
#import "FFRegulationExpressDemoVC.h"//正则表达式demo控制器
#import "FFCircleScrollPhotoVC.h" //无限滚动轮播图控制器
#import "FFUIWindowUsage_ClickStatusBarScrollToTopVC.h" //点击状态栏、scrollView自动滚动到顶部

//------------------
//    AVFoundation
//------------------
#import "FFVoicePlayTextController.h"//语音播放文字内容



//------------------
//  FFDropDownMenu
//------------------
#import "FFDropDownMenuBaseUsageVC.h"//FFDropDownMenu基本用法控制器
#import "FFDropDownMenuCustomXibCellVC.h" //自定义菜单cell (xib类型) 控制器
#import "FFDropDownMenuCustomCellVC.h" //自定义菜单cell (非xib类型) 控制器
#import "FFDropDownCustomMenuStyle1VC.h" // 实战----自定义菜单样式1



//model
#import "FFExampleModel.h"
//cell
#import "FFExampleCell.h"


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
        
        
        //example_003(正则表达式demo)
        FFExampleModel *model3 = [FFExampleModel exampleModelWithExampleName:@"正则表达式demo" exampleImageName:@"" correspondClassName:@"FFRegulationExpressDemoVC"];
        
        //example_004(无限滚动轮播图)
        FFExampleModel *model4 = [FFExampleModel exampleModelWithExampleName:@"无限滚动轮播图" exampleImageName:@"" correspondClassName:@"FFCircleScrollPhotoVC"];
        
        
        //example_006(无限滚动轮播图)
        FFExampleModel *model6 = [FFExampleModel exampleModelWithExampleName:@"UIWindow巧用--点击状态栏滚动到顶部" exampleImageName:@"" correspondClassName:@"FFUIWindowUsage_ClickStatusBarScrollToTopVC"];
        
        
        NSArray *exampleArr = @[
                               model1,
                               model2,
                               model3,
                               model4,
                               model6
                               ];
        
        
        /**************************AVFoundation******************/
        
        FFExampleModel *afModel1 = [FFExampleModel exampleModelWithExampleName:@"语音播放文字内容" exampleImageName:@"" correspondClassName:@"FFVoicePlayTextController"];
        
        NSArray *avFoundationArr = @[
                                     afModel1
                                     ];
        
        
        
        /***********************FFDropDownMenu******************/
        
        FFExampleModel *menuModel1 = [FFExampleModel exampleModelWithExampleName:@"教程----下拉菜单的基本使用" exampleImageName:@"" correspondClassName:@"FFDropDownMenuBaseUsageVC"];
        
        FFExampleModel *menuModel2 = [FFExampleModel exampleModelWithExampleName:@"教程----自定义菜单cell(xib)" exampleImageName:@"" correspondClassName:@"FFDropDownMenuCustomXibCellVC"];
        
        FFExampleModel *menuModel3 = [FFExampleModel exampleModelWithExampleName:@"教程----自定义菜单cell(非xib)" exampleImageName:@"" correspondClassName:@"FFDropDownMenuCustomCellVC"];
        
        FFExampleModel *menuModel4 = [FFExampleModel exampleModelWithExampleName:@"实战----自定义菜单样式1" exampleImageName:@"" correspondClassName:@"FFDropDownCustomMenuStyle1VC"];
        

        NSArray *menuArr = @[
                             menuModel1,
                             menuModel2,
                             menuModel3,
                             menuModel4
                             ];
        
        
        //----------------
        //----------------
        _dataSourceArr = @[
                           exampleArr,
                           avFoundationArr,
                           menuArr
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
            case 2: //正则表达式demo
            {
                FFRegulationExpressDemoVC *vc = [FFRegulationExpressDemoVC new];
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            case 3: //无限滚动轮播图
            {
                FFCircleScrollPhotoVC *vc = [FFCircleScrollPhotoVC new];
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
                
            case 4: //点击状态栏、scrollView自动滚动到顶部
            {
                FFUIWindowUsage_ClickStatusBarScrollToTopVC *vc = [FFUIWindowUsage_ClickStatusBarScrollToTopVC new];
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
    
    else if (indexPath.section == 2) {//FFDropDownMenu下拉菜单的使用
        switch (indexPath.row) {
            case 0: //FFDropDownMenu基本用法
            {
                FFDropDownMenuBaseUsageVC *vc = [FFDropDownMenuBaseUsageVC new];
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
                
            case 1: //FFDropDownMenu自定义菜单cell(xib)
            {
                FFDropDownMenuCustomXibCellVC *vc = [FFDropDownMenuCustomXibCellVC new];
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
                
            case 2: //FFDropDownMenu自定义菜单cell(非xib)
            {
                FFDropDownMenuCustomCellVC *vc = [FFDropDownMenuCustomCellVC new];
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            case 3: //FFDropDownMenu自定义菜单cell(非xib)
            {
                FFDropDownCustomMenuStyle1VC *vc = [FFDropDownCustomMenuStyle1VC new];
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
    
    else if (section == 2) {
        headerView.title = @"FFDropDownMenu下拉菜单的使用";
    }
    
    return headerView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}


@end

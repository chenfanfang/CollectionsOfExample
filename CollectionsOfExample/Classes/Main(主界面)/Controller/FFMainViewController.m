//
//  FFMainViewController.m
//  CollectionsOfExample
//
//  Created by mac on 16/7/17.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFMainViewController.h"

//Controller

//=================
//      例子
//=================

#import "FFDifferentWidthTagVC.h"               //不同宽度的标签
#import "FFSnowflakesFallingVC.h"               //雪花飘落效果控制器
#import "FFRegulationExpressDemoVC.h"           //正则表达式demo控制器
#import "FFCircleScrollPhotoVC.h"               //无限滚动轮播图控制器
#import "FFUIWindowUsage_ClickStatusBarScrollToTopVC.h" //点击状态栏、scrollView自动滚动到顶部

//=================
//   AVFoundation
//=================
#import "FFVoicePlayTextController.h"           //语音播放文字内容



//=================
//  FFDropDownMenu
//=================
#import "FFDropDownMenuBaseUsageVC.h"           //FFDropDownMenu基本用法控制器
#import "FFDropDownMenuCustomXibCellVC.h"       //自定义菜单cell (xib类型) 控制器
#import "FFDropDownMenuCustomCellVC.h"          //自定义菜单cell (非xib类型) 控制器
#import "FFDropDownCustomMenuStyle1VC.h"        // 实战----自定义菜单样式1


//=================
//  CoreBluetooth
//=================
#import "FFCentralManagerModeController.h"      //CoreBlueTooth 中心模式的基本用法
#import "FFPeripheralManagerModeController.h"   //CoreBlueTooth 外设模式的基本用法
#import "FFCoreBluetoothChatController.h"       //聊天(CoreBluetooth实战1)


//=================
//   Runtime
//=================
#import "FFRuntimeObserveController.h"

//=================
//   自定义控件(绘图)
//=================
#import "FFCustomViewController.h"


//model
#import "FFExampleModel.h"
//cell
#import "FFExampleCell.h"



@interface FFMainViewController ()

/** 数据源数组 */
@property (nonatomic, strong) NSArray<NSArray *> *dataSourceArr;

/** section Title数组 */
@property (nonatomic, strong) NSMutableArray<NSString *> *sectionTitleArrM;

@end

@implementation FFMainViewController


//=================================================================
//                           生命周期
//=================================================================
#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    
}

//=================================================================
//                              初始化
//=================================================================
#pragma mark - 初始化

static NSString *const FFExampleCellID = @"FFExampleCell";

- (void)setup {
    
    
    self.view.backgroundColor = FFColor(240, 240, 240);
    
    //注册cell
    FFRegisterCell(self.tableView, FFExampleCell, FFExampleCellID);
}

//=================================================================
//                           懒加载
//=================================================================
#pragma mark - 懒加载

- (NSMutableArray<NSString *> *)sectionTitleArrM {
    if (_sectionTitleArrM == nil) {
        _sectionTitleArrM = [NSMutableArray array];
    }
    return _sectionTitleArrM;
}

- (NSArray *)dataSourceArr {
    
    if (_dataSourceArr == nil) {
        
        
       
        
        
        //=================
        //      小例子
        //=================
        [self.sectionTitleArrM addObject:@"例子"];
        
        //example_001(不同宽度的标签)
        FFExampleModel *model1 = [FFExampleModel exampleModelWithExampleName:@"不同宽度的标签" exampleImageName:@"" correspondClassName:@"FFDifferentWidthTagVC"];
        
        //example_002(雪花飘落效果)
        FFExampleModel *model2 = [FFExampleModel exampleModelWithExampleName:@"雪花飘落效果" exampleImageName:@"" correspondClassName:@"FFSnowflakesFallingVC"];
        
        
        //example_003(正则表达式demo)
        FFExampleModel *model3 = [FFExampleModel exampleModelWithExampleName:@"正则表达式demo" exampleImageName:@"" correspondClassName:@"FFRegulationExpressDemoVC"];
        
        //example_004(无限滚动轮播图)
        FFExampleModel *model4 = [FFExampleModel exampleModelWithExampleName:@"无限滚动轮播图" exampleImageName:@"" correspondClassName:@"FFCircleScrollPhotoVC"];
        
        
        //example_006(UIWindow巧用--点击状态栏滚动到顶部)
        FFExampleModel *model6 = [FFExampleModel exampleModelWithExampleName:@"UIWindow巧用--点击状态栏滚动到顶部" exampleImageName:@"" correspondClassName:@"FFUIWindowUsage_ClickStatusBarScrollToTopVC"];
        
        
        NSArray *exampleArr = @[
                               model1,
                               model2,
                               model3,
                               model4,
                               model6
                               ];
        
        
        //=================
        //   AVFoundation
        //=================
        [self.sectionTitleArrM addObject:@"AV Foundation"];
        
        
        FFExampleModel *afModel1 = [FFExampleModel exampleModelWithExampleName:@"语音播放文字内容" exampleImageName:@"" correspondClassName:@"FFVoicePlayTextController"];
        
        NSArray *avFoundationArr = @[
                                     afModel1
                                     ];
        
        
        
        //==================
        //   FFDropDownMenu
        //==================
        [self.sectionTitleArrM addObject:@"FFDropDownMenu下拉菜单的使用"];
        
        
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
        
        
        //==================
        //   CoreBluetooth
        //==================
        [self.sectionTitleArrM addObject:@"CoreBluetooth"];
        
        FFExampleModel *coreBluetoothModel1 = [FFExampleModel exampleModelWithExampleName:@"中心模式教程(CBCentralManager)" exampleImageName:@"" correspondClassName:@"FFPeripheralManagerModeController"];
        
        
        FFExampleModel *coreBluetoothModel2 = [FFExampleModel exampleModelWithExampleName:@"外设模式教程(CBPeripheralManager)" exampleImageName:@"" correspondClassName:@"FFPeripheralManagerModeController"];
        
        
        FFExampleModel *coreBluetoothModel3 = [FFExampleModel exampleModelWithExampleName:@"聊天(CoreBluetooth实战1)" exampleImageName:@"" correspondClassName:@"FFCoreBluetoothChatController"];
        
        NSArray *coreBluetoothArray = @[
                                        coreBluetoothModel1,
                                        coreBluetoothModel2,
                                        coreBluetoothModel3
                                        ];
        
        
        
        //==================
        //    Runtime
        //==================
        
        
        [self.sectionTitleArrM addObject:@"Runtime"];
        
        FFExampleModel *runtimeModel1 = [FFExampleModel exampleModelWithExampleName:@"runtime----利用runtime监听任何方法的调用" exampleImageName:@"" correspondClassName:@"FFRuntimeObserveController"];
        
        NSArray *runtimeArray = @[
                                  runtimeModel1
                                  ];
        
        //==================
        //    自定义控件(绘图)
        //==================
        [self.sectionTitleArrM addObject:@"自定义控件(绘图)"];
        
        FFExampleModel *customViewModel1 = [FFExampleModel exampleModelWithExampleName:@"自定义控件(绘图)" exampleImageName:@"" correspondClassName:@"FFCustomViewController"];
        
        NSArray *customViewArray = @[
                                  customViewModel1
                                  ];
        
        
        //=================
        //    数据源数组
        //=================
        _dataSourceArr = @[
                           exampleArr,
                           avFoundationArr,
                           menuArr,
                           coreBluetoothArray,
                           runtimeArray,
                           customViewArray
                           ];
        
    }
    return _dataSourceArr;
}

//=================================================================
//                       UITableViewDataSource
//=================================================================
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


//=================================================================
//                       UITableViewDelegate
//=================================================================
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FFExampleModel *model = self.dataSourceArr[indexPath.section][indexPath.row];
    Class vcClass = NSClassFromString(model.correspondClassName);
    UIViewController *vc = [[vcClass alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    FFTableSectionHeaderView *headerView = [FFTableSectionHeaderView new];
    headerView.title = self.sectionTitleArrM[section];
    
    return headerView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}


@end

//
//  FFCoreBluetoothChatController.m
//  CollectionsOfExample
//
//  Created by mac on 16/9/18.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFCoreBluetoothChatController.h"

//contoller
#import "FFCoreBluetoothChatCentralVC.h"
//#import "FFCoreBluetoothChatCentralVC.h"

@interface FFCoreBluetoothChatController ()

@end

@implementation FFCoreBluetoothChatController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


/** 中心模式按钮的点击 */
- (IBAction)centralModeBtnClick {
    FFCoreBluetoothChatCentralVC *vc = [FFCoreBluetoothChatCentralVC new];
    [self.navigationController pushViewController:vc animated:YES];
}


/** 外设模式按钮的点击 */
- (IBAction)peripheralModeBtnClick {
}


@end

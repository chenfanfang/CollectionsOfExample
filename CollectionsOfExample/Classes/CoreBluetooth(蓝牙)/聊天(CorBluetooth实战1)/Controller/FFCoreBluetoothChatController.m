//
//  FFCoreBluetoothChatController.m
//  CollectionsOfExample
//
//  Created by mac on 16/9/18.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFCoreBluetoothChatController.h"
#import "NSUserDefaults+DemoSettings.h"

//contoller
#import "CBCentralManagerController.h"
#import "CBPeripheralManagerController.h"

@interface FFCoreBluetoothChatController ()

@end

@implementation FFCoreBluetoothChatController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


/** 中心模式按钮的点击 */
- (IBAction)centralModeBtnClick {
    CBCentralManagerController *vc = [CBCentralManagerController new];
    [self.navigationController pushViewController:vc animated:YES];
}


/** 外设模式按钮的点击 */
- (IBAction)peripheralModeBtnClick {
    CBPeripheralManagerController *vc = [CBPeripheralManagerController new];
    [self.navigationController pushViewController:vc animated:YES];
}


//=================================================================
//                           other
//=================================================================
#pragma mark - other

+ (void)load {
    // Load our default settings
    [NSUserDefaults saveIncomingAvatarSetting:YES];
    [NSUserDefaults saveOutgoingAvatarSetting:YES];
}

@end

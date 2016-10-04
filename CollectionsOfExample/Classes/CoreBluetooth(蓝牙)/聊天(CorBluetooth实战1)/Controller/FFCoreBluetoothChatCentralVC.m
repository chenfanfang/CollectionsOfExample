//
//  FFCoreBluetoothChatCentralVC.m
//  CollectionsOfExample
//
//  Created by mac on 16/9/18.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFCoreBluetoothChatCentralVC.h"

#define serviceUUIDStr @"9DDC41F1-0843-4A57-A723-DCD3009C0445"
#define characteristicUUIDStr @"0E3EC75A-CFEE-4F73-888F-FF53F7B11AE8"

//view
#import "FFCustomWithPlaceHolderTextView.h"

//model
#import "FFChatMessageModel.h"

//cell
#import "FFChatReceiveMessageCell.h"
#import "FFChatSendMessageCell.h"

//third
#import "UITableView+FDTemplateLayoutCell.h"

//system
#import <CoreBluetooth/CoreBluetooth.h>

@interface FFCoreBluetoothChatCentralVC ()<UITableViewDataSource, UITableViewDelegate, CBCentralManagerDelegate, CBPeripheralDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** 底部view的底部约束 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewBottomConstraint;

/** 文本输入框 */
@property (weak, nonatomic) IBOutlet FFCustomWithPlaceHolderTextView *textView;

/** 数据源数组 */
@property (nonatomic, strong) NSMutableArray *dataSourceArrM;

/** 蓝牙中心管理者 */
@property (nonatomic, strong) CBCentralManager *centralManager;

/** 连接的外设 */
@property (nonatomic, strong) CBPeripheral *peripheral;

/** 连接的外设的特征 */
@property (nonatomic, strong) CBCharacteristic *characteristic;

/** 接收到的数据 */
@property (nonatomic, strong) NSMutableData *receiveDataM;


@end

@implementation FFCoreBluetoothChatCentralVC

//=================================================================
//                           生命周期
//=================================================================
#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    
    [self setupNotification];
    
    [self setupCoreBluetooth];
    
}

//=================================================================
//                           懒加载
//=================================================================
#pragma mark - 懒加载

- (NSMutableArray *)dataSourceArrM {
    if (_dataSourceArrM == nil) {
        _dataSourceArrM = [NSMutableArray array];
    }
    return _dataSourceArrM;
}

- (NSMutableData *)receiveDataM {
    if (_receiveDataM == nil) {
        _receiveDataM = [NSMutableData data];
    }
    return _receiveDataM;
}

//=================================================================
//                              初始化
//=================================================================
#pragma mark - 初始化

static NSString *const FFChatSendMessageCellID = @"FFChatSendMessageCell";

- (void)setup {
    
    self.navigationItem.title = @"与外设模式聊天";
    
    self.textView.placedLabel.text = @"请输入聊天内容";
    
    //tableView
    self.tableView.backgroundColor = FFColor(243, 243, 243);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    FFRegisterCell(self.tableView, FFChatSendMessageCell, FFChatSendMessageCellID);
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

/** 初始化键盘的通知的监听 */
- (void)setupNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillApper:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDisapper:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)setupCoreBluetooth {
    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
}

//=================================================================
//                            keyboard
//=================================================================
#pragma mark - keyboard

- (void)keyboardWillApper:(NSNotification *)note {
    NSDictionary *userInfo = note.userInfo;
    CGFloat animateDuration = [userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    CGRect keyboardFrame = [userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:animateDuration animations:^{
        weakSelf.bottomViewBottomConstraint.constant = keyboardFrame.size.height;
    }];
}

- (void)keyboardWillDisapper:(NSNotification *)note {
    NSDictionary *userInfo = note.userInfo;
    CGFloat animateDuration = [userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];

    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:animateDuration animations:^{
        weakSelf.bottomViewBottomConstraint.constant = 0;
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

//=================================================================
//                       UITableViewDataSource
//=================================================================
#pragma mark - UITableViewDataSource 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArrM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FFChatSendMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:FFChatSendMessageCellID];
    cell.messageModel = self.dataSourceArrM[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//=================================================================
//                       UITableViewDelegate
//=================================================================
#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:FFChatSendMessageCellID configuration:^(FFChatSendMessageCell *cell) {
        cell.messageModel = self.dataSourceArrM[indexPath.row];
    }];
}



//=================================================================
//                       CBCentralManagerDelegate
//=================================================================
#pragma mark - CBCentralManagerDelegate

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    //蓝牙是否可用的标记
    BOOL coreBluetoothEnable = NO;
    
    switch (central.state) {
        case CBCentralManagerStateUnknown://初始的时候是未知的（刚刚创建的时候）
            NSLog(@"未知状态");
            break;
        case CBCentralManagerStateResetting://正在重置状态
            NSLog(@"正在重置状态");
            break;
        case CBCentralManagerStateUnsupported://设备不支持的状态
            NSLog(@"该设备不支持蓝牙4.0");
            break;
        case CBCentralManagerStateUnauthorized://设备未授权状态
            NSLog(@"请去设置中打开蓝牙权限");
            break;
        case CBCentralManagerStatePoweredOff://设备关闭状态
            NSLog(@"您关闭了蓝牙,请打开蓝牙");
            break;
        case CBCentralManagerStatePoweredOn://设备开启状态 -- 可用状态
            coreBluetoothEnable = YES;
            break;
            
        default:
            break;
    }
    if (coreBluetoothEnable == YES) {
        //扫描外设
        CBUUID *serviceUUID = [CBUUID UUIDWithString:serviceUUIDStr];
        NSArray <CBUUID *> *services = @[serviceUUID];
        [central scanForPeripheralsWithServices:services options:nil];
    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI {
    
    self.peripheral = peripheral;
    [central connectPeripheral:peripheral options:nil];
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    peripheral.delegate = self;
    CBUUID *serviceUUID = [CBUUID UUIDWithString:serviceUUIDStr];
    NSArray <CBUUID *> *services = @[serviceUUID];
    [peripheral discoverServices:services];
    
}


//=================================================================
//                       CBPeripheralDelegate
//=================================================================
#pragma mark - CBPeripheralDelegate

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    
    if (error) {
        NSLog(@"didDiscoverServices--Error:%@",error.localizedDescription);
        return;
    }
    
    for (CBService *service in peripheral.services) {
        if ([service.UUID.UUIDString isEqualToString:serviceUUIDStr]) {
            CBUUID *characteristicUUID = [CBUUID UUIDWithString:characteristicUUIDStr];
            NSArray *characteristicArray = @[characteristicUUID];
            [peripheral discoverCharacteristics:characteristicArray forService:service];
        }
    }
    
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    if (error) {
        NSLog(@"didDiscoverCharacteristicsForService--Error:%@",error.localizedDescription);
        return;
    }
    
    for (CBCharacteristic *characteristic in service.characteristics) {
        if ([characteristic.UUID.UUIDString isEqualToString:characteristicUUIDStr]) {
            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
        }
    }
}


- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    if (error) {
        NSLog(@"didUpdateValueForCharacteristic--Error:%@",error.localizedDescription);
        return;
    }
    
    NSString *receiveMessage = [[NSString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding];
    
    //接收消息结束
    if ([receiveMessage isEqualToString:@"END"]) {
        
        NSString *totalReceiveMessage = [[NSString alloc] initWithData:self.receiveDataM encoding:NSUTF8StringEncoding];
        FFChatMessageModel *model = [FFChatMessageModel new];
        model.message = totalReceiveMessage;
        model.messageDirectionType = FFMessageDirectionTypeReceive;
        model.headerImageName = @"";
        
        [self.dataSourceArrM addObject:model];
        [self.tableView reloadData];
    }
    
    //接收消息还没结束
    else {
        [self.receiveDataM appendData:characteristic.value];
    }
}





@end

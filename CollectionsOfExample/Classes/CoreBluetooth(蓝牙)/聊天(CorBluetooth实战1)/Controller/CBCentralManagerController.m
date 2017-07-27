//
//  CBCentralManagerController.m
//  CoreBluetooth_Demo
//
//  Created by mac on 16/9/9.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "CBCentralManagerController.h"

#import <CoreBluetooth/CoreBluetooth.h>

//可通过终端命令 uuidgen来生成
#define TRANSFER_SERVICE_UUID           @"D63D44E5-E798-4EA5-A1C0-3F9EEEC2CDEB"
#define TRANSFER_CHARACTERISTIC_UUID    @"1652CAD2-6B0D-4D34-96A0-75058E606A98"

@interface CBCentralManagerController ()<CBCentralManagerDelegate, CBPeripheralDelegate>

/** 中心管理者 */
@property (strong, nonatomic) CBCentralManager *centralManager;

/** 发现的外设 */
@property (strong, nonatomic) CBPeripheral *discoveredPeripheral;

/** 当前的特征 */
@property (nonatomic, strong) CBCharacteristic *characteristic;

/** 数据 */
@property (strong, nonatomic) NSMutableData *data;

@end

@implementation CBCentralManagerController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"中心模式";
    
    // 设置CBCentralManager
    _centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    
    // 保存接收数据
    _data = [[NSMutableData alloc] init];
    
    //菊花转动
    [self.activityIndicatorView startAnimating];
}



- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.centralManager stopScan];
    
    [self cleanup];
    
    [self.activityIndicatorView stopAnimating];
    
    self.centralManager = nil;
    
    NSLog(@"扫描停止");
    
    
}

- (void)dealloc {
    
    NSLog(@"%@控制器销毁成功，无内存泄漏",NSStringFromClass([self class]));
}

//=================================================================
//                    CBCentralManagerDelegate
//=================================================================
#pragma mark - CBCentralManagerDelegate


//设置成功回调方法
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    
    if (central.state != CBCentralManagerStatePoweredOn) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请打开您的蓝牙" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }

    //开始扫描
    [self scan];
    
}


/** 通过制定的128位的UUID，扫描外设
 */
- (void)scan {
    
    [self.activityIndicatorView startAnimating];
    //扫描
    [self.centralManager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID]] options:@{ CBCentralManagerScanOptionAllowDuplicatesKey : @YES }];
    NSLog(@"正在扫描外设");

}

/** 停止扫描
 */
- (void)stop {
    [self.activityIndicatorView stopAnimating];
    [self.centralManager stopScan];
    
    NSLog(@"停止扫描外设");
    
}

//扫描成功调用此方法
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    
    NSLog(@"发现外设 %@ at %@", peripheral.name, RSSI);
    
    if (self.discoveredPeripheral != peripheral) {
        self.discoveredPeripheral = peripheral;
        
        NSLog(@"连接外设 %@", peripheral);
        [self.centralManager connectPeripheral:peripheral options:nil];
    }
}


- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    
    NSLog(@"连接失败 %@. (%@)", peripheral, [error localizedDescription]);
    [self cleanup];
}

//连接外设成功
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    
    [self stop];
    NSLog(@"停止扫描外设");
    
    [self.data setLength:0];//重置data属性
    
    peripheral.delegate = self;//设置外设对象的委托为self
    
    NSLog(@"外设已连接,正在搜寻服务...");
    [peripheral discoverServices:@[[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID]]];
}



//=================================================================
//                       CBPeripheralDelegate
//=================================================================
#pragma mark - CBPeripheralDelegate

//发现服务成功
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    
    if (error) {
        NSLog(@"Error discovering services: %@", [error localizedDescription]);
        [self cleanup];
        return;
    }
    NSLog(@"成功发现服务，正在搜寻特征...");
    
    // 发现特征
    for (CBService *service in peripheral.services) {
        [peripheral discoverCharacteristics:@[[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]] forService:service];
    }
}

//发现特征成功
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    
    if (error) {
        NSLog(@"发现特征错误: %@", [error localizedDescription]);
        [self cleanup];
        return;
    }
    NSLog(@"成功发现特征，正在预定特征...");
    
    for (CBCharacteristic *characteristic in service.characteristics) {
        
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]]) {
            // 预定特征
            [peripheral setNotifyValue:YES forCharacteristic:characteristic];//触发服务端(外设)didSubscribeToCharacteristic函数
            
            self.characteristic = characteristic;
            
            [self.activityIndicatorView stopAnimating];
            NSLog(@"找到需要的特征，预定成功");
        }
    }
}

//特征值发生变化
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    
    if (error) {
        NSLog(@"发现特征错误:: %@", [error localizedDescription]);
        return;
    }
    NSLog(@"特征值发生变化");
    
    NSString *stringFromData = [[NSString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding];
    
    // 判断是否为数据结束
    if ([stringFromData isEqualToString:@"END"]) {
        
        // 显示数据
        NSString* recString = [[NSString alloc] initWithData:self.data encoding:NSUTF8StringEncoding];
        [self addReceiveMessage:recString];
        self.data.length = 0;
        return;
    }
    
    // 接收数据追加到data属性中
    [self.data appendData:characteristic.value];
}

//特征通知状态发生变化
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    
    if (error) {
        NSLog(@"特征通知状态变化错误: %@", error.localizedDescription);
    }
    
    // 如果没有特征传输过来则退出（如果不是我们感兴趣的特质）
    if (![characteristic.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]]) {
        return;
    }
    
    NSLog(@"特征通知状态发生变化");

    // 特征通知已经开始
    if (characteristic.isNotifying) {
        NSLog(@"特征通知已经开始 %@", characteristic);
    }
    // 特征通知已经停止
    else {
        NSLog(@"特征通知已经停止 %@", characteristic);
        [self.centralManager cancelPeripheralConnection:peripheral];
    }
}

//与外设连接断开时回调
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    
    NSLog(@"外设已经断开");
    self.discoveredPeripheral = nil;
    //外设已经断开情况下，重新扫描
    [self scan];
}


/** 清除方法
 */
- (void)cleanup {
    
    NSLog(@"清除订阅特征");
    // 如果没有连接则退出
    if (self.discoveredPeripheral.state != CBPeripheralStateConnected) {
        return;
    }
    
    // 判断是否已经预定了特征
    
    for (CBService *service in self.discoveredPeripheral.services) {
        
        for (CBCharacteristic *characteristic in service.characteristics) {
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]]) {
                if (characteristic.isNotifying) {
                    //停止接收特征通知
                    [self.discoveredPeripheral setNotifyValue:NO forCharacteristic:characteristic];
                    //断开与外设连接
                    [self.centralManager cancelPeripheralConnection:self.discoveredPeripheral];
                    return;
                }
            }
        }
    }
}



//添加从外设发来的消息
-(void)addReceiveMessage:(NSString*)message{
    
    NSLog(@"收到从外设发来的消息:\n%@",message);
    
    //下面代码无需研究，只是为了显示在屏幕上
    [self receiveMessage:message senderId:kJSQDemoAvatarIdCook senderName:kJSQDemoAvatarDisplayNameCook];
    
}



//=================================================================
//                           发送文本数据
//=================================================================
#pragma mark - 发送文本数据

- (void)didPressSendButton:(UIButton *)button
           withMessageText:(NSString *)text
                  senderId:(NSString *)senderId
         senderDisplayName:(NSString *)senderDisplayName
                      date:(NSDate *)date {
    
    if (self.activityIndicatorView.isAnimating) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"没有与外设建立链接，无法发送数据" delegate:nil cancelButtonTitle:@"" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    NSLog(@"要发送的消息为:\n%@",text);
    NSData *writeData = [text dataUsingEncoding:NSUTF8StringEncoding];
    
    if (self.characteristic.properties & CBCharacteristicPropertyWrite) {
        [self.discoveredPeripheral writeValue:writeData forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
    }

    //下面代码无需研究，只是为了显示在屏幕上
    [super didPressSendButton:button withMessageText:text senderId:senderId senderDisplayName:senderDisplayName date:date];
}



- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    NSLog(@"给外设写入数据成功");
}



//=================================================================
//                        和界面相关，请忽略
//=================================================================
#pragma mark - 和界面相关，请忽略

- (NSString *)senderId {
    return kJSQDemoAvatarIdWoz;
    
}

@end




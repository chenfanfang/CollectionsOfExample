//
//  CBPeripheralManagerController.m
//  CoreBluetooth_Demo
//
//  Created by mac on 16/9/9.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "CBPeripheralManagerController.h"

#import <CoreBluetooth/CoreBluetooth.h>

//可通过终端命令 uuidgen来生成
#define TRANSFER_SERVICE_UUID @"D63D44E5-E798-4EA5-A1C0-3F9EEEC2CDEB"
#define TRANSFER_CHARACTERISTIC_UUID @"1652CAD2-6B0D-4D34-96A0-75058E606A98"

//每次向中心设备发送数据的最大的数据量
#define SEND_DATA_MAX_AMOUNT 20


@interface CBPeripheralManagerController ()<CBPeripheralManagerDelegate>

/** 外设管理者 */
@property (strong, nonatomic) CBPeripheralManager *peripheralManager;

/** 特征 */
@property (strong, nonatomic) CBMutableCharacteristic *transferCharacteristic;

/** 需要发送的数据 */
@property (strong, nonatomic) NSData *dataToSend;

/** 需要发送的数据的字节的下标标记 */
@property (nonatomic, readwrite) NSInteger sendDataIndex;


@end

@implementation CBPeripheralManagerController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationItem.title = @"外设模式";
    
    //设置CBPeripheralManager
    _peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil];
    
    [self.activityIndicatorView startAnimating];
}


- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.peripheralManager stopAdvertising];
    
    self.peripheralManager = nil;

    
}


- (void)dealloc {
    
    NSLog(@"%@控制器销毁成功，无内存泄漏",NSStringFromClass([self class]));
}

//=================================================================
//                    CBPeripheralManagerDelegate
//=================================================================
#pragma mark - CBPeripheralManagerDelegate

//外设设置成功回调此方法
- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {
    
    if (peripheral.state != CBPeripheralManagerStatePoweredOn) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请您打开蓝牙" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    NSLog(@"蓝牙处于打开状态");
    
    // 初始化特征
    self.transferCharacteristic = [[CBMutableCharacteristic alloc]
                                   initWithType:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]
                                   properties:CBCharacteristicPropertyNotify | CBCharacteristicPropertyWrite
                                   value:nil
                                   permissions:CBAttributePermissionsWriteable]; //CBAttributePermissionsReadable
    
    // 初始化服务
    CBMutableService *transferService = [[CBMutableService alloc]
                                         initWithType:[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID]
                                         primary:YES];
    
    // 添加特征到服务
    transferService.characteristics = @[self.transferCharacteristic];
    
    // 发布服务与特征(将服务添加到外设中)
    [self.peripheralManager addService:transferService];
}


- (void)peripheralManager:(CBPeripheralManager *)peripheral
            didAddService:(CBService *)service
                    error:(NSError *)error {
    
    if (error) {
        NSLog(@"添加服务失败: %@", [error localizedDescription]);
        
    }else{
        NSLog( @"添加服务成功，准备广播..." );
        [self.peripheralManager startAdvertising:@{ CBAdvertisementDataServiceUUIDsKey : @[[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID]] }];
    }
}


//中心管理者订阅了特征，会回调该方法
- (void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didSubscribeToCharacteristic:(CBCharacteristic *)characteristic {
    
    [self.activityIndicatorView stopAnimating];
    NSLog(@"中心已经订阅了特征");
    
}

//中心管理者取消订阅了特征，会回调该方法
- (void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didUnsubscribeFromCharacteristic:(CBCharacteristic *)characteristic {
    
    [self.activityIndicatorView startAnimating];
    NSLog(@"中心取消订阅特征");
    
}



//向中心管理者发送数据
//注意，发送大量的数据时，需要将数据分成多个小数据发送，要不然会发送失败
- (void)sendData {

    /** 是否开始发送 END  */
    static BOOL sendingEND = NO;
    
    
    //开始发送最后的 结束标识符  END
    if (sendingEND == YES) {
        BOOL didSend = [self.peripheralManager updateValue:[@"END" dataUsingEncoding:NSUTF8StringEncoding] forCharacteristic:self.transferCharacteristic onSubscribedCentrals:nil];
        if (didSend == YES) {
            sendingEND = NO;
            NSLog(@"发送数据完毕");
        }
        return;
    }
    
    
    //已经发送完毕
    if (self.sendDataIndex >= self.dataToSend.length) {
        return;
    }
    
    BOOL didSend = YES;
    
    //正在发送数据
    while (didSend) {
        
        //本次需要发送的数据量
        NSInteger amountToSend = self.dataToSend.length - self.sendDataIndex;
        
        //若发送的数量大于规定的最大发送的数据量
        if (amountToSend > SEND_DATA_MAX_AMOUNT) amountToSend = SEND_DATA_MAX_AMOUNT;
        
        //本次需要发送的数据
        NSData *smallData = [NSData dataWithBytes:self.dataToSend.bytes + self.sendDataIndex length:amountToSend];
        
        //发送数据
        didSend = [self.peripheralManager updateValue:smallData forCharacteristic:self.transferCharacteristic onSubscribedCentrals:nil];
        
        //发送数据失败 直接return
        if (didSend == NO) {
            return;
        }
        
        //更新需要发送的数据的字节下标
        self.sendDataIndex += amountToSend;
        
        //数据完全发送完成，记得需要发送一个结束的标识
        if (self.sendDataIndex >= self.dataToSend.length) {
            
            sendingEND = YES;
            
            BOOL endSent = [self.peripheralManager updateValue:[@"END" dataUsingEncoding:NSUTF8StringEncoding] forCharacteristic:self.transferCharacteristic onSubscribedCentrals:nil];
            
            if (endSent) {
                sendingEND = NO;
                NSLog(@"发送数据完毕");
                
            }
            return;
        }
    }
}

//发送数据失败后(发送数据的队列已经满了)重新发送
- (void)peripheralManagerIsReadyToUpdateSubscribers:(CBPeripheralManager *)peripheral {
    [self sendData];
}


- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveWriteRequests:(NSArray<CBATTRequest *> *)requests {
    
    CBATTRequest *request = requests.firstObject;
    NSString *receiveMsg = [[NSString alloc] initWithData:request.value encoding:NSUTF8StringEncoding];
    [peripheral respondToRequest:request withResult:CBATTErrorSuccess];
    
    NSLog(@"收到从中心管理者发来的消息:\n%@",receiveMsg);
    
    //下面代码无需研究，只是为了显示在屏幕上
    [self receiveMessage:receiveMsg senderId:kJSQDemoAvatarIdWoz senderName:kJSQDemoAvatarDisplayNameWoz];
    
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
    
    NSLog(@"要发送的消息为:\n%@",text);
    
    //判断是否与中心管理者保持着链接
    if (self.activityIndicatorView.isAnimating) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"没有与中心管理者建立链接，无法发送数据" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    self.sendDataIndex = 0;
    self.dataToSend = [text dataUsingEncoding:NSUTF8StringEncoding];
    [self sendData];
    
    //下面代码无需研究，只是为了显示在屏幕上
    [super didPressSendButton:button withMessageText:text senderId:senderId senderDisplayName:senderDisplayName date:date];
}


//=================================================================
//                        和界面相关，请忽略
//=================================================================
#pragma mark - 和界面相关，请忽略

- (NSString *)senderId {
    return kJSQDemoAvatarIdCook;
}


@end


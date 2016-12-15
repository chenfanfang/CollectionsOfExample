//
//  FFCoreBluetoothChatPeripheralVC.m
//  CollectionsOfExample
//
//  Created by mac on 16/9/19.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFCoreBluetoothChatPeripheralVC.h"

#define SERVICEUUID @"EBE4EB2D-55BE-4984-A2D2-8A65626BC6A6"
#define CHARACTERISTICUUID @"FD5A5E6F-BD06-4EC0-96AF-16D12D5897FA"


#define NOTIFY_MAX 20

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

@interface FFCoreBluetoothChatPeripheralVC ()<UITableViewDataSource, UITableViewDelegate, CBPeripheralManagerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** 底部view的底部约束 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewBottomConstraint;

/** 文本输入框 */
@property (weak, nonatomic) IBOutlet FFCustomWithPlaceHolderTextView *textView;

/** 发送的按钮 */
@property (weak, nonatomic) IBOutlet UIButton *sendButton;

/** 数据源数组 */
@property (nonatomic, strong) NSMutableArray *dataSourceArrM;

/** 蓝牙外设管理者 */
@property (nonatomic, strong) CBPeripheralManager *peripheralManager;

/** 特征 */
@property (nonatomic, strong) CBMutableCharacteristic *characteristicM;

/** 接收到的数据 */
@property (nonatomic, strong) NSMutableData *receiveDataM;

/** 需要发送的数据 */
@property (nonatomic, strong) NSData *needSendData;

@property (nonatomic, readwrite) NSInteger sendDataIndex;

@end

@implementation FFCoreBluetoothChatPeripheralVC

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
    
    self.navigationItem.title = @"与中心模式聊天";
    
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
    self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil];
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
//                   CBPeripheralManagerDelegate
//=================================================================
#pragma mark - CBPeripheralManagerDelegate

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {
    
    BOOL blueToothEnable = NO;
    
    switch (peripheral.state) {
        case CBPeripheralManagerStateUnknown:
            NSLog(@"CBPeripheralManagerStateUnknown");
            break;
            
        case CBPeripheralManagerStateResetting:
            NSLog(@"CBPeripheralManagerStateResetting");
            break;
            
        case CBPeripheralManagerStateUnsupported:
            NSLog(@"CBPeripheralManagerStateUnsupported");
            break;
            
        case CBPeripheralManagerStateUnauthorized:
            NSLog(@"CBPeripheralManagerStateUnauthorized");
            break;
            
        case CBPeripheralManagerStatePoweredOff:
            NSLog(@"CBPeripheralManagerStatePoweredOff");
            break;
            
        case CBPeripheralManagerStatePoweredOn:
            blueToothEnable = YES;
            break;
        default:
            break;
    }
    
    
    //蓝牙处于可用状态，则给peripheral添加服务
    if (blueToothEnable == YES) {
        
        //创建特征
        CBMutableCharacteristic *characteristicM = [[CBMutableCharacteristic alloc] initWithType:[CBUUID UUIDWithString:CHARACTERISTICUUID] properties:CBCharacteristicPropertyNotify | CBCharacteristicPropertyWrite value:nil permissions:CBAttributePermissionsWriteable];
        
        self.characteristicM = characteristicM;
        
        //创建服务
        CBMutableService *serviceM = [[CBMutableService alloc] initWithType:[CBUUID UUIDWithString:SERVICEUUID] primary:YES];
        
        serviceM.characteristics = @[characteristicM];
        
        [peripheral addService:serviceM];
    }
}

//peripheral成功添加了服务，就会进入这个方法
- (void)peripheralManager:(CBPeripheralManager *)peripheral didAddService:(CBService *)service error:(NSError *)error {
    
    if (error) {
        NSLog(@"didAddService--Error:%@",error.localizedDescription);
        return;
    }
    
    
    NSDictionary *dic = @{
                          CBAdvertisementDataServiceUUIDsKey : @[[CBUUID UUIDWithString:SERVICEUUID]]
                          };
    [peripheral startAdvertising:dic];
}


//中心模式中的中心管理者  订阅了peripheral的某个
- (void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didSubscribeToCharacteristic:(CBCharacteristic *)characteristic {
    
    self.sendButton.enabled = YES;
}


- (void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didUnsubscribeFromCharacteristic:(CBCharacteristic *)characteristic {
    
    self.sendButton.enabled = NO;
}



//发送数据失败后(发送数据的队列已经满了)重新发送
- (void)peripheralManagerIsReadyToUpdateSubscribers:(CBPeripheralManager *)peripheral {
    [self sendData];
}


- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveWriteRequests:(NSArray<CBATTRequest *> *)requests {
    
    CBATTRequest *request = requests.firstObject;
    NSString *receiveMsg = [[NSString alloc] initWithData:request.value encoding:NSUTF8StringEncoding];
    
    FFChatMessageModel *model = [FFChatMessageModel new];
    model.messageDirectionType = FFMessageDirectionTypeReceive;
    model.message = receiveMsg;
    model.headerImageName = @"";
    
    [self.dataSourceArrM addObject:model];
    
    [peripheral respondToRequest:request withResult:CBATTErrorSuccess];
}


//=================================================================
//                           other
//=================================================================
#pragma mark - other

- (void)sendData {
    
    self.needSendData = [self.textView.text dataUsingEncoding:NSUTF8StringEncoding];
    self.sendDataIndex = 0;
    
    /** 是否开始发送 END  */
    static BOOL sendingEND = NO;
    
    
    if (sendingEND == YES) { //开始发送最后的 结束标识符  END
        BOOL didSend = [self.peripheralManager updateValue:[@"END" dataUsingEncoding:NSUTF8StringEncoding] forCharacteristic:self.characteristicM onSubscribedCentrals:nil];
        if (didSend == YES) {
            sendingEND = NO;
            [self sendDataComplete];
        }
        return;
    }
    
    //已经发送完毕
    if (self.sendDataIndex >= self.needSendData.length) {
        return;
    }
    
    BOOL didSend = YES;
    
    while (didSend) {
        
        NSInteger amountToSend = self.needSendData.length - self.sendDataIndex;
        
        //若发送的数量大于规定的最大发送的数据量
        if (amountToSend > NOTIFY_MAX) amountToSend = NOTIFY_MAX;
        
        NSData *chunk = [NSData dataWithBytes:self.needSendData.bytes + self.sendDataIndex length:amountToSend];
        
        //发送数据
        didSend = [self.peripheralManager updateValue:chunk forCharacteristic:self.characteristicM onSubscribedCentrals:nil];
        
        if (didSend == NO) {
            return;
        }
        
        NSString *stringFromData = [[NSString alloc] initWithData:chunk encoding:NSUTF8StringEncoding];
        NSLog(@"Sent: %@", stringFromData);
        
        self.sendDataIndex += amountToSend;
        
        if (self.sendDataIndex >= self.needSendData.length) {
            
            sendingEND = YES;
            
            BOOL ENDSent = [self.peripheralManager updateValue:[@"END" dataUsingEncoding:NSUTF8StringEncoding] forCharacteristic:self.characteristicM onSubscribedCentrals:nil];
            
            if (ENDSent) {
                sendingEND = NO;
                [self sendDataComplete];
            }
            return;
        }
    }
}

/** 发送消息完毕 */
- (void)sendDataComplete {
    FFChatMessageModel *model = [FFChatMessageModel new];
    model.messageDirectionType = FFMessageDirectionTypeSend;
    model.message = self.textView.text;
    model.headerImageName = @"";
    
    self.textView.text = @"";
}


/** 发送按钮的点击 */
- (IBAction)sendButtonClick:(UIButton *)sender {
    [self sendData];
    
}

@end

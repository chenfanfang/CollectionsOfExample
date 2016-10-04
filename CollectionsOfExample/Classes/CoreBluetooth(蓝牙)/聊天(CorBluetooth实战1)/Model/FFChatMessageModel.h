//
//  FFChatMessageModel.h
//  CollectionsOfExample
//
//  Created by mac on 16/9/19.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  消息的方向类型
 */
typedef NS_ENUM(NSUInteger, FFMessageDirectionType) {
    /**
     *  发送消息
     */
    FFMessageDirectionTypeSend = 0,
    /**
     *  接收消息
     */
    FFMessageDirectionTypeReceive
};


/**
 *  聊天的信息模型
 */
@interface FFChatMessageModel : NSObject

/** 消息的方向类型 */
@property (nonatomic, assign) FFMessageDirectionType messageDirectionType;

/** 消息内容 */
@property (nonatomic, copy) NSString *message;

/** 头像 */
@property (nonatomic, copy) NSString *headerImageName;

@end













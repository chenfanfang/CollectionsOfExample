//
//  FFChatSendMessageCell.h
//  CollectionsOfExample
//
//  Created by mac on 16/9/19.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FFChatMessageModel;

@interface FFChatSendMessageCell : UITableViewCell

/** 消息模型 */
@property (nonatomic, strong) FFChatMessageModel *messageModel;

@end

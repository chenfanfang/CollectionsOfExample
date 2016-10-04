//
//  FFChatSendMessageCell.m
//  CollectionsOfExample
//
//  Created by mac on 16/9/19.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFChatSendMessageCell.h"

//model
#import "FFChatMessageModel.h"

@interface FFChatSendMessageCell ()

@property (weak, nonatomic) IBOutlet UIImageView *icon_ImageView;

@property (weak, nonatomic) IBOutlet UILabel *message_Label;

@property (weak, nonatomic) IBOutlet UILabel *time_Label;


@end

@implementation FFChatSendMessageCell

- (void)setMessageModel:(FFChatMessageModel *)messageModel {
    _messageModel = messageModel;
    
    self.message_Label.text = messageModel.message;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

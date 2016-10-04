//
//  FFCustomWithPlaceHolderTextView.m
//  CollectionsOfExample
//
//  Created by mac on 16/9/18.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFCustomWithPlaceHolderTextView.h"

@interface FFCustomWithPlaceHolderTextView ()<UITextViewDelegate>

@end

@implementation FFCustomWithPlaceHolderTextView

//=================================================================
//                           生命周期
//=================================================================
#pragma mark - 生命周期

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"text"];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [self setup];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.placedLabel.frame = CGRectMake(5, 6, self.width, 21);
}


//=================================================================
//                              初始化
//=================================================================
#pragma mark - 初始化

- (void)setup {
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    
    self.delegate = self;
    
    self.placedLabel = [[UILabel alloc] init];
    self.placedLabel.textColor = FFColor(153, 153, 153);
    self.placedLabel.font = self.font;
    [self addSubview:self.placedLabel];
    
    
    //kvo监听值的改变
    [self addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}




//=================================================================
//                           KVO
//=================================================================
#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    NSString *newStr = change[@"new"];
    if (self.textChangedBlock) {
        self.textChangedBlock(newStr);
    }
    self.placedLabel.hidden = newStr.length;
}




//=================================================================
//                       UITextViewDelegate
//=================================================================
#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length) {
        self.placedLabel.hidden = YES;
    } else {
        self.placedLabel.hidden = NO;
    }
    
    if (self.textChangedBlock) {
        self.textChangedBlock(textView.text);
    }
    
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text {
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

@end











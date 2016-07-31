//
//  FFRegulationExpressVC.m
//  CollectionsOfExample
//
//  Created by mac on 16/7/31.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFRegulationExpressDemoVC.h"

@interface FFRegulationExpressDemoVC ()


@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;


@end

@implementation FFRegulationExpressDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"正则表达式的使用";
}

/** 开始匹配 */
- (IBAction)beginMatching {
    NSError *error = nil;
    
    //正常的正则表达式是: "\$.{2,10}\(\w{8}\)\$" 由于转义字符的原因，\\代表一个\
    /** 正则表达式 */
    NSString *regularExpStr = @"\\$.{2,10}\\(\\w{8}\\)\\$";
    NSRegularExpression *regularExp = [[NSRegularExpression alloc] initWithPattern:regularExpStr options:NSRegularExpressionCaseInsensitive error:&error];
    
    /** 文本内容字符串 */
    NSString *conentStr = self.textView.text;
    
    /** 结果的字符串 */
    NSMutableString *resultStrM = [NSMutableString stringWithFormat:@"结果:\n"];
    
    
    
    //开始匹配字符串
    /*
     
    //匹配方式1：返回匹配结果
    NSArray <NSTextCheckingResult *> *resultArr = [regularExp matchesInString:conentStr options:NSMatchingReportProgress range:NSMakeRange(0, conentStr.length)];
    
    //遍历数组、取出匹配出来的字符串
    for (NSTextCheckingResult *result in resultArr) {
        NSString *subStr = [conentStr substringWithRange:result.range];
        [resultStrM appendString:[NSString stringWithFormat:@"%@\n",subStr]];
    }
     
    */
    
    
    //方法2：block快速遍历每个匹配   stop可以控制退出遍历
    [regularExp enumerateMatchesInString:conentStr options:NSMatchingReportProgress range:NSMakeRange(0, conentStr.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        if (result) {
            NSString *subStr = [conentStr substringWithRange:result.range];
            [resultStrM appendString:[NSString stringWithFormat:@"%@\n",subStr]];
        }
        
    }];
    
    self.resultLabel.text = resultStrM;
}


@end

//
//  FFExampleModel.h
//  CollectionsOfExample
//
//  Created by mac on 16/7/17.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  例子的模型
 */
@interface FFExampleModel : NSObject

/** 例子的名称 */
@property (nonatomic, copy) NSString *exampleName;

/** 例子的图片名称 */
@property (nonatomic, copy) NSString *exampleImageName;

/** 例子对应的类的名称 */
@property (nonatomic, copy) NSString *correspondClassName;

+ (instancetype)exampleModelWithExampleName:(NSString *)exampleName exampleImageName:(NSString *)exampleImageName correspondClassName:(NSString *)correspondClassName;

@end

//
//  FFExampleModel.m
//  CollectionsOfExample
//
//  Created by mac on 16/7/17.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFExampleModel.h"

@implementation FFExampleModel

+ (instancetype)exampleModelWithExampleName:(NSString *)exampleName exampleImageName:(NSString *)exampleImageName correspondClassName:(NSString *)correspondClassName {
    FFExampleModel *model = [FFExampleModel new];
    model.exampleName = exampleName;
    model.exampleImageName = exampleImageName;
    model.correspondClassName = correspondClassName;
    return model;
}

@end

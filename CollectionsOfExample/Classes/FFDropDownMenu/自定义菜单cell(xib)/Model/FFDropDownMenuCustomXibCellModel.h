//
//  FFDropDownMenuCustomXibCellModel.h
//  CollectionsOfExample
//
//  Created by mac on 16/8/7.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import <FFDropDownMenuBasedModel.h>
/**
 *  自定义菜单模型
 */
@interface FFDropDownMenuCustomXibCellModel : FFDropDownMenuBasedModel

//提醒：父类中有@property (nonatomic, copy) FFMenuBlock menuBlock;  这个属性


/** 标题 */
@property (nonatomic, copy) NSString *title;

/** 图片名称 */
@property (nonatomic, copy) NSString *iconName;


@end

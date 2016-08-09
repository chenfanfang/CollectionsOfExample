//
//  FFDropDownMenuBaseUsageVC.m
//  CollectionsOfExample
//
//  Created by mac on 16/8/6.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFDropDownMenuBaseUsageVC.h"

//view
#import <FFDropDownMenuView.h>

//controller
#import "FFDropDownMenuNextPageVC.h"


@interface FFDropDownMenuBaseUsageVC ()

/** 下拉菜单 */
@property (nonatomic, strong) FFDropDownMenuView *dropDownMenu;

@end

@implementation FFDropDownMenuBaseUsageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
    //创建下拉菜单方式1
    [self createDropdownMenuMethodOne];
     */
    
    
    //创建下拉菜单方式2
    [self createDropdownMenuMethodTwo];
     

    
    //初始化导航栏
    [self setupNav];
}

/** 创建下拉菜单方式1 */
- (void)createDropdownMenuMethodOne {
    
    //若使用默认CGFloat值     请使用 FFDefaultFloat
    //若使用默认CGSize值      请使用 FFDefaultSize
    //若使用默认Cell值        请使用 FFDefaultCell
    //若使用默认Color值       请使用 FFDefaultColor
    //若使用默认ScaleType值   请使用 FFDefaultMenuScaleType
    
    NSArray *menuModelsArr = [self getDropDownMenuModelsArray];
    self.dropDownMenu = [FFDropDownMenuView ff_DefaultStyleDropDownMenuWithMenuModelsArray:menuModelsArr menuWidth:145 eachItemHeight:40 menuRightMargin:10 triangleRightMargin:20];
    
    //若还需要对别的属性进行赋值，则可以再对别的属性进行赋值，最后一定要调用setup方法。如下
    
    /*
    self.dropDownMenu.menuScaleType = FFDropDownMenuViewScaleType_TopRight;
    self.dropDownMenu...... = ......;
    [self.dropDownMenu setup];
     */
}


/** 创建下拉菜单方式2 */
- (void)createDropdownMenuMethodTwo {
    NSArray *menuModelsArr = [self getDropDownMenuModelsArray];
    self.dropDownMenu = [FFDropDownMenuView new];
    
    //进行属性的赋值
    
    //若使用默认CGFloat值     请使用 FFDefaultFloat          、或者无需进行赋值
    //若使用默认CGSize值      请使用 FFDefaultSize           、或者无需进行赋值
    //若使用默认Cell值        请使用 FFDefaultCell           、或者无需进行赋值
    //若使用默认Color值       请使用 FFDefaultColor          、或者无需进行赋值
    //若使用默认ScaleType值   请使用 FFDefaultMenuScaleType  、或者无需进行赋值
    
    
    /** 下拉菜单模型数组 */
    self.dropDownMenu.menuModelsArray = menuModelsArr;
    /** cell的类名 */
    self.dropDownMenu.cellClassName = FFDefaultCell;
    /** 菜单的宽度(若不设置，默认为 150) */
    self.dropDownMenu.menuWidth = 145;
    /** 菜单的圆角半径(若不设置，默认为5) */
    self.dropDownMenu.menuCornerRadius = FFDefaultFloat;
    /** 每一个选项的高度(若不设置，默认为40) */
    self.dropDownMenu.eachMenuItemHeight = 40;
    /** 菜单条离屏幕右边的间距(若不设置，默认为10) */
    self.dropDownMenu.menuRightMargin = 10;
    /** 三角形颜色(若不设置，默认为白色) */
    self.dropDownMenu.triangleColor = [UIColor whiteColor];
    /** 三角形相对于keyWindow的y值,也就是相对于屏幕顶部的y值(若不设置，默认为64) */
    self.dropDownMenu.triangleY = FFDefaultFloat;
    /** 三角形距离屏幕右边的间距(若不设置，默认为20) */
    self.dropDownMenu.triangleRightMargin = FFDefaultFloat;
    /** 三角形的size  size.width:代表三角形底部边长，size.Height:代表三角形的高度(若不设置，默认为CGSizeMake(15, 10)) */
    self.dropDownMenu.triangleSize = FFDefaultSize;
    /** 背景颜色开始时的透明度(还没展示menu的透明度)(若不设置，默认为0.02) */
    self.dropDownMenu.bgColorbeginAlpha = 0;
    /** 背景颜色结束的的透明度(menu完全展示的透明度)(若不设置，默认为0.2) */
    self.dropDownMenu.bgColorEndAlpha = 0.4;
    /** 动画效果时间(若不设置，默认为0.2) */
    self.dropDownMenu.animateDuration = FFDefaultFloat;
    /** 菜单的伸缩类型 */
    self.dropDownMenu.menuScaleType = FFDefaultMenuScaleType;
    
    
    //所有属性赋值完 一定要调用 setup
    [self.dropDownMenu setup];
    
}


/** 获取下拉菜单模型数组 */
- (NSArray *)getDropDownMenuModelsArray {
    __weak typeof(self)weakSelf = self;
    //菜单模型0
    FFDropDownMenuModel *menuModel0 = [FFDropDownMenuModel ff_DropDownMenuModelWithMenuItemTitle:@"Twitter" menuItemIconName:@"menu0" menuBlock:^{
        FFDropDownMenuNextPageVC *vc = [FFDropDownMenuNextPageVC new];
        vc.navigationItem.title = @"Twitter";
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    //菜单模型1
    FFDropDownMenuModel *menuModel1 = [FFDropDownMenuModel ff_DropDownMenuModelWithMenuItemTitle:@"Line" menuItemIconName:@"menu1" menuBlock:^{
        FFDropDownMenuNextPageVC *vc = [FFDropDownMenuNextPageVC new];
        vc.navigationItem.title = @"Line";
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    //菜单模型2
    FFDropDownMenuModel *menuModel2 = [FFDropDownMenuModel ff_DropDownMenuModelWithMenuItemTitle:@"QQ" menuItemIconName:@"menu2"  menuBlock:^{
        FFDropDownMenuNextPageVC *vc = [FFDropDownMenuNextPageVC new];
        vc.navigationItem.title = @"QQ";
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    //菜单模型3
    FFDropDownMenuModel *menuModel3 = [FFDropDownMenuModel ff_DropDownMenuModelWithMenuItemTitle:@"QZone" menuItemIconName:@"menu3"  menuBlock:^{
        FFDropDownMenuNextPageVC *vc = [FFDropDownMenuNextPageVC new];
        vc.navigationItem.title = @"QZone";
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    //菜单模型4
    FFDropDownMenuModel *menuModel4 = [FFDropDownMenuModel ff_DropDownMenuModelWithMenuItemTitle:@"WeChat" menuItemIconName:@"menu4"  menuBlock:^{
        FFDropDownMenuNextPageVC *vc = [FFDropDownMenuNextPageVC new];
        vc.navigationItem.title = @"WeChat";
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    //菜单模型5
    FFDropDownMenuModel *menuModel5 = [FFDropDownMenuModel ff_DropDownMenuModelWithMenuItemTitle:@"Facebook" menuItemIconName:@"menu5"  menuBlock:^{
        FFDropDownMenuNextPageVC *vc = [FFDropDownMenuNextPageVC new];
        vc.navigationItem.title = @"Facebook";
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    NSArray *menuModelArr = @[menuModel0, menuModel1, menuModel2, menuModel3, menuModel4, menuModel5];
    
    return menuModelArr;
}


/** 初始化导航栏 */
- (void)setupNav {
    UIButton *menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 27, 27)];
    [menuButton setImage:[UIImage imageNamed:@"nemuItem"] forState:UIControlStateNormal];
    [menuButton addTarget:self.dropDownMenu action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    self.navigationItem.title = @"FFDropDownMenu的基本用法";
}

@end

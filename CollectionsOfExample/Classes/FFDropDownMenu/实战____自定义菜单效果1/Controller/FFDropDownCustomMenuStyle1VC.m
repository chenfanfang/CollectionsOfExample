//
//  FFDropDownCustomMenuStyle1.m
//  CollectionsOfExample
//
//  Created by mac on 16/8/12.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFDropDownCustomMenuStyle1VC.h"

//controller
#import "FFDropDownMenuNextPageVC.h"

//view
#import <FFDropDownMenuView.h>

//model
#import "FFDropDownCustomMenuStyle1Model.h"

@interface FFDropDownCustomMenuStyle1VC ()

/** 下拉菜单 */
@property (nonatomic, strong) FFDropDownMenuView *dropDownMenu;

@end

@implementation FFDropDownCustomMenuStyle1VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createDropdownMenu];
    
    [self setupNav];
}


- (void)createDropdownMenu {
    NSArray *menuModelsArr = [self getDropDownMenuModelsArray];
    
    self.dropDownMenu = [FFDropDownMenuView new];
    //设置动画效果,可以根据项目需求设置自己所需要的动画效果
    self.dropDownMenu.menuAnimateType = FFDropDownMenuViewAnimateType_FallFromTop;
    //若不需要灰色透明蒙板，下面的两个透明度可以设置为0
    self.dropDownMenu.bgColorbeginAlpha = 0;
    self.dropDownMenu.bgColorEndAlpha = 0;
    //设置下拉菜单的宽度为整个屏幕的宽度
    self.dropDownMenu.menuWidth = [UIScreen mainScreen].bounds.size.width;
    //设置菜单距离屏幕右边的边距为0
    self.dropDownMenu.menuRightMargin = 0;
    //取消菜单圆角效果
    self.dropDownMenu.menuCornerRadius = 0;
    //隐藏三角形
    self.dropDownMenu.triangleSize = CGSizeZero;
    self.dropDownMenu.eachMenuItemHeight = 70;
    self.dropDownMenu.menuModelsArray = menuModelsArr;
    self.dropDownMenu.cellClassName = @"FFDropDownCustomMenuStyle1Cell.xib";
    self.dropDownMenu.menuItemBackgroundColor = FFColor(255, 255, 255, 0.7);
    [self.dropDownMenu setup];
}

/** 获取下拉菜单模型数组 */
- (NSArray *)getDropDownMenuModelsArray {
    __weak typeof(self)weakSelf = self;
    
    FFDropDownCustomMenuStyle1Model *menuModel1 = [FFDropDownCustomMenuStyle1Model new];
    menuModel1.mainTitleBgColor = FFColor(54, 188, 37, 1);
    menuModel1.mainTitle = @"1";
    menuModel1.subTitle = @"First Menu Item";
    menuModel1.menuBlock = ^ {
        FFDropDownMenuNextPageVC *vc = [FFDropDownMenuNextPageVC new];
        vc.navigationItem.title = @"First Menu Item";
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    
    FFDropDownCustomMenuStyle1Model *menuModel2 = [FFDropDownCustomMenuStyle1Model new];
    menuModel2.mainTitleBgColor = FFColor(255, 199, 40, 1);
    menuModel2.mainTitle = @"2";
    menuModel2.subTitle = @"Second Menu Item";
    menuModel2.menuBlock = ^ {
        FFDropDownMenuNextPageVC *vc = [FFDropDownMenuNextPageVC new];
        vc.navigationItem.title = @"Second Menu Item";
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    
    FFDropDownCustomMenuStyle1Model *menuModel3 = [FFDropDownCustomMenuStyle1Model new];
    menuModel3.mainTitleBgColor = FFColor(255, 81, 31, 1);
    menuModel3.mainTitle = @"3";
    menuModel3.subTitle = @"Third Menu Item";
    menuModel3.menuBlock = ^ {
        FFDropDownMenuNextPageVC *vc = [FFDropDownMenuNextPageVC new];
        vc.navigationItem.title = @"Facebook";
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    FFDropDownCustomMenuStyle1Model *menuModel4 = [FFDropDownCustomMenuStyle1Model new];
    menuModel4.mainTitleBgColor = FFColor(18, 170, 158, 1);
    menuModel4.mainTitle = @"4";
    menuModel4.subTitle = @"Fourth Menu Item";
    menuModel4.menuBlock = ^ {
        FFDropDownMenuNextPageVC *vc = [FFDropDownMenuNextPageVC new];
        vc.navigationItem.title = @"Facebook";
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    FFDropDownCustomMenuStyle1Model *menuModel5 = [FFDropDownCustomMenuStyle1Model new];
    menuModel5.mainTitleBgColor = FFColor(0, 119, 195, 1);
    menuModel5.mainTitle = @"5";
    menuModel5.subTitle = @"Fifth Menu Item";
    menuModel5.menuBlock = ^ {
        FFDropDownMenuNextPageVC *vc = [FFDropDownMenuNextPageVC new];
        vc.navigationItem.title = @"Facebook";
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    
    NSArray *menuModelArr = @[menuModel1,menuModel2,menuModel3,menuModel4,menuModel5];
    
    return menuModelArr;
}


/** 初始化导航栏 */
- (void)setupNav {
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self.dropDownMenu action:@selector(showMenu)];
    
    self.navigationItem.title = @"实战:自定义菜单效果1";
    
    
}




@end

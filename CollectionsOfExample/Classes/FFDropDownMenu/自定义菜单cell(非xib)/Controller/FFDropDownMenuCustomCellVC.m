//
//  FFDropDownMenuCustomCellVC.m
//  CollectionsOfExample
//
//  Created by mac on 16/8/7.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFDropDownMenuCustomCellVC.h"

//controller
#import "FFDropDownMenuNextPageVC.h"

//view
#import <FFDropDownMenuView.h>

//model
#import <FFDropDownMenuModel.h>

@interface FFDropDownMenuCustomCellVC ()

/** 下拉菜单 */
@property (nonatomic, strong) FFDropDownMenuView *dropDownMenu;


@end

@implementation FFDropDownMenuCustomCellVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createDropdownMenu];
    
    [self setupNav];
}

- (void)createDropdownMenu {
    NSArray *menuModelsArr = [self getDropDownMenuModelsArray];
    
    self.dropDownMenu = [FFDropDownMenuView new];
    self.dropDownMenu.menuModelsArray = menuModelsArr;
    self.dropDownMenu.cellClassName = @"FFDropDownMenuCustomCell";
    self.dropDownMenu.menuItemBackgroundColor = FFColor(255, 255, 255, 0.7);
    self.dropDownMenu.triangleColor = FFColor(255, 255, 255, 0.7);
    [self.dropDownMenu setup];
}

/** 获取下拉菜单模型数组 */
- (NSArray *)getDropDownMenuModelsArray {
    __weak typeof(self)weakSelf = self;
    
    
    //若 模型FFDropDownMenuModel里面的属性不够用，可以自定义继承于FFDropDownMenuBasedModel的模型
    
    //菜单模型0
    FFDropDownMenuModel *menuModel0 = [FFDropDownMenuModel new];
    menuModel0.menuItemTitle = @"Twitter";
    menuModel0.menuItemIconName = @"menu0";
    menuModel0.menuBlock = ^ {

        FFDropDownMenuNextPageVC *vc = [FFDropDownMenuNextPageVC new];
        vc.navigationItem.title = @"Twitter";
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    //菜单模型1
    FFDropDownMenuModel *menuModel1 = [FFDropDownMenuModel new];
    menuModel1.menuItemTitle = @"Line";
    menuModel1.menuItemIconName = @"menu1";
    menuModel1.menuBlock = ^ {
        FFDropDownMenuNextPageVC *vc = [FFDropDownMenuNextPageVC new];
        vc.navigationItem.title = @"Line";
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    //菜单模型2
    FFDropDownMenuModel *menuModel2 = [FFDropDownMenuModel new];
    menuModel2.menuItemTitle = @"QQ";
    menuModel2.menuItemIconName = @"menu2";
    menuModel2.menuBlock = ^ {
        FFDropDownMenuNextPageVC *vc = [FFDropDownMenuNextPageVC new];
        vc.navigationItem.title = @"QQ";
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    //菜单模型3
    FFDropDownMenuModel *menuModel3 = [FFDropDownMenuModel new];
    menuModel3.menuItemTitle = @"QZone";
    menuModel3.menuItemIconName = @"menu3";
    menuModel3.menuBlock = ^ {
        FFDropDownMenuNextPageVC *vc = [FFDropDownMenuNextPageVC new];
        vc.navigationItem.title = @"QZone";
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    //菜单模型4
    FFDropDownMenuModel *menuModel4 = [FFDropDownMenuModel new];
    menuModel4.menuItemTitle = @"WeChat";
    menuModel4.menuItemIconName = @"menu4";
    menuModel4.menuBlock = ^ {
        FFDropDownMenuNextPageVC *vc = [FFDropDownMenuNextPageVC new];
        vc.navigationItem.title = @"WeChat";
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    //菜单模型5
    FFDropDownMenuModel *menuModel5 = [FFDropDownMenuModel new];
    menuModel5.menuItemTitle = @"Facebook";
    menuModel5.menuItemIconName = @"menu5";
    menuModel5.menuBlock = ^ {
        FFDropDownMenuNextPageVC *vc = [FFDropDownMenuNextPageVC new];
        vc.navigationItem.title = @"Facebook";
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    NSArray *menuModelArr = @[menuModel0, menuModel1, menuModel2, menuModel3, menuModel4, menuModel5];
    
    return menuModelArr;
}


/** 初始化导航栏 */
- (void)setupNav {
    UIButton *menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 27, 27)];
    [menuButton setImage:[UIImage imageNamed:@"nemuItem"] forState:UIControlStateNormal];
    [menuButton addTarget:self.dropDownMenu action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
    self.navigationItem.title = @"自定义菜单cell(非xib)";
}




@end

//
//  FFDropDownMenuCustomXibCellVC.m
//  CollectionsOfExample
//
//  Created by mac on 16/8/7.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFDropDownMenuCustomXibCellVC.h"

//controller
#import "FFDropDownMenuNextPageVC.h"

//view
#import <FFDropDownMenuView.h>

//model
#import "FFDropDownMenuCustomXibCellModel.h"

@interface FFDropDownMenuCustomXibCellVC ()

/** 下拉菜单 */
@property (nonatomic, strong) FFDropDownMenuView *dropDownMenu;

@end

@implementation FFDropDownMenuCustomXibCellVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createDropdownMenu];
    
    [self setupNav];
}


- (void)createDropdownMenu {
    NSArray *menuModelsArr = [self getDropDownMenuModelsArray];
    
    self.dropDownMenu = [FFDropDownMenuView new];
    self.dropDownMenu.menuModelsArray = menuModelsArr;
    self.dropDownMenu.cellClassName = @"FFDropDownMenuCustomXibCell.xib";
    self.dropDownMenu.menuItemBackgroundColor = FFColor(255, 255, 255, 0.9);
    self.dropDownMenu.triangleColor = self.dropDownMenu.menuItemBackgroundColor;
    [self.dropDownMenu setup];
}

/** 获取下拉菜单模型数组 */
- (NSArray *)getDropDownMenuModelsArray {
    __weak typeof(self)weakSelf = self;
    
    //若 模型FFDropDownMenuModel里面的属性够用，则无需自定义模型----如下
    
    /*
    //菜单模型0
    FFDropDownMenuModel *menuModel0 = [FFDropDownMenuModel ff_DropDownMenuModelWithMenuItemTitle:@"Twitter" menuItemIconName:@"menu0" menuBlock:^{
        UIViewController *vc = [UIViewController new];
        vc.view.backgroundColor = [UIColor yellowColor];
        vc.navigationItem.title = @"Twitter";
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
     */
    
    
    //若 模型FFDropDownMenuModel里面的属性不够用，可以自定义继承于FFDropDownMenuBasedModel的模型
    
    //菜单模型0
    FFDropDownMenuCustomXibCellModel *menuModel0 = [FFDropDownMenuCustomXibCellModel new];
    menuModel0.title = @"Twitter";
    menuModel0.iconName = @"menu0";
    menuModel0.menuBlock = ^ {
        FFDropDownMenuNextPageVC *vc = [FFDropDownMenuNextPageVC new];
        vc.navigationItem.title = @"Twitter";
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };

    //菜单模型1
    FFDropDownMenuCustomXibCellModel *menuModel1 = [FFDropDownMenuCustomXibCellModel new];
    menuModel1.title = @"Line";
    menuModel1.iconName = @"menu1";
    menuModel1.menuBlock = ^ {
        FFDropDownMenuNextPageVC *vc = [FFDropDownMenuNextPageVC new];
        vc.navigationItem.title = @"Line";
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    //菜单模型2
    FFDropDownMenuCustomXibCellModel *menuModel2 = [FFDropDownMenuCustomXibCellModel new];
    menuModel2.title = @"QQ";
    menuModel2.iconName = @"menu2";
    menuModel2.menuBlock = ^ {
        FFDropDownMenuNextPageVC *vc = [FFDropDownMenuNextPageVC new];
        vc.navigationItem.title = @"QQ";
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };

    //菜单模型3
    FFDropDownMenuCustomXibCellModel *menuModel3 = [FFDropDownMenuCustomXibCellModel new];
    menuModel3.title = @"QZone";
    menuModel3.iconName = @"menu3";
    menuModel3.menuBlock = ^ {
        FFDropDownMenuNextPageVC *vc = [FFDropDownMenuNextPageVC new];
        vc.navigationItem.title = @"QZone";
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    //菜单模型4
    FFDropDownMenuCustomXibCellModel *menuModel4 = [FFDropDownMenuCustomXibCellModel new];
    menuModel4.title = @"WeChat";
    menuModel4.iconName = @"menu4";
    menuModel4.menuBlock = ^ {
        FFDropDownMenuNextPageVC *vc = [FFDropDownMenuNextPageVC new];
        vc.navigationItem.title = @"WeChat";
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };

    //菜单模型5
    FFDropDownMenuCustomXibCellModel *menuModel5 = [FFDropDownMenuCustomXibCellModel new];
    menuModel5.title = @"Facebook";
    menuModel5.iconName = @"menu5";
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
    
    self.navigationItem.title = @"FFDropDownMenu的基本用法";
}




@end

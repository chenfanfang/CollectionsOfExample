//
//  FFDifferentWidthTagVC.m
//  CollectionsOfExample
//
//  Created by mac on 16/7/17.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFDifferentWidthTagVC.h"

//model
#import "FFDifferentWidthTagModel.h"

//cell
#import "FFDifferentWidthTagCell.h"

@interface FFDifferentWidthTagVC ()<UITableViewDataSource, UITableViewDelegate>

/** 数据源数组 */
@property (nonatomic, strong) NSMutableArray<FFDifferentWidthTagModel *> *dataSourceArr;

/** section头部标题数组 */
@property (nonatomic, strong) NSArray *sectionHeaderTitleArr;

/** 存放标签的数组 */
@property (nonatomic, strong) NSArray *tagArr;

@end

@implementation FFDifferentWidthTagVC

/***********************************生命周期***********************************/
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

/***********************************初始化***********************************/
#pragma mark - 初始化

static NSString *const FFDifferentWidthTagCellID = @"FFDifferentWidthTagCell";
- (void)setup {
    //navTitle
    self.navigationItem.title = @"印象墙";
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = self.view.bounds;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //注册cell
    FFRegisterCellClass(tableView, FFDifferentWidthTagCell, FFDifferentWidthTagCellID);
    
    [self.view addSubview:tableView];
}

/***********************************懒加载***********************************/
#pragma mark - 懒加载
- (NSMutableArray<FFDifferentWidthTagModel *> *)dataSourceArr {
    if (_dataSourceArr == nil) {
        _dataSourceArr = [NSMutableArray array];
        for (int i = 0; i < 4; i++) {
            FFDifferentWidthTagModel *model = [FFDifferentWidthTagModel new];
            model.name = self.sectionHeaderTitleArr[i];
            
            //产生一个不为0的随机数
            int tagNum = 0;
            while (tagNum == 0) {
                tagNum = arc4random_uniform((int)self.tagArr.count);
            }
            NSMutableArray *tagsArrM = [NSMutableArray array];
            for (int j = 0; j < tagNum; j++) {
                int randomTagIndex = arc4random_uniform((int)self.tagArr.count);
                [tagsArrM addObject:self.tagArr[randomTagIndex]];
            }
            model.tagsArrM = tagsArrM;
            [_dataSourceArr addObject:model];
        }
    }
    return _dataSourceArr;
}

- (NSArray *)tagArr {
    if (_tagArr == nil) {
        _tagArr = @[
                    @"乖巧",
                    @"喜欢你",
                    @"纯洁",
                    @"好漂亮",
                    @"脱俗、大方、机灵",
                    @"淑女、秀外慧中、慧指兰心",
                    @"清水芙蓉、活泼机灵",
                    @"古怪、可爱",
                    @"乐观开朗",
                    @"嫁给我",
                    @"大义凛然",
                    @"母仪天下",
                    @"眉清目秀、可爱",
                    @"亭亭玉立",
                    @"闭月羞花",
                    @"楚楚动人",
                    @"国色天香",
                    @"花容月貌",
                    @"美如冠玉",
                    @"冰清玉洁",
                    @"尊重典雅",
                    @"温柔贤慧",
                    @"娴淑善良",
                    @"纤纤有礼",
                    @"上得厅房 下得厨房",
                    @"沉鱼落雁 委婉大方"
                    ];
    }
    return _tagArr;
}

- (NSArray *)sectionHeaderTitleArr {
    if (_sectionHeaderTitleArr == nil) {
        _sectionHeaderTitleArr = @[
                                   @"Abby",
                                   @"ever",
                                   @"Aimee",
                                   @"Alisa",
                                   @"Angelia",
                                   @"Amanda",
                                   @"Anne",
                                   @"Carrie",
                                   @"Cassie"
                                   ];
    }
    return _sectionHeaderTitleArr;
}

/***********************************UITableViewDataSource***********************************/
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSourceArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FFDifferentWidthTagCell *cell = [tableView dequeueReusableCellWithIdentifier:FFDifferentWidthTagCellID];
    cell.tagModel = self.dataSourceArr[indexPath.section];
    return cell;
}

/***********************************UITableViewDelegate***********************************/
#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    FFTableSectionHeaderView *headerView = [FFTableSectionHeaderView new];
    [headerView setTitleColor:[UIColor purpleColor]];
    FFDifferentWidthTagModel *model = self.dataSourceArr[section];
    headerView.title = [NSString stringWithFormat:@"对%@的印象",model.name];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 36;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    FFDifferentWidthTagModel *model = self.dataSourceArr[indexPath.section];
    return model.cellHeight;
}

@end

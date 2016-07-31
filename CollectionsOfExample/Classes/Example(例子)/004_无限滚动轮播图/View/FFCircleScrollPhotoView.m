//
//  FFCircleScrollPhotoView.m
//  CollectionsOfExample
//
//  Created by mac on 16/7/31.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFCircleScrollPhotoView.h"

//cell
#import "FFCircleScrollPhotoCell.h"

@interface FFCircleScrollPhotoView ()<UICollectionViewDelegate, UICollectionViewDataSource>

/** 图片数组 */
@property (nonatomic, strong) NSArray *imageNamesArr;

/** collectionView */
@property (nonatomic, weak) UICollectionView *collectionView;

/** 下标指示器 */
@property (nonatomic, strong) UIPageControl *pageControl;

/** 定时器 */
@property (nonatomic, strong) NSTimer *timer;

/** 换图时间 */
@property (nonatomic, assign) CGFloat timerInterVal;
@end

@implementation FFCircleScrollPhotoView

/** 快速实例化一个无限轮播图对象 */
+ (instancetype)circleScrollPhotoViewWithFrame:(CGRect)frame imageNames:(NSArray *)imageNames timerInterval:(CGFloat)timerInterval {
    
    FFCircleScrollPhotoView *view = [[FFCircleScrollPhotoView alloc] initWithFrame:frame];
    view.imageNamesArr = imageNames;
    view.pageControl.numberOfPages = imageNames.count; //共有几个点
    view.pageControl.currentPage = 0; //当前页面设置为第一个点
    view.timerInterVal = timerInterval;
    
    //让UICollectionView一开始就滑动到很后面
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:imageNames.count * 200 inSection:0];
    [view.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    [view startTimer]; //开始自动切换图片
    
    return view;
}



- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        
        //初始化UICollectionView
        [self setupCollectionView];
        
        //初始化下标指示器
        [self setupPageControl];
    }
    return self;
}

static NSString *const FFCircleScrollPhotoCellID = @"FFCircleScrollPhotoCell";

/** 初始化UICollectionView */
- (void)setupCollectionView {
    
    //创建布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置每个item的尺寸(每个cell的尺寸)
    layout.itemSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    //设置UICollectionView的滚动方法、设置成水平滚动
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //设置cell的水平、垂直方向的间距
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    //创建UICollectionView
    CGRect frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    collectionView.showsHorizontalScrollIndicator = NO; //隐藏水平指示条
    collectionView.showsVerticalScrollIndicator = NO; //隐藏垂直指示条
    collectionView.pagingEnabled = YES; //开启分页效果
    
    collectionView.dataSource = self;
    collectionView.delegate   = self;
    
    //注册cell
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([FFCircleScrollPhotoCell class]) bundle:nil] forCellWithReuseIdentifier:FFCircleScrollPhotoCellID];
    
    self.collectionView = collectionView;
    
    [self addSubview:collectionView];
}

/** 初始化下标指示器 */
- (void)setupPageControl {
    CGFloat height = 20;
    CGFloat width = self.frame.size.width;
    CGFloat x = 0;
    CGFloat y = self.frame.size.height - height;
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(x, y, width, height)];
    self.pageControl.pageIndicatorTintColor = [UIColor blueColor]; //设置普通状态下点的颜色
    self.pageControl.currentPageIndicatorTintColor = [UIColor yellowColor]; //设置指示点的颜色
    [self addSubview:self.pageControl];
}


/***********************************UICollectionViewDataSource*********************************/
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //返回一个非常大的数字、可以无限滚动、cell的缓存池机制，返回的多少不会影响性能
    return 10000000;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FFCircleScrollPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:FFCircleScrollPhotoCellID forIndexPath:indexPath];
    
    //cell 图片对应 图片数组 的下标（这个步骤一定要理解）
    NSInteger index = indexPath.item % self.imageNamesArr.count;
    cell.imageName = self.imageNamesArr[index];
    return cell;
}


/***********************************UICollectionViewDelegate***********************************/
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    FFCircleScrollPhotoCell *cell = (FFCircleScrollPhotoCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSLog(@"点击了图片--%@---在这里处理页面的跳转",cell.imageName);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    //提示：UICollectionView 继承UIScrollView ，所以UICollectionView会来到UIScrollView的代理方法
    //当手指将要滑动UICollectionView的时候，关闭自动切换图片的定时器
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    //当手指停止滑动UICollectionView的时候，开启自动切换图片的定时器
    [self startTimer];
}


/***********************************UIScrollViewDelegate***********************************/
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    //只要图切换到一半或者一般以上，指示器就显示下一个
    
    CGFloat offsetX = scrollView.contentOffset.x;

    /** 指示器的下标 */
    CGFloat indexFloat = offsetX / scrollView.frame.size.width;
    
    //刚好等于整数
    if (indexFloat == (NSInteger)indexFloat) {
        self.pageControl.currentPage = ((NSInteger)indexFloat) % self.imageNamesArr.count;
    }
    
    //不等于整数
    else {
        //举例   比如  indexFloat ＝ 2.4  则 minIndex ＝ 2  maxIndex = 3
        NSInteger minIndex = ((NSInteger)indexFloat);
        NSInteger maxIndex = ((NSInteger)indexFloat) + 1;
        //离maxIndex近
        if (ABS(indexFloat - minIndex) >= ABS(indexFloat - maxIndex)) {
            self.pageControl.currentPage = maxIndex % self.imageNamesArr.count;
        }
        
        //离minIndex近
        else {
            self.pageControl.currentPage = minIndex % self.imageNamesArr.count;
        }
    }
}


/***********************************定时器滚动处理***********************************/
#pragma mark - 定时器滚动处理
//开始定时
- (void)startTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.timerInterVal target:self selector:@selector(nextCell) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

//取消定时
- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
}

//展示下一个cell
- (void)nextCell {
    UICollectionViewCell *currentCell = [self.collectionView visibleCells].firstObject;
    NSIndexPath *currentIndexPath = [self.collectionView indexPathForCell:currentCell];
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:currentIndexPath.item + 1 inSection:currentIndexPath.section];
    [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:kNilOptions animated:YES];
}

@end

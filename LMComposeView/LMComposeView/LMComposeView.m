//
//  LMComposeView.m
//  LMComposeView
//
//  Created by Leesim on 2018/8/7.
//  Copyright © 2018年 LiMing. All rights reserved.
//

#import "LMComposeView.h"
#import "LMSegmentView.h"
#import "UIView+LMViewHelper.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define HEAD_HEIGHT (self.headerView.height +self.segmentView.height)

@interface LMComposeView ()<UIScrollViewDelegate>

/**
 自定义的headerView
 */
@property (nonatomic,strong) UIView * headerView;

/**
 添加底部的滚动视图的数据
 */
@property (nonatomic,strong) NSArray * scrollViewArray;

/**
 滚动视图的标题数据源
 */
@property (nonatomic,strong) NSArray * titleArray;
/**
 最底层的scrollView
 */
@property (nonatomic,strong) UIScrollView * backScrollView;
/**
 分类查询自定义view
 */
@property (nonatomic,strong) LMSegmentView * segmentView;
/**
 当前选中位置
 */
@property (nonatomic,assign) NSInteger currentIndex;

@end

@implementation LMComposeView

-(void)dealloc{
    
    for (UIScrollView * scrollView in self.scrollViewArray) {
        [scrollView removeObserver:self forKeyPath:@"contentOffset"];
    }
    
}

-(void)confirmComposeViewWithScrollViewArray:(NSArray *)scrollViewArray withSegmentButtonTitleArray:(NSArray*)titleArray withHeaderView:(UIView *)headerView withComposeViewFrame:(CGRect)composeViewFrame{
    
    NSAssert(scrollViewArray.count==titleArray.count, @"滚动视图的数据数量不等于标题数，请检查");
    
    self.scrollViewArray = scrollViewArray;
    self.titleArray = titleArray;
    self.headerView = headerView;
    self.frame = composeViewFrame;

    [self confirmUI];
    
}


-(void)confirmUI{
    //默认选中1
    self.currentIndex = 0;
    [self.backScrollView class];
    [self addSubview:self.headerView];
    [self addSubview:self.segmentView];
    
    __weak typeof(self) weakSelf = self;
    
    [self.scrollViewArray enumerateObjectsUsingBlock:^(UIScrollView * scrollView, NSUInteger idx, BOOL * _Nonnull stop) {
       
        scrollView.tag = 9000+idx;
        scrollView.frame = CGRectMake(SCREEN_WIDTH*idx, 0, weakSelf.width, weakSelf.height);
        [weakSelf.backScrollView addSubview:scrollView];
        
        if ([scrollView isKindOfClass:[UITableView class]]) {
            UITableView * tableView = (UITableView *)scrollView;
            if (tableView.tableHeaderView) {
                UIView * headerView = tableView.tableHeaderView;
                headerView.frame = (CGRect){0, 0, SCREEN_WIDTH, HEAD_HEIGHT};
                tableView.tableHeaderView = headerView;
            }else{
                UIView *headerView = [[UIView alloc] initWithFrame:(CGRect){0, 0, SCREEN_WIDTH, HEAD_HEIGHT}];
                tableView.tableHeaderView = headerView;
            }
        }else if ([scrollView isKindOfClass:[UICollectionView class]]){
            UICollectionView * collectionView = (UICollectionView *)scrollView;
            [collectionView.collectionViewLayout setValue:[NSValue valueWithUIEdgeInsets:[weakSelf getFixCollectionViewLayoutInsetWithInsetString:[NSString stringWithFormat:@"%@",[collectionView.collectionViewLayout valueForKey:@"sectionInset"]]]] forKey:@"sectionInset"];
        }
        
        [scrollView addObserver:weakSelf forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionInitial context:nil];
    }];
}

#pragma mark - KVO监听滚动的offset的变化

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([object tag]%9000!=self.self.currentIndex) return;
    if ([keyPath isEqualToString:@"contentOffset"]) {
        UIScrollView *scrollView = object;
        CGFloat contentOffsetY = scrollView.contentOffset.y;
        // 如果滑动没有超过临界值
        if (contentOffsetY < self.headerView.height) {
            // 让这几个个tableView的偏移量相等
            for (UIScrollView * allscrollView in self.scrollViewArray) {
                if (allscrollView.contentOffset.y != scrollView.contentOffset.y) {
                    allscrollView.contentOffset = scrollView.contentOffset;
                }
            }
            //动态修改y值
            self.headerView.y = -contentOffsetY;
            // 一旦大于等于临界值点了，让headerView的y值等于临界值点，就停留在上边了
            self.segmentView.y = self.headerView.height-contentOffsetY;
            
        }
        else if (contentOffsetY >= self.headerView.height) {
            self.headerView.y = -self.headerView.height;
            self.segmentView.y = 0;
            
        }
        
        [self reloadMaxOffsetY];
    }
}

-(UIEdgeInsets)getFixCollectionViewLayoutInsetWithInsetString:(NSString *)collectionViewInsetString{
    NSRange rightParenthesesRange = [collectionViewInsetString rangeOfString:@"{"];
    if (rightParenthesesRange.location == NSNotFound) return UIEdgeInsetsMake(0, 0, 0, 0);
    NSRange leftParenthesesRange = [collectionViewInsetString rangeOfString:@"}"];
    NSString * tempString = [collectionViewInsetString substringWithRange:NSMakeRange(rightParenthesesRange.location, leftParenthesesRange.location-rightParenthesesRange.location+1)];
    UIEdgeInsets  collectionSectionInset = UIEdgeInsetsFromString(tempString);
    return UIEdgeInsetsMake(collectionSectionInset.top+HEAD_HEIGHT, collectionSectionInset.left, collectionSectionInset.bottom, collectionSectionInset.right);
}


#pragma mark - scrollView Delegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/SCREEN_WIDTH;
    self.currentIndex = index;
    self.segmentView.scrollViewToSegmentIndex = index;
    [self reloadMaxOffsetY];
    if ([self.delegate respondsToSelector:@selector(composeViewDidClickSegementButtonWithIndex:)]) {
        [self.delegate composeViewDidClickSegementButtonWithIndex:index];
    }
}


// 刷新最大OffsetY，让三个tableView同步
- (void)reloadMaxOffsetY {
    //计算出最大偏移量
    CGFloat maxOffsetY = 0;
    for (UIScrollView *scrollView in self.scrollViewArray) {
        if (scrollView.contentOffset.y > maxOffsetY) {
            maxOffsetY = scrollView.contentOffset.y;
        }
    }
    // 如果最大偏移量大于顶部headerView的高度，处理下每个tableView的偏移量
    if (maxOffsetY > self.headerView.height) {
        for (UIScrollView * scrollView in self.scrollViewArray) {
            if (scrollView.contentOffset.y < self.headerView.height) {
                scrollView.contentOffset = CGPointMake(0, self.headerView.height);
            }
        }
    }
}


-(UIScrollView *)backScrollView{
    if (!_backScrollView) {
        _backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.height)];
        _backScrollView.delegate = self;
        _backScrollView.contentSize = CGSizeMake(self.scrollViewArray.count*SCREEN_WIDTH, self.height);
        _backScrollView.pagingEnabled = YES;
        _backScrollView.bounces = NO;
        _backScrollView.showsVerticalScrollIndicator = NO;
        _backScrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_backScrollView];
    }
    return _backScrollView;
}

-(LMSegmentView *)segmentView{
    if (!_segmentView) {
        _segmentView = [[LMSegmentView alloc]initWithTitleArray:self.titleArray withFrame:CGRectMake(0, self.headerView.height, SCREEN_WIDTH, 40)];
        __weak typeof(self) weakSelf = self;
        //点击到第几个分类
        [_segmentView setDidSelectSegmentWithIndexBlock:^(NSInteger index) {
            weakSelf.currentIndex = index;
            [weakSelf reloadMaxOffsetY];
            [weakSelf.backScrollView setContentOffset:CGPointMake(SCREEN_WIDTH*index, 0) animated:YES];
            if ([weakSelf.delegate respondsToSelector:@selector(composeViewDidClickSegementButtonWithIndex:)]) {
                [weakSelf.delegate composeViewDidClickSegementButtonWithIndex:index];
            }
        }];
    }
    return _segmentView;
}


@end

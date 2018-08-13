//
//  DemoController.m
//  LMComposeView
//
//  Created by Leesim on 2018/8/7.
//  Copyright © 2018年 LiMing. All rights reserved.
//

#import "DemoController.h"
#import "LMComposeView.h"
#import "LMTableView.h"
#import "LMCollectionView.h"
#import "LMHeaderView.h"
#import "UIView+LMViewHelper.h"


@interface DemoController ()<LMComposeViewDelegate>

@property(nonatomic,strong) LMComposeView * composeView;

@property (nonatomic,strong) LMHeaderView * headerView;

@end

@implementation DemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    NSMutableArray * scrollViewArray = [[NSMutableArray alloc]init];
    NSMutableArray * titleArray = [[NSMutableArray alloc]init];
    for (int i = 0; i<6; i++) {
        int x = i%2;
        if (x == 1) {
            LMTableView * tableView = [[LMTableView alloc]init];
            tableView.dataSourceCount = 20;
            [scrollViewArray addObject:tableView];
        }else{
            LMCollectionView * collectionView = [[LMCollectionView alloc]init];
            collectionView.dataSourceCount = 30;
            [scrollViewArray addObject:collectionView];
        }
        
        [titleArray addObject:[NSString stringWithFormat:@"滚动视图%d",i]];
    }
    
    [self.composeView confirmComposeViewWithScrollViewArray:scrollViewArray withSegmentButtonTitleArray:titleArray withHeaderView:self.headerView withComposeViewFrame:CGRectMake(0, 64,self.view.width, self.view.height-64)];
    
}

-(void)composeViewDidClickSegementButtonWithIndex:(NSInteger)index{
    
    NSLog(@"---滚动到了%ld---",(long)index);
}


-(LMComposeView *)composeView{
    if (!_composeView) {
        _composeView = [[LMComposeView alloc]init];
        _composeView.delegate = self;
        [self.view addSubview:_composeView];
    }
    return _composeView;
}

/**
 如果想要 headerview响应事件 则需要自定义一个HeaderView
 并且重写
 - (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
 判断后返回需要触发响应的view
 */
-(LMHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[LMHeaderView alloc]init];
        
        _headerView.frame = CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 200);
    }
    return _headerView;
}



@end

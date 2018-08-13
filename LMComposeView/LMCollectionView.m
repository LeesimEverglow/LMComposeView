//
//  LMCollectionView.m
//  LMComposeView
//
//  Created by Leesim on 2018/8/7.
//  Copyright © 2018年 LiMing. All rights reserved.
//

#import "LMCollectionView.h"

#define collectionID @"collectionview"

@interface LMCollectionView ()<UICollectionViewDataSource,UICollectionViewDelegate>


@end

@implementation LMCollectionView

- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(100, 100);
    layout.minimumInteritemSpacing = 10.0f;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self = [super initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 10) collectionViewLayout:layout];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        //注册cell
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:collectionID];
        
        self.delegate = self;
        self.dataSource = self;
        self.showsVerticalScrollIndicator = NO;
  
        self.dataSourceCount = 10;
    }
    return self;
}

-(void)setDataSourceCount:(int)dataSourceCount{
    _dataSourceCount = dataSourceCount;
    
    [self reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSourceCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}




@end

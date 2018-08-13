//
//  LMTableView.m
//  LMComposeView
//
//  Created by Leesim on 2018/8/7.
//  Copyright © 2018年 LiMing. All rights reserved.
//

#import "LMTableView.h"

#define cellID @"cell"

@interface LMTableView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation LMTableView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor clearColor];
        //注册
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
        
        self.delegate = self;
        self.dataSource = self;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.dataSourceCount = 10;
    }
    return self;
}

-(void)setDataSourceCount:(int)dataSourceCount{
    _dataSourceCount = dataSourceCount;
    
    [self reloadData];
}

#pragma mark - dataSouce
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceCount;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.textLabel.text =[NSString stringWithFormat:@"测试tableviewCell%p",self];
    
    return cell;
}

//cell高度
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}



@end

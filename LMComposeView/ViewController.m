//
//  ViewController.m
//  LMComposeView
//
//  Created by Leesim on 2018/8/7.
//  Copyright © 2018年 LiMing. All rights reserved.
//

#import "ViewController.h"
#import "DemoController.h"

@interface ViewController ()

@property (nonatomic,strong) UIButton * button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.button class];
    
}

-(void)pushAction{
    DemoController * VC = [[DemoController alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
}

-(UIButton *)button{
    if (!_button) {
        _button = [[UIButton alloc]init];
        _button.frame = CGRectMake(0, 0, 200, 50);
        _button.backgroundColor = [UIColor redColor];
        [_button setTitle:@"推出测试界面" forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(pushAction) forControlEvents:UIControlEventTouchUpInside];
        _button.center = self.view.center;
        [self.view addSubview:_button];
    }
    return _button;
}


@end

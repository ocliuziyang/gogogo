//
//  ViewController.m
//  0815_要出发筛选菜单
//
//  Created by LZY on 16/8/15.
//  Copyright © 2016年 github.com/ocliuziyang/gogogo. All rights reserved.
//

#import "ViewController.h"
#import "ZYSortView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initNavBar];
    
    ZYSortView *sortView = [[ZYSortView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH_ZY, 45) withMenuCount:3];
    [self.view addSubview:sortView];
    
}

- (void)initNavBar {
    UIView *navBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH_ZY, 64)];
    navBar.backgroundColor = [UIColor colorWithRed:0.18 green:0.80 blue:0.44 alpha:1.00];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH_ZY, 44)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"筛选菜单";
    [navBar addSubview:titleLabel];
    [self.view addSubview:navBar];
    
}

@end

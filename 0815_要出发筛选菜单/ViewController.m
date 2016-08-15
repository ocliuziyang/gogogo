//
//  ViewController.m
//  0815_要出发筛选菜单
//
//  Created by LZY on 16/8/15.
//  Copyright © 2016年 github.com/ocliuziyang/gogogo. All rights reserved.
//

#import "ViewController.h"
#import "ZYSortView.h"

#define keyTitle @"keyTitle"
#define keyOrderBy @"OrderBy"

@interface ViewController ()

@property (nonatomic, strong)NSArray *menuDataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initNavBar];
    
    ZYSortView *sortView = [[ZYSortView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH_ZY, 45) withMenuCount:3 menuDataArray:self.menuDataSource];
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

//菜单数据源
- (NSArray *)menuDataSource {
    
    if (!_menuDataSource) {
        _menuDataSource = @[
                            @[
                                @{
                                    keyTitle : @"智能排序",
                                    keyOrderBy : @0,//推荐
                                    },
                                @{
                                    keyTitle : @"销量优先",
                                    keyOrderBy : @1,//
                                    },
                                @{
                                    keyTitle : @"最近更新",
                                    keyOrderBy : @2,//
                                    },
                                @{
                                    keyTitle : @"价格最低",
                                    keyOrderBy : @3,//
                                    }
                                ],
                            
                            @[
                                //旅游方式
                                @{
                                    keyTitle : @"全部分类",
                                    keyOrderBy : @0,
                                    },
                                @{
                                    keyTitle : @"跟团旅游",
                                    keyOrderBy : @1,
                                    },
                                @{
                                    keyTitle : @"半自由行",
                                    keyOrderBy : @2,
                                    },
                                @{
                                    keyTitle : @"高端定制",
                                    keyOrderBy : @3,
                                    },
                                ],
                            
                            @[
                                @{
                                    keyTitle : @"筛选",
                                    }
                                ],
                            
                            ];
    }
    
    
    return _menuDataSource;
}




@end

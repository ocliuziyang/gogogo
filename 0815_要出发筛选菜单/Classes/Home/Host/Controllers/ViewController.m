//
//  ViewController.m
//  0815_要出发筛选菜单
//
//  Created by LZY on 16/8/15.
//  Copyright © 2016年 github.com/ocliuziyang/gogogo. All rights reserved.
//

#import "ViewController.h"
#import "ZYSortView.h"
#import "ProductCell.h"
#import "Product.h"
#import "AnalogData.h"
#import "DateHelper.h"

#define keyTitle @"keyTitle"
#define keyOrderBy @"OrderBy"
#define kListCount 20

#define keyID @"keyID"
#define keyMinPrice @"keyMinPrice"
#define keyMaxPrice @"keyMaxPrice"
@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, ZYSortViewDelegate>

@property (nonatomic, strong)NSArray *dataArray;

@property (nonatomic, strong)NSArray *menuDataSource;

@end

@implementation ViewController {
    UITableView *_tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    [self initView];
    
    ZYSortView *sortView = [[ZYSortView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH_ZY, 44) withMenuCount:3 menuDataArray:self.menuDataSource];
    [self.view addSubview:sortView];//先添加到self,再设置代理,顺序不能乱
    sortView.delegate = self;
    
    sortView.customView.selectedIndexPahtsBlock = ^(NSIndexPath *indexPathFirstRadio,
                                                    NSIndexPath *indexPathSecRadio,
                                                    NSMutableSet *indexPathSet,
                                                    NSIndexPath *indexPathFourthRadio) {
        
        NSLog(@"%@-%@-%@-%@", indexPathFirstRadio, indexPathSecRadio, indexPathSet, indexPathFourthRadio);
        
    };
   
    
}

- (void)initView {
    [self initNavBar];
    [self initTableView];
}

- (void)initTableView {
    CGFloat tableViewHeight = 64 + 44;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, tableViewHeight, SCREEN_WIDTH_ZY, SCREEN_HEIGHT_ZY - tableViewHeight) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    _tableView.rowHeight = 80;

    [self.view addSubview:_tableView];
    
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

#pragma mark - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * const cellIdentifier = @"cell";
    
    ProductCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[ProductCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    Product *model = self.dataArray[indexPath.row];
    cell.model = model;
    
    return cell;
}

#pragma mark - TableView Delegate


#pragma mark - ZYSortViewDelegate
- (void)sortView:(ZYSortView *)sortView didSelected:(ZYIndexPath *)indexPath {
    
    NSLog(@"点击了%ld个, %ld行", indexPath.column, indexPath.row);
    
}

#pragma mark - Getter
//当前产品列表模拟数据源
- (NSArray *)dataArray {
    NSMutableArray *_tempArr = [NSMutableArray new];
    if (!_dataArray) {
        
        for (int i = 0; i < kListCount; i++) {
            Product *model = [[Product alloc]init];
            model.title = [AnalogData randomTitle];
            model.iconName = [AnalogData randomImageName];
            [_tempArr addObject:model];
        }
        _dataArray = [_tempArr mutableCopy];
    }
    return _dataArray;
}

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
                                //出发城市
                                @{
                                    @"title" : @"出发城市(单选)",
                                    @"imageName" : @"emoji_sent_city",
                                    @"data" :  @[@{
                                                     keyTitle : @"全部",
                                                     keyID : @0,
                                                     },
                                                 @{
                                                     keyTitle : @"北京",
                                                     keyID : @401,
                                                     },
                                                 @{
                                                     keyTitle : @"上海",
                                                     keyID : @402,
                                                     },
                                                 @{
                                                     keyTitle : @"杭州",
                                                     keyID : @753,
                                                     }]
                                    },
                                @{
                                    @"title" : @"出发日期(单选)",
                                    @"imageName" : @"emoji_sent_time",
                                    @"data" :  [DateHelper dateHelperGetCurrentMonthAndLater:[NSDate date]],
                                    },
                                
                                @{
                                    @"title" : @"游玩天数(多选)",
                                    @"imageName" : @"emoji_travel_days",
                                    @"data" :  @[@{
                                                     keyTitle : @"不限",
                                                     keyID : @"0,",
                                                     },
                                                 @{
                                                     keyTitle : @"2日",
                                                     keyID : @"2,",
                                                     },
                                                 @{
                                                     keyTitle : @"3日",
                                                     keyID : @"3,",
                                                     },
                                                 @{
                                                     keyTitle : @"4日",
                                                     keyID : @"4,",
                                                     },
                                                 @{
                                                     keyTitle : @"5日",
                                                     keyID : @"5,",
                                                     },
                                                 @{
                                                     keyTitle : @"6日",
                                                     keyID : @"6,",
                                                     },@{
                                                     keyTitle : @"7日",
                                                     keyID : @"7,",
                                                     },@{
                                                     keyTitle : @"8日",
                                                     keyID : @"8,",
                                                     },
                                                 @{
                                                     keyTitle : @"9日",
                                                     keyID : @"9,",
                                                     },
                                                 @{
                                                     keyTitle : @"10日",
                                                     keyID : @"10,",
                                                     },
                                                 @{
                                                     keyTitle : @"10日以上",
                                                     keyID : @"101,",
                                                     }],
                                    },
                                @{
                                    @"title" : @"价格区间¥(单选)",
                                    @"imageName" : @"emoji_price_range",
                                    @"data" :  @[@{
                                                     keyTitle : @"不限",
                                                     keyMinPrice : @0,
                                                     keyMaxPrice : @0
                                                     },
                                                 @{
                                                     keyTitle : @"200-500",
                                                     keyMinPrice : @200,
                                                     keyMaxPrice : @500
                                                     },
                                                 @{
                                                     keyTitle : @"500-1000",
                                                     keyMinPrice : @500,
                                                     keyMaxPrice : @1000
                                                     },
                                                 @{
                                                     keyTitle : @"1000-2000",
                                                     keyMinPrice : @1000,
                                                     keyMaxPrice : @2000
                                                     },
                                                 @{
                                                     keyTitle : @"2000-3000",
                                                     keyMinPrice : @2000,
                                                     keyMaxPrice : @3000
                                                     },
                                                 @{
                                                     keyTitle : @"3000-5000",
                                                     keyMinPrice : @3000,
                                                     keyMaxPrice : @5000
                                                     },
                                                 @{
                                                     keyTitle : @"5000-10000",
                                                     keyMinPrice : @5000,
                                                     keyMaxPrice : @10000
                                                     },
                                                 @{
                                                     keyTitle : @"10000-20000",
                                                     keyMinPrice : @10000,
                                                     keyMaxPrice : @20000
                                                     },
                                                 @{
                                                     keyTitle : @"20000以上",
                                                     keyMinPrice : @20000,
                                                     keyMaxPrice : @0
                                                     },
                                                 ]
                                    }]
                            
                            ];
    }
    
    
    return _menuDataSource;
}




@end

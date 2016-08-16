//
//  ZYSortView.m
//  0815_要出发筛选菜单
//
//  Created by LZY on 16/8/15.
//  Copyright © 2016年 github.com/ocliuziyang/gogogo. All rights reserved.
//

#import "ZYSortView.h"

@implementation ZYSortBar {
    NSInteger _menuCount;
}

- (instancetype)initWithFrame:(CGRect)frame withMenuCount:(NSInteger)menuCount{
    self = [super initWithFrame:frame];
    if (self) {
        
        //初始化
        _menuCount = menuCount;
        _currentSelectedIndex = -1;
        _isShow = NO;
        
       NSArray *_titleArray = @[@"推荐排序", @"全部分类", @"筛选", @"请添加", @"请添加"];
        
        for (int i = 0; i < menuCount; i++) {
            ZYSortMenuButton *menuBtn = [ZYSortMenuButton buttonWithType:UIButtonTypeCustom];
            [menuBtn addSplitLine];
            //菜单按钮宽度
            CGFloat menuBtnWidth = self.frame.size.width / menuCount;
            
            menuBtn.frame = CGRectMake(i * menuBtnWidth, 0, self.frame.size.width / menuCount, self.frame.size.height);
            menuBtn.tag = 100 + i;//设置tag标记
            //添加点击事件
            [menuBtn addTarget:self action:@selector(menuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [menuBtn setSelectStatus:ButtonSelectTypeNormal];
            
            //按钮标题
            //设置按钮标题
            
            [menuBtn setTitle:_titleArray[i] forState:UIControlStateNormal];
            
            if (i == menuCount - 1) {
                menuBtn.splitLine.hidden = YES;
            }
            
            [self addSubview:menuBtn];
        }
        //添加分割线
        [self separation];
        
    }
    return self;
}

//响应menuBtn的点击事件
- (void)menuBtnClick:(ZYSortMenuButton *)menuBtn {
    NSInteger index = menuBtn.tag - 100;
    
    
    //如果当前点击选中的 和 之前显示的是 同一个位置的话
    if(_currentSelectedIndex == index) {
        
        self.clickMenuBlock(index);//self为ZYSortBar
        
        //如果已经显示
        if (_isShow) {
            //这里应该让当前的 按钮隐藏状态
            [menuBtn setSelectStatus:ButtonSelectTypeNormal];
            _isShow = NO;
        } else {
            [menuBtn setSelectStatus:ButtonSelectTypeSelected];
            _isShow = YES;
        }
        
        
        _currentSelectedIndex = -1;
    } else {
        
        switch (index) {
            case 0:
            {
                
                [self setSelectedMenuBtn:menuBtn];
                //单选cell
                //点击回调, 在ZYSortView回调实现
                ClickMenuBtnType type = ClickMenuBtnTypeFirst;
                self.clickMenuBlock(type);//self为ZYSortBar
                
            }
                break;
            case 1:
            {
                [self setSelectedMenuBtn:menuBtn];
                //点击回调, 在ZYSortView回调实现
                ClickMenuBtnType type = ClickMenuBtnTypeSec;
                self.clickMenuBlock(type);
                
                //单选cell
            }
                break;
            case 2:
            {
                [self setSelectedMenuBtn:menuBtn];
                //点击回调, 在ZYSortView回调实现
                ClickMenuBtnType type = ClickMenuBtnTypeThird;
                self.clickMenuBlock(type);
               
                //多选
            }
                break;
                
            default:
                break;
        }
        //当前正在有按钮显示中
         _isShow = YES;
        //记录点击的按钮
        _currentSelectedIndex = index;
    }
    
    

}


//只选中当前点击的, 其他的恢复灰色
- (void)setSelectedMenuBtn:(ZYSortMenuButton *)menuBtn {
    
    
    for (int i = 0; i < _menuCount; i++) {
       ZYSortMenuButton *menu = [self viewWithTag:(i+100)];
         [menu setSelectStatus:ButtonSelectTypeNormal];
    }
    [menuBtn setSelectStatus:ButtonSelectTypeSelected];
}

//添加横向分割线
- (void)separation {
    
    CGFloat lineWidth = 1;
    
    UIView *headerLine  =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH_ZY, lineWidth)];
    headerLine.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
    [self addSubview:headerLine];
    
    UIView *footerLine  =[[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - lineWidth, SCREEN_WIDTH_ZY, lineWidth)];
    footerLine.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
    [self addSubview:footerLine];
    
}

@end

/**############### 选项视图 ZYSortMenuView   ###################**/
#define keyTitle @"keyTitle"
#define keyOrderBy @"OrderBy"
static NSString * const sortMenuCell = @"ZYSortMenuViewCell";
@interface ZYSortMenuView ()

@end

@implementation ZYSortMenuView {
    
    NSArray *_dataSource;
}

- (instancetype)initWithFrame:(CGRect)frame withMenuType:(MenuType)menuType menuDataArray:(NSArray *)menuDataArray{
    if (self = [super initWithFrame:frame]) {
        _tableView = [[UITableView alloc]init];
        [self addSubview:_tableView];
        _dataSource = menuDataArray;
        _tableView.bounces = YES;
        _tableView.tableFooterView = [UIView new];
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:sortMenuCell];
        
        
        
        
    }
    return self;
}


- (void)layoutSubviews {
    CGFloat tabelViewH = [_dataSource[0] count] * 45;
    _tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH_ZY, tabelViewH);
    
}
#pragma -mark Setter
- (void)setDelegate:(id<ZYSortMenuViewDelegate>)delegate {
    _delegate = delegate;
    if (_delegate && [_delegate respondsToSelector:@selector(sortMenuView:didSelected:)]) {
//        _delegate sortMenuView:self didSelected:<#(NSInteger)#>
    }
}



@end


/**###############  ZYSortView   ###################**/
#define keyTitle @"keyTitle"
#define keyOrderBy @"OrderBy"
@interface ZYSortView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)ZYSortMenuView *sortMenuView;
@property (nonatomic, strong)NSArray *dataarray;
@property (nonatomic, strong)UIView *maskView;

@end

@implementation ZYSortView {
    //记录当前点击位置
    ClickMenuBtnType _currentClickMenuBtnType;
    
}

- (instancetype)initWithFrame:(CGRect)frame withMenuCount:(NSInteger)count menuDataArray:(NSArray *)dataArray{
    
    if (self = [super initWithFrame:frame]) {
  
        //初始化记录点击位置
        _currentClickMenuBtnType = -1;
        _dataarray = dataArray;
        _sortBar = [[ZYSortBar alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44) withMenuCount:count];
        [self addSubview:_sortBar];
        
        _sortMenuView = [[ZYSortMenuView alloc] initWithFrame:CGRectMake(0, 108, SCREEN_WIDTH_ZY, SCREEN_HEIGHT_ZY - 108) withMenuType:MenuTypeTableView menuDataArray:_dataarray];
        //一个点击tap事件
        
        _sortMenuView.tableView.dataSource = self;
        _sortMenuView.tableView.delegate = self;
        
        [self addMaskView];
        
        //弱引用
        __weak typeof(self) weakSelf = self;
        _sortBar.clickMenuBlock = ^(ClickMenuBtnType menuBtnType) {
            //点击了  那个菜单按钮
            NSLog(@"点击了%ld", menuBtnType);
            //这里来判断点击的时候如果 重复点击的是当前视图
            if (_currentClickMenuBtnType == menuBtnType) {
                weakSelf.sortMenuView.hidden = !weakSelf.sortMenuView.hidden;
            } else {
                //当前视图正在显示, 又去点击其他视图
                weakSelf.sortMenuView.hidden = NO;
                _currentClickMenuBtnType = menuBtnType;
            }
            
            
//            数据源更换
            switch (menuBtnType) {
                case ClickMenuBtnTypeFirst:
                {
                    
                    weakSelf.dataarray = dataArray[0];
                   
                }
                    break;
                case ClickMenuBtnTypeSec:
                {
                    weakSelf.dataarray = dataArray[1];
                  
                }
                    break;
                case ClickMenuBtnTypeThird:
                {
                    weakSelf.dataarray = dataArray[2];
                    
                }
                    break;
                    
                default:
                    break;
            }
            
            [weakSelf.sortMenuView.tableView reloadData];
            weakSelf.maskView.frame = CGRectMake(0, CGRectGetMaxY(weakSelf.sortMenuView.tableView.frame), SCREEN_WIDTH_ZY, SCREEN_HEIGHT_ZY - CGRectGetMaxY(self.sortMenuView.tableView.frame));
        };
        
  
        
      
    }
    return self;
}

- (void) addMaskView{
    //添加蒙版
    UIView *maskView = [[UIView alloc]initWithFrame:CGRectZero];
    maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenSortMenuView:)];
    [maskView addGestureRecognizer:tap];
    
    self.maskView = maskView;
    [self.sortMenuView addSubview:self.maskView];
}

//移除蒙版
- (void)hiddenSortMenuView:(UITapGestureRecognizer *)tap {
    
    //恢复菜单按钮选中色
    [self recoverSortBarBtnStatus];
    self.sortMenuView.hidden = YES;
    
}

//恢复按钮选中颜色
- (void)recoverSortBarBtnStatus {
    
    _sortBar.isShow = NO;
    for (UIView *subView in self.sortBar.subviews) {
        if ([subView isKindOfClass:[ZYSortMenuButton class]]) {
            ZYSortMenuButton *btn = (ZYSortMenuButton *)subView;
            [btn setSelectStatus:ButtonSelectTypeNormal];
        }
    }
    
    
    
}


#pragma mark - Setter
- (void)setDelegate:(id<ZYSortViewDelegate>)delegate {

    _delegate = delegate;
    if (_delegate) {
    
        [self.superview addSubview:_sortMenuView];
        //初始逻辑应该先隐藏菜单
        _sortMenuView.hidden = YES;
        
        
    }

}


#pragma mark - UITableView DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataarray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sortMenuCell];
    

    //menu菜单title赋值
    cell.textLabel.text = @"";
    id menuDict = self.dataarray[indexPath.row];
    if ([menuDict isKindOfClass:[NSDictionary class]]) {
        cell.textLabel.text = menuDict[keyTitle];
    }
    
    
    return cell;
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //恢复菜单按钮选中色
    [self recoverSortBarBtnStatus];
    
    self.sortMenuView.hidden = YES;
        NSString *title = [self.dataarray[indexPath.row] objectForKey:keyTitle];
    
    for (UIView *subView in self.sortBar.subviews) {
        if (subView.tag == 100 + _currentClickMenuBtnType) {
            ZYSortMenuButton *btn = (ZYSortMenuButton *)subView;
            [btn setTitle:title forState:UIControlStateNormal];
        }
    }

    
    
    
}



@end

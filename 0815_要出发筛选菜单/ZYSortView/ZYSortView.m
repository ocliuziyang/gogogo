//
//  ZYSortView.m
//  0815_要出发筛选菜单
//
//  Created by LZY on 16/8/15.
//  Copyright © 2016年 github.com/ocliuziyang/gogogo. All rights reserved.
//

#import "ZYSortView.h"

@implementation ZYSortBar {
    //当前选中的按钮
    NSInteger _currentSelectedIndex;
    //是否有 按钮处于正在显示状态
    BOOL _isShow;
    NSInteger _menuCount;
}

- (instancetype)initWithFrame:(CGRect)frame withMenuCount:(NSInteger)menuCount{
    self = [super initWithFrame:frame];
    if (self) {
        
        //初始化
        _menuCount = menuCount;
        _currentSelectedIndex = -1;
        _isShow = NO;
        for (int i = 0; i < menuCount; i++) {
            ZYSortMenuButton *menuBtn = [ZYSortMenuButton buttonWithType:UIButtonTypeCustom];
            
            //菜单按钮宽度
            CGFloat menuBtnWidth = self.frame.size.width / menuCount;
            
            menuBtn.frame = CGRectMake(i * menuBtnWidth, 0, self.frame.size.width / menuCount, self.frame.size.height);
            menuBtn.tag = 100 + i;//设置tag标记
            //添加点击事件
            [menuBtn addTarget:self action:@selector(menuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [menuBtn setSelectStatus:ButtonSelectTypeNormal];
            
            //按钮标题
            //设置按钮标题
            [menuBtn setTitle:@"推荐排序" forState:UIControlStateNormal];
            
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
        
        //这里应该让当前的 按钮隐藏状态
        [menuBtn setSelectStatus:ButtonSelectTypeNormal];
        
        _isShow = NO;
        _currentSelectedIndex = -1;
    } else {
        
        switch (index) {
            case 0:
            {
                
                [self setSelectedMenuBtn:menuBtn];
                //单选cell
            }
                break;
            case 1:
            {
                [self setSelectedMenuBtn:menuBtn];
                
                //单选
            }
                break;
            case 2:
            {
                [self setSelectedMenuBtn:menuBtn];
               
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

//添加分割线
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
/**###############  ZYSortView   ###################**/
@implementation ZYSortView {
    UITableView *_tableView;
    ZYSortBar *_sortBar;
}

- (instancetype)initWithFrame:(CGRect)frame withMenuCount:(NSInteger)count{
    
    if (self = [super initWithFrame:frame]) {
        _sortBar = [[ZYSortBar alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44) withMenuCount:count];
        [self addSubview:_sortBar];
        
        
        
    }
    return self;
}





@end

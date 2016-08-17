//
//  ZYSortView.h
//  0815_要出发筛选菜单
//
//  Created by LZY on 16/8/15.
//  Copyright © 2016年 github.com/ocliuziyang/gogogo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYSortMenuButton.h"
#import "ZYMenuRadioCell.h"

#define SCREEN_WIDTH_ZY [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT_ZY [UIScreen mainScreen].bounds.size.height

/*##########   ZYSortBar   ###############*/

typedef NS_ENUM(NSInteger, ClickMenuBtnType) {
    ClickMenuBtnTypeFirst,
    ClickMenuBtnTypeSec,
    ClickMenuBtnTypeThird,
};

typedef void(^ClickMenuBlock)(ClickMenuBtnType menuBtnType);
@interface ZYSortBar : UIView
//当前选中的按钮
@property (nonatomic, assign) NSInteger currentSelectedIndex;
//是否有 按钮处于正在显示状态
@property (nonatomic, assign) BOOL isShow;
//点击菜单按钮回调
@property (nonatomic, copy)ClickMenuBlock clickMenuBlock;
- (instancetype)initWithFrame:(CGRect)frame withMenuCount:(NSInteger)menuCount;
- (void)recoverSortBarBtnStatus;

@end


/*##########   ZYSortMenuView   ###############*/
typedef NS_ENUM(NSInteger, MenuType) {
    MenuTypeTableView,
    MenuTypeCollection
};
@class ZYSortMenuView;
@protocol ZYSortMenuViewDelegate <NSObject>

- (void)sortMenuView:(ZYSortMenuView *)menuView didSelected:(NSInteger)index;

@end
@interface ZYSortMenuView : UIView
@property(nonatomic, strong)UITableView *tableView;

@property (nonatomic, weak)id <ZYSortMenuViewDelegate>delegate;
- (instancetype)initWithFrame:(CGRect)frame withMenuType:(MenuType)menuType menuDataArray:(NSArray *)menuDataArray;
@end

/*###########   ZYIndexPath      ###########*/
@interface ZYIndexPath : NSObject
//回调方法中说明 点击的位置
@property (nonatomic, assign)NSInteger column;
@property (nonatomic, assign)NSInteger row;
- (instancetype)initWitCol:(NSInteger)col row:(NSInteger)row;
+ (instancetype)indexPathWitCol:(NSInteger)col row:(NSInteger)row;
@end

/*###########   ZYSortView      ###########*/
@class ZYSortView;
@protocol ZYSortViewDelegate <NSObject>

@optional
-(void)sortView:(ZYSortView *)sortView didSelected:(ZYIndexPath *)indexPath;

@end

@interface ZYSortView : UIView
@property (nonatomic, strong)ZYSortBar *sortBar;
@property (nonatomic, weak)id <ZYSortViewDelegate>delegate;
- (instancetype)initWithFrame:(CGRect)frame withMenuCount:(NSInteger)count menuDataArray:(NSArray *)dataArray;


@end

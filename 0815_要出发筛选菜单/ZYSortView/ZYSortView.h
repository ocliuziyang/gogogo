//
//  ZYSortView.h
//  0815_要出发筛选菜单
//
//  Created by LZY on 16/8/15.
//  Copyright © 2016年 github.com/ocliuziyang/gogogo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYSortMenuButton.h"

#define SCREEN_WIDTH_ZY [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT_ZY [UIScreen mainScreen].bounds.size.height

@interface ZYSortBar : UIView
- (instancetype)initWithFrame:(CGRect)frame withMenuCount:(NSInteger)menuCount;
@end

@interface ZYSortMenuView : UIView

@end

@interface ZYSortView : UIView
- (instancetype)initWithFrame:(CGRect)frame withMenuCount:(NSInteger)count;
@end

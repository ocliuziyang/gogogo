//
//  ZYSortMenuButton.h
//  0815_要出发筛选菜单
//
//  Created by LZY on 16/8/15.
//  Copyright © 2016年 github.com/ocliuziyang/gogogo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ButtonSelectType) {
    ButtonSelectTypeNormal = 0,
    ButtonSelectTypeSelected = 1
};

@interface ZYSortMenuButton : UIButton
- (void)setSelectStatus:(ButtonSelectType)buttonSelectedType;


@end

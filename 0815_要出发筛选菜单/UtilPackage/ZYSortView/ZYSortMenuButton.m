//
//  ZYSortMenuButton.m
//  0815_要出发筛选菜单
//
//  Created by LZY on 16/8/15.
//  Copyright © 2016年 github.com/ocliuziyang/gogogo. All rights reserved.
//

#import "ZYSortMenuButton.h"



@implementation ZYSortMenuButton 
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



- (void)setSelectStatus:(ButtonSelectType)buttonSelectedType {
    
    if (buttonSelectedType == ButtonSelectTypeNormal) {
       //未选中

        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        self.titleLabel.textColor = [UIColor grayColor];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.imageView.image = [UIImage imageNamed:@"sort_menu_arrow_normal"];
    
    } else {
        //选中按钮 样式
//        self.titleLabel.textColor = [UIColor colorWithRed:0.18 green:0.80 blue:0.44 alpha:1.00];
        [self setTitleColor:[UIColor colorWithRed:0.18 green:0.80 blue:0.44 alpha:1.00] forState:UIControlStateNormal   ];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.imageView.image = [UIImage imageNamed:@"sort_menu_arrow_selected"];
    }
}

- (void)layoutSubviews {
    //重写image和label的布局
    CGFloat imageW = 10;
    CGFloat imageH = 5;
    CGFloat margin = 35;
    CGFloat imageX = self.bounds.size.width - margin;
    CGFloat imageY = (self.bounds.size.height - 5) / 2.f;
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    self.titleLabel.frame = CGRectMake(0, 0, self.bounds.size.width - margin, self.bounds.size.height);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    CGFloat splitLineY = 8;
    _splitLine.frame = CGRectMake(self.bounds.size.width - 2, splitLineY, 0.8, self.bounds.size.height - splitLineY * 2);
    
    
}

//add添加竖向分割线
- (void)addSplitLine {
    //添加分割线
    _splitLine = [UIView new];
    _splitLine.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_splitLine];
}

//最后一个btn需要隐藏分割线
- (void)hiddenSplitline {
    _splitLine.hidden = YES;
}

@end

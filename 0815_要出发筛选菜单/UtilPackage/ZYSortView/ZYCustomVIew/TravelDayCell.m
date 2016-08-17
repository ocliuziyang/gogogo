//
//  TravelDayCell.m
//  0816_collectionView
//
//  Created by LZY on 16/8/16.
//  Copyright © 2016年 github.com/ocliuziyang/gogogo. All rights reserved.
//

#import "TravelDayCell.h"

@implementation TravelDayCell

- (void)awakeFromNib {
    // Initialization code
    if (_isSelected) {
        [self setStatus:YES];
    } else {
        [self setStatus:NO];
    }
    
}

//如果点击选中这就 高亮绿色
- (void)setStatus:(BOOL)isSelected{
    
    if (isSelected) {
        _titleLabel.textColor = [UIColor colorWithRed:0.22 green:0.81 blue:0.47 alpha:1.00];
        _titleLabel.layer.masksToBounds = YES;
        _titleLabel.layer.cornerRadius = 3;
        _titleLabel.layer.borderColor = [UIColor colorWithRed:0.22 green:0.81 blue:0.47 alpha:1.00].CGColor;
        _titleLabel.layer.borderWidth = 1;
    } else {
        _titleLabel.textColor = [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00];
        _titleLabel.layer.masksToBounds = YES;
        _titleLabel.layer.cornerRadius = 3;
        _titleLabel.layer.borderColor = [UIColor colorWithRed:0.82 green:0.82 blue:0.82 alpha:1.00].CGColor;
        _titleLabel.layer.borderWidth = 1;
    }
    _isSelected = isSelected;
}

@end

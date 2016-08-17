//
//  ZYMenuRadioCell.m
//  0815_要出发筛选菜单
//
//  Created by LZY on 16/8/16.
//  Copyright © 2016年 github.com/ocliuziyang/gogogo. All rights reserved.
//

#import "ZYMenuRadioCell.h"

@implementation ZYMenuRadioCell

- (void)awakeFromNib {
    // Initialization code
    [self setCellSelectedStatus:NO];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellSelectedStatus:(BOOL)selected {
    
    if (selected) {
        _titleLabel.textColor = [UIColor colorWithRed:0.22 green:0.81 blue:0.47 alpha:1.00];
        _selectedImgView.hidden = NO;
    } else {
        _titleLabel.textColor = [UIColor colorWithRed:0.55 green:0.55 blue:0.55 alpha:1.00];
        _selectedImgView.hidden = YES;
    }
}

@end

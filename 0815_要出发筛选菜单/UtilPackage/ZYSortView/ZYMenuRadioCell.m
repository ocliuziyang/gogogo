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
    _selectedImgView.hidden = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

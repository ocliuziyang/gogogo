//
//  CityCell.m
//  0816_collectionView
//
//  Created by LZY on 16/8/16.
//  Copyright © 2016年 github.com/ocliuziyang/gogogo. All rights reserved.
//

#import "CityCell.h"

@implementation CityCell

- (void)awakeFromNib {
    // Initialization code
    [self setCellSelectedStatus:NO];
    
}

//设置选中状态
- (void)setCellSelectedStatus:(BOOL)selected {
    
    if (selected) {
        
        _titleLabel.textColor = [UIColor colorWithRed:0.22 green:0.81 blue:0.47 alpha:1.00];
        _imgView.image = [UIImage imageNamed:@"muti_cell_s"];
        
        
    } else {
        
        _titleLabel.textColor = [UIColor colorWithRed:0.68 green:0.68 blue:0.68 alpha:1.00];
        _imgView.image = [UIImage imageNamed:@"muti_cell_n"];
    }
    //记录当前选中状态
    
}

@end

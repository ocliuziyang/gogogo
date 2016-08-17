//
//  ZYMenuRadioCell.h
//  0815_要出发筛选菜单
//
//  Created by LZY on 16/8/16.
//  Copyright © 2016年 github.com/ocliuziyang/gogogo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYMenuRadioCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *selectedImgView;

- (void)setCellSelectedStatus:(BOOL)selected;

@end

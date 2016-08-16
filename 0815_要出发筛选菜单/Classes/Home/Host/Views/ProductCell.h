//
//  ProductCell.h
//  0815_要出发筛选菜单
//
//  Created by LZY on 16/8/15.
//  Copyright © 2016年 github.com/ocliuziyang/gogogo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@interface ProductCell : UITableViewCell

@property (nonatomic, strong)UIImageView *iconView;
@property (nonatomic, strong)UILabel *titleLabel;

@property (nonatomic, strong)Product *model;
@end

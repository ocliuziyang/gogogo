//
//  ProductCell.m
//  0815_要出发筛选菜单
//
//  Created by LZY on 16/8/15.
//  Copyright © 2016年 github.com/ocliuziyang/gogogo. All rights reserved.
//

#import "ProductCell.h"



@implementation ProductCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUIView];
    }
    return self;
}

- (void)setupUIView {
    CGFloat margin = 15;
    _iconView = [[UIImageView alloc]initWithFrame:CGRectMake(margin, 10, 60, 60)];
    [self.contentView addSubview:_iconView];
    
    CGFloat titleLabelX = margin + CGRectGetMaxX(_iconView.frame);
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(titleLabelX, 0, [UIScreen mainScreen].bounds.size.width - titleLabelX, self.contentView.bounds.size.height)];
    [self.contentView addSubview:_titleLabel];
}

- (void)awakeFromNib {
    // Initialization code
   
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(Product *)model {
    _model = model;
    _titleLabel.text = model.title;
    _iconView.image = [UIImage imageNamed:model.iconName];
}

@end

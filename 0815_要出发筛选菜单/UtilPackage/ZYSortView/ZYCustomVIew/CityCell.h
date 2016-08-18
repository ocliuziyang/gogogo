//
//  CityCell.h
//  0816_collectionView
//
//  Created by LZY on 16/8/16.
//  Copyright © 2016年 github.com/ocliuziyang/gogogo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (nonatomic, assign)BOOL isselected;


@end

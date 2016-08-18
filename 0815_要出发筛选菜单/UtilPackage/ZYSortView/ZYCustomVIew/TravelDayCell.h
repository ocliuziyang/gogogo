//
//  TravelDayCell.h
//  0816_collectionView
//
//  Created by LZY on 16/8/16.
//  Copyright © 2016年 github.com/ocliuziyang/gogogo. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface TravelDayCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, assign)BOOL isSelected;

@end

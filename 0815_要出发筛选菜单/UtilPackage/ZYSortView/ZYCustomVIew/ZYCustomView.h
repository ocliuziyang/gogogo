//
//  ZYCustomView.h
//  0816_collectionView
//
//  Created by LZY on 16/8/16.
//  Copyright © 2016年 https://github.com/ocliuziyang/gogogo All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREEN_WIDTH_ZY [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT_ZY [UIScreen mainScreen].bounds.size.height
typedef void(^EnsureBtnClickBlock)(NSInteger btnTag);

typedef void(^SelectedIndexPathsBlock)(NSIndexPath *indexPathFirstRadio,
                                       NSIndexPath *indexPathSecRadio,
                                       NSMutableSet *indexPathSet,
                                       NSIndexPath *indexPathFourthRadio);

@interface ZYCustomView : UIView<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, copy)EnsureBtnClickBlock ensureBtnClickBlock;

@property (nonatomic, copy)SelectedIndexPathsBlock selectedIndexPahtsBlock;

- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArray;
@end

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

typedef void(^MaskViewTap)();

typedef void(^SelectedIndexPathsBlock)(NSIndexPath *indexPathFirstRadio,
                                       NSIndexPath *indexPathSecRadio,
                                       NSMutableSet *indexPathSet,
                                       NSIndexPath *indexPathFourthRadio);

@interface ZYCustomView : UIView<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, copy)EnsureBtnClickBlock ensureBtnClickBlock;

@property (nonatomic, copy)SelectedIndexPathsBlock selectedIndexPahtsBlock;

//点击背景蒙版回调
@property (nonatomic, copy)MaskViewTap maskViewTap;

@property (nonatomic, assign)BOOL show;

- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArray;

//取消选择  恢复之前选择 隐藏视图
- (void)hiddenCollectionView;

@end

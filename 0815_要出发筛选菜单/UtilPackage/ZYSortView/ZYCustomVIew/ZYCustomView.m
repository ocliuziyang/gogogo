//
//  ZYCustomView.m
//  0816_collectionView
//
//  Created by LZY on 16/8/16.
//  Copyright © 2016年 github.com/ocliuziyang/gogogo. All rights reserved.
//

#import "ZYCustomView.h"
#import "TravelDayCell.h"
#import "CityCell.h"
#import "ZYMutiSelectReusableView.h"

#define GrayBorderColor [UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:1.00]
#define kCollectionViewHeaderViewHeight 30
#define kLastCollectionViewFooterViewHeight 30
#define viewH  45
static NSString *cellIdentifier = @"TravelDayCell";
static NSString *cityCellIdentifier = @"CityCell";
static NSString *collectionViewReuseableHeaderViewIdentifier = @"ZYMutiSelectReusableView";
@implementation ZYCustomView {
    NSIndexPath *_indexPathFirstRadio;
    NSIndexPath *_indexPathSecRadio;
    NSMutableSet *_indexPathSet;
    NSIndexPath *_indexPathFourthRadio;
    
    //记录temp初始
    NSIndexPath *_tempIndexPathFirstRadio;
    NSIndexPath *_tempIndexPathSecRadio;
    NSMutableSet *_tempIndexPathSet;
    NSIndexPath *_tempIndexPathFourthRadio;
    
    //当前选择的组
    NSInteger _currentSection;
    //数据源
    NSArray *_dataArray;
}
- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArray
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initIndexPath];
        _dataArray = [dataArray copy];
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH_ZY, frame.size.height - 150) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_collectionView];
        [_collectionView registerNib:[UINib nibWithNibName:@"TravelDayCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:cellIdentifier];
        [_collectionView registerNib:[UINib nibWithNibName:@"CityCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:cityCellIdentifier];
        //注册headerView头视图
        [_collectionView registerNib:[UINib nibWithNibName:@"ZYMutiSelectReusableView" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionViewReuseableHeaderViewIdentifier];
        //注册footer伟视图
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([UICollectionReusableView class])];
        
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        [self addConformView];
        //添加背景蒙版视图
        [self addMaskView];
    }
    return self;
}

#pragma mark - initRecordIndexPath
- (void)initIndexPath {
    _indexPathFirstRadio = [NSIndexPath indexPathForItem:0 inSection:0];
    _indexPathSecRadio = [NSIndexPath indexPathForItem:0 inSection:1];
    _indexPathSet = [[NSMutableSet alloc]initWithObjects:[NSIndexPath indexPathForItem:0 inSection:2], nil];
    _indexPathFourthRadio = [NSIndexPath indexPathForItem:0 inSection:3];

    
    _tempIndexPathSet = [[NSMutableSet alloc]initWithObjects:[NSIndexPath indexPathForItem:0 inSection:2], nil];
    
}

- (void)addConformView {
    
    
    UIView *viewBG = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_collectionView.frame), SCREEN_WIDTH_ZY, viewH)];
    viewBG.backgroundColor = [UIColor whiteColor];
    
    UIButton *resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    resetBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH_ZY / 2, viewH);
    [resetBtn setTitle:@"重置" forState:UIControlStateNormal];
    [resetBtn setTitleColor:[UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00] forState:UIControlStateNormal];
     resetBtn.tag = 200;
    [resetBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *ensureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    ensureBtn.frame = CGRectMake(SCREEN_WIDTH_ZY / 2, 0, SCREEN_WIDTH_ZY / 2, viewH);
    [ensureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [ensureBtn setTitleColor:[UIColor colorWithRed:0.22 green:0.81 blue:0.47 alpha:1.00] forState:UIControlStateNormal];
    ensureBtn.tag = 100;
    //确定点击事件
    [ensureBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [viewBG addSubview:resetBtn];
    [viewBG addSubview:ensureBtn];
    
    //竖向 隔离线 |
    CGFloat splitVH = 8;
    UIView *splitLineV = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH_ZY / 2 - 2, splitVH, 1, viewH - splitVH * 2)];
    splitLineV.backgroundColor = GrayBorderColor;
    [resetBtn addSubview:splitLineV];
   
    
    //添加横向隔离线 -------
    //竖向 隔离线 |
    UIView *splitLineH1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH_ZY, 0.30)];
    splitLineH1.backgroundColor = GrayBorderColor;
    [viewBG addSubview:splitLineH1];
    
    UIView *splitLineH2 = [[UIView alloc]initWithFrame:CGRectMake(0, viewBG.frame.size.height-1, SCREEN_WIDTH_ZY, 0.30)];
    splitLineH2.backgroundColor = GrayBorderColor;
    [viewBG addSubview:splitLineH2];
    
    
    [self addSubview:viewBG];
}

- (void)addMaskView {
    CGFloat y = CGRectGetMaxY(_collectionView.frame) + viewH;
    UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0, y, SCREEN_WIDTH_ZY, SCREEN_HEIGHT_ZY - y)];
    maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.30];
    //添加tag值
    maskView.tag = 300;
    //添加tap事件
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenCollectionView)];
    [maskView addGestureRecognizer:tap];
    [self addSubview:maskView];
}

#pragma mark - EventResponse
//取消选择  恢复之前选择 隐藏视图
- (void)hiddenCollectionView {
    _indexPathFirstRadio = _tempIndexPathFirstRadio;
    _indexPathSecRadio = _tempIndexPathSecRadio;
    _indexPathSet = _tempIndexPathSet;
    _indexPathFourthRadio = _tempIndexPathFourthRadio;
    self.show = NO;

}


//视图显示的时候调用
- (void)setShow:(BOOL)show {
    
    _show = show;
    self.hidden = !show;
    if (show) {
        //记录初始的indexPath
        //记录temp初始
        _tempIndexPathFirstRadio = [NSIndexPath indexPathForItem:_indexPathFirstRadio.item inSection:_indexPathFirstRadio.section];
        _tempIndexPathSecRadio = [NSIndexPath indexPathForItem:_indexPathSecRadio.item inSection:_indexPathSecRadio.section];
        _tempIndexPathSet = [_indexPathSet mutableCopy];
        _tempIndexPathFourthRadio = [NSIndexPath indexPathForItem:_indexPathFourthRadio.item inSection:_indexPathFourthRadio.section];
        
        [_collectionView reloadData];
    }
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
#pragma mark - EventResponse
- (void)btnClick:(UIButton *)btn {
    // resetBtn.tag = 200; ensureBtn.tag = 100;
    if (btn.tag == 100) {
        //点击确定
        self.hidden = YES;
        //传递点击
        self.ensureBtnClickBlock(btn.tag);
        //传递点击选中的数据
        self.selectedIndexPahtsBlock(_indexPathFirstRadio, _indexPathSecRadio, _indexPathSet, _indexPathFourthRadio);
        
    }
    
    if (btn.tag == 200) {
        [self initIndexPath];
        [_collectionView reloadData];
        self.hidden = YES;
        //传递点击
        self.ensureBtnClickBlock(btn.tag);
        //传递点击选中的数据
        self.selectedIndexPahtsBlock(_indexPathFirstRadio, _indexPathSecRadio, _indexPathSet, _indexPathFourthRadio);
        
    }
    

    
}








#pragma mark - CollectionViewDelegate

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    _currentSection = indexPath.section;
    
    NSDictionary *dict = _dataArray[indexPath.section];
    NSInteger rows = [dict[@"data"] count];
    
    NSLog(@"shouldSelectItemAtIndexPath");
    switch (indexPath.section) {
        case 0:
        {
            //记录点击
            _indexPathFirstRadio = indexPath;
            NSLog(@"_indexPathFirstRadio = %@", _indexPathFirstRadio);
            for (int i = 0; i < rows; i++) {
                CityCell *cell = (CityCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:indexPath.section]];
                cell.isselected = NO;
            }
            //是当前点击显示
            CityCell *cell = (CityCell *)[collectionView cellForItemAtIndexPath:indexPath];
            cell.isselected = YES;
            
        }
            break;
        case 1:
        {
            //记录点击
            _indexPathSecRadio = indexPath;
            NSLog(@"_indexPathSecRadio = %@", _indexPathSecRadio);
            for (int i = 0; i < rows; i++) {
                TravelDayCell *cell = (TravelDayCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:indexPath.section]];
                cell.isSelected = NO;
            }
            //是当前点击显示
            TravelDayCell *cell = (TravelDayCell *)[collectionView cellForItemAtIndexPath:indexPath];
            cell.isSelected = YES;
            
        }
            break;
        case 2:
        {
            
            
           //检查nsset里面是否含有该indexPath
            if ([_indexPathSet containsObject:indexPath]) {
                //如果存在则删除
                [_indexPathSet removeObject:indexPath];
                //是当前点击显示
                TravelDayCell *cell = (TravelDayCell *)[collectionView cellForItemAtIndexPath:indexPath];
                cell.isSelected = NO;
            } else {
                //添加到set
                [_indexPathSet addObject:indexPath];
                //是当前点击显示
                TravelDayCell *cell = (TravelDayCell *)[collectionView cellForItemAtIndexPath:indexPath];
                cell.isSelected = YES;
            }
            
            //点击 0 不限
            if(indexPath.row == 0) {
                _indexPathSet = [[NSMutableSet alloc]initWithObjects:[NSIndexPath indexPathForItem:0 inSection:2], nil];
                [collectionView reloadSections:[NSIndexSet indexSetWithIndex:2]];
            } else {
                //去除不限
                [_indexPathSet removeObject:[NSIndexPath indexPathForItem:0 inSection:indexPath.section]];
                TravelDayCell *cell = (TravelDayCell *)[collectionView cellForItemAtIndexPath:indexPath];
                cell.isSelected = YES;
                [collectionView reloadSections:[NSIndexSet indexSetWithIndex:2]];
            }
            
            if(_indexPathSet.count == 0) {
                _indexPathSet = [[NSMutableSet alloc]initWithObjects:[NSIndexPath indexPathForItem:0 inSection:2], nil];
                [collectionView reloadSections:[NSIndexSet indexSetWithIndex:2]];
            }
            
            NSLog(@"_indexPathSet = %@", _indexPathSet);
            
        }
            break;

        case 3:
        {
            //记录点击
            _indexPathFourthRadio = indexPath;
            NSLog(@"_indexPathFourthRadio = %@", _indexPathFourthRadio);
            for (int i = 0; i < rows; i++) {
                TravelDayCell *cell = (TravelDayCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:indexPath.section]];
                cell.isSelected = NO;
            }
            //是当前点击显示
            TravelDayCell *cell = (TravelDayCell *)[collectionView cellForItemAtIndexPath:indexPath];
            cell.isSelected = YES;
            
        }
            break;

            
        default:
            break;
    }
    
    
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
     NSLog(@"didSelectItemAtIndexPath");
    
    
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"shouldDeselectItemAtIndexPath");
    
    return YES;
}



#pragma mark - 设置制定cell状态


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _dataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSDictionary *dict = _dataArray[section];

    return [dict[@"data"] count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dict = _dataArray[indexPath.section];
    NSArray *dataArray = dict[@"data"];

    if (indexPath.section == 0) {
        NSDictionary *dic = dataArray[indexPath.row];
        CityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cityCellIdentifier forIndexPath:indexPath];
        cell.isselected = NO;
        if(_indexPathFirstRadio.row == indexPath.row) {
            //显示为选中状态
            cell.isselected = YES;
        }
        cell.titleLabel.text = dic[@"keyTitle"];
        
        
        return cell;
    } else if(indexPath.section == 1){
        
        
      
        TravelDayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        cell.isSelected = NO;
        if (indexPath.row == 0) {
            cell.titleLabel.text = [NSString stringWithFormat:@"不限"];
        } else {
            NSDateComponents *components = dataArray[indexPath.row];
            cell.titleLabel.text = [NSString stringWithFormat:@"%ld月", components.month];
            NSLog(@"%ld  %ld", components.year, components.month);
            
            NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            NSDateComponents *nowComponets = [calendar components:kCFCalendarUnitYear | kCFCalendarUnitMonth fromDate:[NSDate date]];
            
            if (components.year > nowComponets.year) {
                cell.titleLabel.text = [NSString stringWithFormat:@"%ld年%ld月", components.year,components.month];
//                cell.titleLabel.font = [UIFont systemFontOfSize:10];
            }
            
        }
        
       
        //点击不同的section 保持当前 状态
        if(_indexPathSecRadio.row == indexPath.row) {
            //显示为选中状态
            cell.isSelected = YES;
            
        }
        
        return cell;
        
        
    } else if(indexPath.section == 3){
        
        TravelDayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        cell.isSelected = NO;
        if(_indexPathFourthRadio.row == indexPath.row) {
            //显示为选中状态
            cell.isSelected = YES;
            
        }
        NSDictionary *dic = dataArray[indexPath.row];
        cell.titleLabel.text = dic[@"keyTitle"];
        return cell;
        
    } else if (indexPath.section == 2){
        
        
        TravelDayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        cell.isSelected = NO;
        
        //若集合里有当前indexPath
        if ([_indexPathSet containsObject:indexPath]) {
            cell.isSelected = YES;
        }
        
        NSDictionary *dic = dataArray[indexPath.row];
        cell.titleLabel.text = dic[@"keyTitle"];
        return cell;
        
    }
    
    
    return nil;
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (kind == UICollectionElementKindSectionHeader) {
        ZYMutiSelectReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionViewReuseableHeaderViewIdentifier forIndexPath:indexPath];
        NSDictionary *dict = _dataArray[indexPath.section];
        reusableView.titleLabel.text = dict[@"title"];
        return reusableView;
    } else {
        
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([UICollectionReusableView class]) forIndexPath:indexPath];
        return view;
    }
    
}

// The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    
//}



#pragma mark - UIFlowLayoutDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return CGSizeMake(SCREEN_WIDTH_ZY, 44);
    }
    
    if(indexPath.row == 10) {
        return CGSizeMake(80, 35);
    }
    
    if (indexPath.section == 3) {
        return CGSizeMake(95, 35);
    }
    
    if (indexPath.section == 1) {
        
        
        if (indexPath.row != 0) {
            NSDictionary *dict = _dataArray[indexPath.section];
            NSArray *dataArray = dict[@"data"];
            NSDateComponents *components = dataArray[indexPath.row];
            NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            NSDateComponents *nowComponets = [calendar components:kCFCalendarUnitYear | kCFCalendarUnitMonth fromDate:[NSDate date]];
            
            if (components.year > nowComponets.year) {
                return CGSizeMake(95, 35);
            }
        }
        
       

        
        return CGSizeMake(55, 35);
    }
    
    return CGSizeMake(55, 35);
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return UIEdgeInsetsMake(0, 10, 0, 10);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    if (section == 0) {
        return 0;
    }
    
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    if (section == 3) {
        return 1;
    }
    
    return 5;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, kCollectionViewHeaderViewHeight);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    
    if(section == 3) {
        return CGSizeMake(SCREEN_WIDTH_ZY, kLastCollectionViewFooterViewHeight);
    }
    
    return CGSizeZero;
}



@end

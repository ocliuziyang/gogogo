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
#define viewH  45
static NSString *cellIdentifier = @"TravelDayCell";
static NSString *cityCellIdentifier = @"CityCell";
static NSString *collectionViewReuseableHeaderViewIdentifier = @"ZYMutiSelectReusableView";
@implementation ZYCustomView {
    NSIndexPath *_indexPathFirstRadio;
    NSIndexPath *_indexPathSecRadio;
    //数据源
    NSArray *_dataArray;
}
- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArray
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _dataArray = [dataArray copy];
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH_ZY, frame.size.height - 150) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_collectionView];
        [_collectionView registerNib:[UINib nibWithNibName:@"TravelDayCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:cellIdentifier];
        [_collectionView registerNib:[UINib nibWithNibName:@"CityCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:cityCellIdentifier];
        //注册headerView头视图
        [_collectionView registerNib:[UINib nibWithNibName:@"ZYMutiSelectReusableView" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionViewReuseableHeaderViewIdentifier];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        [self addConformView];
        //添加背景蒙版视图
        [self addMaskView];
    }
    return self;
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
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenCollectionView:)];
    [maskView addGestureRecognizer:tap];
    [self addSubview:maskView];
}

#pragma mark - EventResponse
- (void)hiddenCollectionView:(UITapGestureRecognizer *)tap {

    
    self.ensureBtnClickBlock(tap.view.tag);
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
        
    }
    //传递点击
    self.ensureBtnClickBlock(btn.tag);
}


#pragma mark - UICollectionViewDelegate


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
        [cell setCellSelectedStatus:NO];
        if(_indexPathFirstRadio.row == indexPath.row) {
            //显示为选中状态
            [cell setCellSelectedStatus:YES];
        }
        cell.titleLabel.text = dic[@"keyTitle"];
        
        
        return cell;
    } else if(indexPath.section == 1){
        
        
      
        TravelDayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];

        if (indexPath.row == 0) {
            cell.titleLabel.text = [NSString stringWithFormat:@"不限"];
        } else {
            NSDateComponents *components = dataArray[indexPath.row];
            cell.titleLabel.text = [NSString stringWithFormat:@"%ld月", components.month];
            NSLog(@"%ld  %ld", components.year, components.month);
        }
        
//        if (components) {
//            <#statements#>
//        }
        //点击不同的section 保持当前 状态
        if(_indexPathSecRadio.row == indexPath.row) {
            //显示为选中状态
            [cell setStatus:YES];
        }
        
        return cell;
        
        
    } else{

        NSDictionary *dic = dataArray[indexPath.row];
        TravelDayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        cell.titleLabel.text = dic[@"keyTitle"];
        return cell;
    }
    
    
    
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (kind == UICollectionElementKindSectionHeader) {
        ZYMutiSelectReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionViewReuseableHeaderViewIdentifier forIndexPath:indexPath];
       NSDictionary *dict = _dataArray[indexPath.section];
        reusableView.titleLabel.text = dict[@"title"];
        return reusableView;
    } else {
        return nil;
    }
    
}

// The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    
//}
#pragma mark - CollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"点击了 %ld section, %ld row", indexPath.section, indexPath.row);
    switch (indexPath.section) {
        case 0:
        {
            //记录当前点击位置
            _indexPathFirstRadio = indexPath;
            //显示为选中状态
            CityCell *cell = (CityCell *)[collectionView cellForItemAtIndexPath:indexPath];
            [cell setCellSelectedStatus:YES];
            if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3) {
                CityCell *cell = (CityCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                [cell setCellSelectedStatus:NO];
            }
            //
            TravelDayCell *dayCell = (TravelDayCell *)[collectionView cellForItemAtIndexPath:_indexPathSecRadio];
            [dayCell setStatus:YES];
        }
            break;
        case 1:
        {
            CityCell *preCell =  (CityCell *)[collectionView cellForItemAtIndexPath:_indexPathFirstRadio];
            [preCell setCellSelectedStatus:YES];
            
            //这里来写 出发日期 单选
            TravelDayCell *dayCell = (TravelDayCell *)[collectionView cellForItemAtIndexPath:indexPath];
            [dayCell setStatus:YES];
           
            //记录index
            _indexPathSecRadio = indexPath;
            
            if (indexPath.row != 0) {
                 TravelDayCell *dayCell1 = (TravelDayCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
               [dayCell1 setStatus:NO];
            }
            
            
        }
            break;
        case 2:
        {
            CityCell *preCell =  (CityCell *)[collectionView cellForItemAtIndexPath:_indexPathFirstRadio];
            [preCell setCellSelectedStatus:YES];
        }
            break;
        case 3:
        {
            CityCell *preCell =  (CityCell *)[collectionView cellForItemAtIndexPath:_indexPathFirstRadio];
            [preCell setCellSelectedStatus:YES];
        }
            break;
            
        default:
            break;
    }
    
    
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
        {

            //显示为选中状态
            CityCell *cell = (CityCell *)[collectionView cellForItemAtIndexPath:indexPath];
            [cell setCellSelectedStatus:NO];
            //保持状态
            TravelDayCell *dayCell = (TravelDayCell *)[collectionView cellForItemAtIndexPath:_indexPathSecRadio];
            
            [dayCell setStatus:NO];
            
        }
            break;
        case 1:
        {
            CityCell *cell1 = (CityCell *)[collectionView cellForItemAtIndexPath:_indexPathFirstRadio];
            [cell1 setCellSelectedStatus:NO];
            //#########################
            //这里来写 出发日期 单选
            TravelDayCell *dayCell = (TravelDayCell *)[collectionView cellForItemAtIndexPath:indexPath];
            [dayCell setStatus:NO];
            

            
        }
            break;
        case 2:
        {
            CityCell *cell1 = (CityCell *)[collectionView cellForItemAtIndexPath:_indexPathFirstRadio];
            [cell1 setCellSelectedStatus:NO];
        }
            break;
        case 3:
        {
            CityCell *cell1 = (CityCell *)[collectionView cellForItemAtIndexPath:_indexPathFirstRadio];
            [cell1 setCellSelectedStatus:NO];
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - UIFlowLayoutDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return CGSizeMake(SCREEN_WIDTH_ZY, 44);
    }
    
    if(indexPath.row == 10) {
        return CGSizeMake(80, 25);
    }
    
    if (indexPath.section == 3) {
        return CGSizeMake(95, 25);
    }
    
    return CGSizeMake(50, 25);
    
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
    return 5;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, kCollectionViewHeaderViewHeight);
}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
//    return CGSizeMake([UIScreen mainScreen].bounds.size.width, kCollectionViewHeaderViewHeight);
//}



@end

//
//  AnalogData.m
//  0815_要出发筛选菜单
//
//  Created by LZY on 16/8/15.
//  Copyright © 2016年 github.com/ocliuziyang/gogogo. All rights reserved.
//

#import "AnalogData.h"

static NSArray *randomTitleArray;
static NSArray *randomImageName;
@implementation AnalogData

//返回随机字符串
+ (NSString *)randomTitle {
    NSArray *titleArray = [self randomTitleArray];
    NSInteger randomIndex = arc4random_uniform((int)titleArray.count);
    return titleArray[randomIndex];
}

+ (NSArray *)randomTitleArray {
    if (!randomTitleArray) {
        randomTitleArray = @[@"香港4日3晚自由行(4钻)·香港皇悦系列酒店", @"香港4日自由行·惠选航班 中秋&国庆 早定优惠", @"澳门+香港5日自由行·1晚澳门+3晚香港|澳进港出|提前15天减50元", @"香港迪士尼（Disney）4日自由行·1晚迪士尼2晚市区", @"香港5日自由行·可接受L签 提前15天减100元【早定优惠", @"香港4日自由行·惠选航班 中秋&国庆 早定优惠", @"香港4日3晚自由行(4钻)·香港丽都酒店", @"澳门+香港5日自由行(4钻)·澳门喜来登+香港皇悦系列酒店【港进港出"];
    }
    return randomTitleArray;
}

//返回随机图片
+ (NSString *)randomImageName {
    NSArray *titleArray = [self randomTitleArray];
    NSInteger randomIndex = arc4random_uniform((int)titleArray.count) + 1;
    return [NSString stringWithFormat:@"%ld", randomIndex];
}
@end

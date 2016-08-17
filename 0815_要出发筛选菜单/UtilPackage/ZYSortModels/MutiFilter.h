//
//  MutiFilter.h
//  0815_要出发筛选菜单
//
//  Created by LZY on 16/8/17.
//  Copyright © 2016年 github.com/ocliuziyang/gogogo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MutiFilter : NSObject

@property (nonatomic, assign)NSInteger SetOut;//出发城市
@property (nonatomic, assign)NSInteger Date;//出发日期
@property (nonatomic, copy)NSString *Day;//游玩天数(多选)
@property (nonatomic, assign)NSInteger MinPrice;//制定最低价格
@property (nonatomic, assign)NSInteger MaxPrice;//制定最高价格


@end

//
//  DateHelper.m
//  0815_要出发筛选菜单
//
//  Created by LZY on 16/8/17.
//  Copyright © 2016年 github.com/ocliuziyang/gogogo. All rights reserved.
//

#import "DateHelper.h"
#define kTitle
@implementation DateHelper

//返回当前月 和 以后 10个月数组
+ (NSArray *)dateHelperGetCurrentMonthAndLater:(NSDate *)startTime {
    

    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *componets = [calendar components:kCFCalendarUnitYear | kCFCalendarUnitMonth fromDate:startTime];
    
    NSMutableArray *tempArr = [NSMutableArray array];
    [tempArr addObject:[NSString stringWithFormat:@"不限"]];
    [tempArr addObject:[componets copy]];
    
    for (int i = 0; i < 6; i++) {
        
        if (componets.month < 12) {
            componets.month = componets.month + 1;
            
        } else {
            componets.month = componets.month % 11;
             NSDateComponents *tempComponets = [calendar components:kCFCalendarUnitYear | kCFCalendarUnitMonth fromDate:startTime];
            componets.year = tempComponets.year + 1;
            
        }
       [tempArr addObject:[componets copy]];
        NSLog(@"%ld-%ld", componets.year, componets.month);
    }
    
    
    
    return tempArr;
}

/***  @[@{
keyTitle : @"不限",
},
@{
keyTitle : @"8月",

},
@{
keyTitle : @"3日",

},
@{
keyTitle : @"4日",

},
@{
keyTitle : @"5日",

},
@{
keyTitle : @"6日",

},@{
keyTitle : @"7日",

},@{
keyTitle : @"8日",

},
@{
keyTitle : @"9日",

},
@{
keyTitle : @"10日",

},
@{
keyTitle : @"10日以上",

}],
},**/

@end

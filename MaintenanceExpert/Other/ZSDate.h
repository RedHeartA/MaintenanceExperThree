//
//  ZSDate.h
//  MaintenanceExpert
//
//  Created by koka on 16/11/24.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZSDate : NSObject

//将日期转换为字符串（日期，时间）
+ (NSString *)getDateStringFromDate:(NSDate *)date;
//计算两个日期之间的差距，过了多少天。。
+ (NSInteger)getDateToDateDays:(NSDate *)date withSaveDate:(NSDate *)saveDate;
//日期转字符串
+ (NSString * )NSDateToNSString: (NSDate *)date;
//字符串转日期
+ (NSDate * )NSStringToNSDate: (NSString *)string;

@end

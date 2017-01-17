//
//  ZSDate.m
//  MaintenanceExpert
//
//  Created by koka on 16/11/24.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSDate.h"

@implementation ZSDate

#define kDEFAULT_DATE_TIME_FORMAT (@"yyyy-MM-dd HH:mm:ss")

//获取当前日期，时间
+(NSDate *)getCurrentDate{
    NSDate *now = [NSDate date];
    return now;
}



//将日期转换为字符串（日期，时间）
+(NSString *)getDateStringFromDate:(NSDate *)date{
    NSInteger location = 0;
    NSString *timeStr = @"";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [formatter setDateFormat:@"HH:mm:a"];
    NSString *ampm = [[[formatter stringFromDate:date] componentsSeparatedByString:@":"] objectAtIndex:2];
    timeStr = [formatter stringFromDate:date];
    NSRange range = [timeStr rangeOfString:[NSString stringWithFormat:@":%@",ampm]];
    location = range.location;
    NSString *string = [timeStr substringToIndex:location];
    timeStr = [NSString stringWithFormat:@"%@ %@",ampm,string];
    
    
    NSString *dateStr = @"";
    NSDateFormatter *Dformatter = [[NSDateFormatter alloc] init];
    [Dformatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [Dformatter setDateFormat:@"yyyy-MM-dd"];
    dateStr = [Dformatter stringFromDate:date];
    return [NSString stringWithFormat:@"%@  %@",dateStr,timeStr];
}




//计算两个日期之间的差距，过了多少天。。
+(NSInteger)getDateToDateDays:(NSDate *)date withSaveDate:(NSDate *)saveDate{
    NSCalendar* chineseClendar = [ [ NSCalendar alloc ] initWithCalendarIdentifier:NSCalendarIdentifierGregorian ];
    NSUInteger unitFlags =  NSCalendarUnitHour | NSCalendarUnitMinute |
    NSCalendarUnitSecond | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDateComponents *cps = [ chineseClendar components:unitFlags fromDate:date  toDate:saveDate  options:0];
    NSInteger diffDay   = [ cps day ];
    return diffDay;
}

//比如
//NSDate *lastDate = [self getSaveDate];//saveDate通过将NSDate转换为NSString来保存
//currentDate = [NSDate date];
//NSInteger day = [DateHelper getDateToDateDays:currentDate withSaveDate: lastDate];





//日期转字符串
+ (NSString * )NSDateToNSString: (NSDate * )date
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: kDEFAULT_DATE_TIME_FORMAT];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}


//字符串转日期
+ (NSDate * )NSStringToNSDate: (NSString * )string
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: kDEFAULT_DATE_TIME_FORMAT];
    NSDate *date = [formatter dateFromString :string];
    return date;
}

@end

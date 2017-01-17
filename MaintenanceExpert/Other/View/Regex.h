//
//  Regex.h
//  MaintenanceExpert
//
//  Created by koka on 16/11/21.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Regex : NSObject

+ (BOOL)isMobile:(NSString *)mobileNumbel;

+ (BOOL)isAvailableEmail:(NSString *)email;

/**
 *  身份证号验证
 *
 *  @param value 传入身份证号
 *
 *  @return 格式正确返回true  错误 返回false
 */
+ (BOOL)accurateVerifyIDCardNumber:(NSString *)value;



@end

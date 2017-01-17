//
//  Cardcommit.h
//  IDCardTEXT
//
//  Created by koka on 16/11/29.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cardcommit : NSObject

/**
 *  诺正通
 *   调用的是诺正通的接口文档，可以网上自己申请
 *  @return result
 */


/**
 *   身份证实名认证
 */
+ (NSString *)ReturnIDCardResultwithname:(NSString *)name Andidcard:(NSString *)idcard;


/**
 *   银行卡实名认证
 */

+ (NSString *)ReturnBankCardResultwithname:(NSString *)name Andidcard:(NSString *)idcard Andbankcard:(NSString *)cardnum AndbankPreMobile:(NSString *)bankPreMobile;

/**
 *   银行卡归属银行
 */

+ (NSDictionary *)ReturnBankCardResultwithbankcard:(NSString *)cardnum;


@end

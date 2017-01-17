//
//  Cardcommit.m
//  IDCardTEXT
//
//  Created by koka on 16/11/29.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "Cardcommit.h"
#import "CusMD5.h"

@interface Cardcommit ()

@end

@implementation Cardcommit

/**
 *   iD 和 appkey 通过网上申请即可得到，非常方便
 *
 

 *  返回值 正确则是 “一致”
 */

+ (NSString *)ReturnIDCardResultwithname:(NSString *)name Andidcard:(NSString *)idcard {
    
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    NSString *times = [NSString stringWithFormat:@"%f",time];
    NSString *tm = [NSString stringWithFormat:@"%@000",[times substringToIndex:10]];
    NSString *iD = @"110675";
    NSString *appkey = @"1044b1b816d25836d6264447d660eb57";
    NSString *realname = [name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *idc1 = [idcard substringFromIndex:17];
    NSString *idc17 = [idcard substringToIndex:17];
    NSString *newidcard;
    if ([idc1 isEqualToString:@"X"] | [idc1 isEqualToString:@"x"]) {
        newidcard = [NSString stringWithFormat:@"%@x",idc17];
    }else{
        newidcard = idcard;
    }
    //md5加密（此处需要的是中文名称）
    NSString *str = [NSString stringWithFormat:@"%@%@%@%@%@",iD,name,newidcard,tm,appkey];
    NSString *strEnRes = [CusMD5 md5String:str];
    NSString *sign = [NSString stringWithFormat:@"%@",strEnRes];
    //(此处需要的是经过UTF8反编码的名称）
    NSString *strURL = [NSString stringWithFormat:@"http://www.nuozhengtong.com:8080/v2/id-server?mall_id=%@&realname=%@&idcard=%@&tm=%@&sign=%@",iD,realname,newidcard,tm,sign];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:strURL]];

    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (data != nil) {
        NSDictionary *dic= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSDictionary *dicdata = [dic objectForKey:@"data"];
        return [dicdata objectForKey:@"message"];
    }else{
        return nil;
    }
}



/*
 *返回值 正确则是 “验证成功”
 */
+ (NSString *)ReturnBankCardResultwithname:(NSString *)name Andidcard:(NSString *)idcard Andbankcard:(NSString *)cardnum AndbankPreMobile:(NSString *)bankPreMobile {
    
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    NSString *times = [NSString stringWithFormat:@"%f",time];
    NSString *tm = [NSString stringWithFormat:@"%@000",[times substringToIndex:10]];
    NSString *iD = @"110675";
    NSString *appkey = @"1044b1b816d25836d6264447d660eb57";
    NSString *realname = [name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSString *idc1 = [idcard substringFromIndex:17];
    NSString *idc17 = [idcard substringToIndex:17];
    NSString *newidcard;
    if ([idc1 isEqualToString:@"X"] | [idc1 isEqualToString:@"x"]) {
        newidcard = [NSString stringWithFormat:@"%@x",idc17];
    }else{
        newidcard = idcard;
    }
    //md5加密（此处需要的是中文名称）
    NSString *str = [NSString stringWithFormat:@"%@%@%@%@%@",iD,name,cardnum,tm,appkey];
    NSString *strEnRes = [CusMD5 md5String:str];
    NSString *sign = [NSString stringWithFormat:@"%@",strEnRes];
    //(此处需要的是经过UTF8反编码的名称）
    NSString *strURL = [NSString stringWithFormat:@"http://121.41.42.121:8080/v3/card4-server?mall_id=%@&realname=%@&cardnum=%@&bankPreMobile=%@&idcard=%@&tm=%@&sign=%@",iD,realname,cardnum,bankPreMobile,newidcard,tm,sign];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:strURL]];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (data != nil) {
        NSDictionary *dic= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSDictionary *dicdata = [dic objectForKey:@"data"];
        return [dicdata objectForKey:@"message"];
    }else{
        return nil;
    }

}

/**
 *  返回一个字典 
 例如 { 
       "bankname":"中国银行",
       "cardname":"借记IC联名卡",
       "cardtype":"借记卡",
       "city":"青岛",
       "province":"山东"
      }
 */
+ (NSDictionary *)ReturnBankCardResultwithbankcard:(NSString *)cardnum {
    NSString *iD = @"110675";
    NSString *appkey = @"1044b1b816d25836d6264447d660eb57";
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    NSString *times = [NSString stringWithFormat:@"%f",time];
    NSString *tm = [NSString stringWithFormat:@"%@000",[times substringToIndex:10]];
    //md5加密（此处需要的是中文名称）
    NSString *str = [NSString stringWithFormat:@"%@%@%@%@",iD,cardnum,tm,appkey];
    NSString *strEnRes = [CusMD5 md5String:str];
    NSString *sign = [NSString stringWithFormat:@"%@",strEnRes];
    NSString *strURL = [NSString stringWithFormat:@"http://121.41.42.121:8080/bankcard/city-server?mall_id=%@&bankcardno=%@&tm=%@&sign=%@",iD,cardnum,tm,sign];
    NSLog(@"%@",strURL);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:strURL]];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (data != nil) {
        NSDictionary *dic= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        return [dic objectForKey:@"status"];
    }else{
        return nil;
    }
}


@end

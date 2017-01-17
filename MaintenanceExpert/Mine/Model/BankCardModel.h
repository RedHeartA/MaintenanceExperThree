//
//  BankCardModel.h
//  MaintenanceExpert
//
//  Created by koka on 16/12/1.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BankCardModel : NSObject

@property(nonatomic,copy)NSString *CardnumFour;
@property(nonatomic,copy)NSString *BankName;

@property(nonatomic,copy)NSString *IDCard;
@property(nonatomic,copy)NSString *Phone;

@property (nonatomic,strong)NSMutableDictionary *BankCardDic;


+(BankCardModel *)shareBankCard;
@end

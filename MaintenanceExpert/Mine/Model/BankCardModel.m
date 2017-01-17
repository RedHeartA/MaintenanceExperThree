//
//  BankCardModel.m
//  MaintenanceExpert
//
//  Created by koka on 16/12/1.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "BankCardModel.h"

@implementation BankCardModel

static BankCardModel *_BankcardModel;

+(BankCardModel *)shareBankCard {
    
    if (_BankcardModel == nil) {
        _BankcardModel = [[super alloc]init];
    }
    return _BankcardModel;
}

- (instancetype)init {
    
    if (self = [super init]) {        
        
    }
    return self;
}


@end

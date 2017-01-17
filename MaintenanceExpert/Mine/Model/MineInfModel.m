//
//  MineInfModel.m
//  MaintenanceExpert
//
//  Created by koka on 16/10/28.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "MineInfModel.h"
#import "ZSLoginViewController.h"

@implementation MineInfModel

//static MineInfModel *_MineInfoModel;

//+(MineInfModel *)shareDetailInfo {
//    
//    if (_MineInfoModel == nil) {
//        _MineInfoModel = [[super alloc]init];
//    }
//    return _MineInfoModel;
//}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.username forKey:@"username"];
    [aCoder encodeObject:self.usericon forKey:@"usericon"];
    [aCoder encodeObject:self.moneynum forKey:@"moneynum"];
    [aCoder encodeObject:self.userkind forKey:@"userkind"];
    [aCoder encodeObject:self.leftlabelnum forKey:@"leftlabelnum"];
    [aCoder encodeObject:self.rightlabelnum forKey:@"rightlabelnum"];
    [aCoder encodeObject:self.userAuthName forKey:@"userAuthName"];
    [aCoder encodeObject:self.Mymoney forKey:@"Mymoney"];
    [aCoder encodeObject:self.MineInformation forKey:@"MineInformation"];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super init]) {
        self.username = [aDecoder decodeObjectForKey:@"username"];
        self.usericon = [aDecoder decodeObjectForKey:@"usericon"];
        self.moneynum = [aDecoder decodeObjectForKey:@"moneynum"];
        self.userkind = [aDecoder decodeObjectForKey:@"userkind"];
        self.leftlabelnum = [aDecoder decodeObjectForKey:@"leftlabelnum"];
        self.rightlabelnum = [aDecoder decodeObjectForKey:@"rightlabelnum"];
        self.userAuthName = [aDecoder decodeObjectForKey:@"userAuthName"];
        self.Mymoney = [aDecoder decodeObjectForKey:@"Mymoney"];
        self.MineInformation = [aDecoder decodeObjectForKey:@"MineInformation"];


    }
    return self;
}

@end

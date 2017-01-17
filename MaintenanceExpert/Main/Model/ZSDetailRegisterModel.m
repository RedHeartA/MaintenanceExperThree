//
//  ZSDetailRegisterModel.m
//  MaintenanceExpert
//
//  Created by koka on 16/11/28.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSDetailRegisterModel.h"

@implementation ZSDetailRegisterModel

static ZSDetailRegisterModel *_detailregisterModel;

+(ZSDetailRegisterModel *)shareRegist {
    
    if (_detailregisterModel == nil) {
        _detailregisterModel = [[super alloc] init];
    }
    return _detailregisterModel;
}

- (instancetype)init {
    if (self = [super init]) {

    }
    return self;
}

@end

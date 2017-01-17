//
//  OrderModel.m
//  MaintenanceExpert
//
//  Created by koka on 16/12/6.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel

- (instancetype)initWithDictionary:(NSDictionary *)dataSource {
    if ( self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dataSource];
        
    }
    return self;
}

+ (instancetype)OrderModelWithDict:(NSDictionary*)dict{
    return [[self alloc]initWithDictionary:dict];
}

- (id)valueForUndefinedKey:(NSString *)key {
    
    return nil;
}

@end

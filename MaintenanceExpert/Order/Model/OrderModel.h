//
//  OrderModel.h
//  MaintenanceExpert
//
//  Created by koka on 16/12/6.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject

@property(nonatomic,copy)NSString *kindImageName;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *price;
@property(nonatomic,copy)NSString *orderStatus;
@property(nonatomic,copy)NSString *receiveorderTime;
@property(nonatomic,copy)NSString *pushorderTime;


- (instancetype)initWithDictionary:(NSDictionary *)dataSource;

+ (instancetype)OrderModelWithDict:(NSDictionary*)dict;

@end

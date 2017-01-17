//
//  ZSDetailOrderModel.h
//  MaintenanceExpert
//
//  Created by koka on 16/11/3.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZSDetailOrderModel : NSObject

@property(nonatomic,copy)NSMutableArray *FirstMU;//一级分类数组
@property(nonatomic,copy)NSMutableArray *SecondMu;//二级分类数组

@property(nonatomic,assign) NSInteger SecondID;//二级分类ID

@property(nonatomic,assign) NSInteger FirstIndex;//一级分类
@property(nonatomic,assign) NSInteger SecondIndex;//二级分类
@property(nonatomic,copy) NSString *NavTitle;//下单页面的导航标题

@property(nonatomic,assign) NSInteger KindIndex;//维修/安装 ，0/1

@property(nonatomic,copy)NSString *Orderprov_id;//省Id
@property(nonatomic,copy)NSString *Ordercity_id;//市id
@property(nonatomic,copy)NSString *Orderdist_id;//区id

@property(nonatomic,copy)NSString *OrderDetailAddress;//订单详细地址
@property(nonatomic,copy)NSString *OrderContact;//订单联系人
@property(nonatomic,copy)NSString *OrderContactMobile;//订单联系人电话
@property(nonatomic,copy)NSString *OrderTime;//时间
@property(nonatomic,copy)NSString *AllCost;//总费用
@property(nonatomic,assign) BOOL Counties;//郊县
@property(nonatomic,assign) BOOL NeedLine;//电池主机间连线
@property(nonatomic,copy)NSString *OrderDetailInfo;//问题描述


/**
 *  维修
 */
@property(nonatomic,copy) NSMutableArray *MTsystemKindMuArr;//维修系统种类（多选）
@property(nonatomic,assign) NSInteger ProblemNum;//故障点
@property(nonatomic,assign) BOOL HighWork;//高空作业
@property(nonatomic,copy)NSData *PhotoData;//上传的图片

/**
 *  安装
 *
 */
@property(nonatomic,copy)NSString *ServiceKind;//服务类型
@property(nonatomic,copy)NSString *UPSKind;//UPS类型
@property(nonatomic,copy)NSString *Power;//功率
@property(nonatomic,copy)NSString *HostBrand;//主机品牌
@property(nonatomic,assign) NSInteger UPSNumber;//UPS主机台数
@property(nonatomic,assign) NSInteger BatteryNumber;//电池组
@property(nonatomic,copy)NSString *UPSPower;//UPS功率
@property(nonatomic,assign) NSInteger ServiceNominal;//服务名义
@property(nonatomic,assign) NSInteger WorkOrderModel;//工单报告模板

@property(nonatomic,assign) NSInteger index;//订单第二页数组值



+(ZSDetailOrderModel *)shareDetailOrder;

@end

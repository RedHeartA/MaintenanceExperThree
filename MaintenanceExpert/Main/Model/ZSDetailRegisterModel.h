//
//  ZSDetailRegisterModel.h
//  MaintenanceExpert
//
//  Created by koka on 16/11/28.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZSDetailRegisterModel : NSObject

@property(nonatomic,assign)NSInteger RegisterIndex;


/**
 *  注册信息
 */
@property(nonatomic,copy)NSString *id_num;//身份证
@property(nonatomic,copy)NSString *id_up_photo;//身份证正面照片路径
@property(nonatomic,copy)NSString *id_back_photo;//身份证背面照片路径
@property(nonatomic,copy)NSString *user_group;//用户组
@property(nonatomic,copy)NSString *contact;//联系人
@property(nonatomic,copy)NSString *real_name;//真实姓名
@property(nonatomic,copy)NSString *company_name;//公司名
@property(nonatomic,copy)NSString *compang_type;//公司类型（个人、合资等等）必须是数字
@property(nonatomic,copy)NSString *company_service;//公司行业（ups/蓄电池等等）
@property(nonatomic,copy)NSString *password;//密码
@property(nonatomic,copy)NSString *email;//邮箱
@property(nonatomic,copy)NSString *work_time;//工程师工作时间
@property(nonatomic,copy)NSString *prov_id;//省Id
@property(nonatomic,copy)NSString *city_id;//市id
@property(nonatomic,copy)NSString *dist_id;//区id
@property(nonatomic,copy)NSString *address;//详细地址
@property(nonatomic,copy)NSString *type;//账户类型（个人，公司，工程师、工程商、生厂商）
@property(nonatomic,copy)NSString *mobile;//手机
@property(nonatomic,copy)NSString *landline_num;//座机
@property(nonatomic,copy)NSString *license_id;//营业执照编号
@property(nonatomic,copy)NSString *license_photo;//营业执照照片路径
@property(nonatomic,copy)NSString *company_info;//公司简介
@property(nonatomic,copy)NSString *cover_range;//工程师维修范围
@property(nonatomic,copy)NSString *cover_device;//工程师维修设备
@property(nonatomic,copy)NSString *device_type;//生产商生产设备类型
@property(nonatomic,copy)NSString *brand;//品牌
@property(nonatomic,copy)NSString *status;//账户状态（是否验证）
@property(nonatomic,copy)NSString *crate_time;//创建时间
@property(nonatomic,copy)NSString *updete_time;//更新时间
@property(nonatomic,copy)NSString *bank_account;//银行账号
@property(nonatomic,copy)NSString *is_delete;//是否已删除
@property(nonatomic,copy)NSString *user_account;//账户余额
@property(nonatomic,copy)NSString *level_authentic;//工程师认证等级



+(ZSDetailRegisterModel *)shareRegist;

@end

//
//  ZSBalanceAddCardTabVCell.h
//  MaintenanceExpert
//
//  Created by xpc on 16/11/30.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZSBalanceAddCardTabVCell : UITableViewCell

//  银行卡icon
@property (strong, nonatomic) UIImageView *cardIcon;
//  银行卡名称
@property (strong, nonatomic) UILabel *cardName;

@property (strong, nonatomic) UILabel *cardNumber;
//  银行卡号 后四位
@property (strong, nonatomic) NSString *cardNubLastFour;

@property (strong, nonatomic) UILabel *cardType;

@end

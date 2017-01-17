//
//  ZSOrderStatusCell.m
//  MaintenanceExpert
//
//  Created by koka on 16/12/6.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSOrderStatusCell.h"

@implementation ZSOrderStatusCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = ViewController_Back_Color;
        [self createUI];
    }
    return self;
}

- (void)createUI {
    
    self.OrderStatusImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 7, 30, 30)];
    self.OrderStatusImageView.clipsToBounds = YES;
    self.OrderStatusImageView.layer.cornerRadius = 15;
    self.OrderStatusImageView.image = [UIImage imageNamed:@"Action_Moments"];
    [self.contentView addSubview:self.OrderStatusImageView];
    
    
    self.OrderStatusLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 5, 200, 34)];
    self.OrderStatusLabel.textAlignment = NSTextAlignmentLeft;
    self.OrderStatusLabel.text = @"订单已完成";
    self.OrderStatusLabel.textColor = Label_Color;
    self.OrderStatusLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.OrderStatusLabel];
}


@end

//
//  ZSHomeSelectedTabCell.m
//  MaintenanceExpert
//
//  Created by xpc on 16/12/28.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSHomeSelectedTabCell.h"

@implementation ZSHomeSelectedTabCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = ViewController_Back_Color;
        [self createUI];
    }
    return self;
}
- (void)createUI {
    
    self.AddressImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 7, 30, 30)];
    self.AddressImageView.image = [UIImage imageNamed:@"icon4"];
    [self.contentView addSubview:self.AddressImageView];
    
    
    self.AddressLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 5, 200, 34)];
    self.AddressLabel.textAlignment = NSTextAlignmentLeft;
    self.AddressLabel.text = @"青岛农业银行（敦化路）机房";
    self.AddressLabel.textColor = Label_Color;
    self.AddressLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.AddressLabel];
}

@end

//
//  ZSMessageViewFirstCell.m
//  MaintenanceExpert
//
//  Created by xpc on 16/12/28.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSMessageViewFirstCell.h"

@implementation ZSMessageViewFirstCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = ViewController_Back_Color;
        
        [self creatCellView];
        
    }
    return self;
}


- (void)creatCellView {
    
    UIImageView *backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, KScreenWidth, 80)];
    backImg.backgroundColor = ViewController_Back_Color;
    backImg.userInteractionEnabled = YES;
    backImg.image = [UIImage imageNamed:@"message_cell_one"];
    backImg.layer.shadowOffset = CGSizeMake(1, 1);
    backImg.layer.shadowOpacity = 0.3;
    backImg.layer.shadowColor = [UIColor blackColor].CGColor;
    [self.contentView addSubview:backImg];
    
    
    //  头像
    UIImageView *headerRing = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
    headerRing.image = [UIImage imageNamed:@"message_header_ring"];
    [backImg addSubview:headerRing];
    
    UIImageView *headerImage = [[UIImageView alloc] init];
    headerImage.image = [UIImage imageNamed:@"defult_header_icon"];
    [headerRing addSubview:headerImage];
    headerImage.sd_layout.spaceToSuperView(UIEdgeInsetsMake(4, 4, 4, 6));
    
    //  消息时间
    UILabel *timeLab = [[UILabel alloc] init];
    timeLab.text = @"2016年12月12日";
    timeLab.textColor = TextField_Text_Color;
    timeLab.textAlignment = NSTextAlignmentRight;
    timeLab.font = [UIFont systemFontOfSize:13];
    [backImg addSubview:timeLab];
    timeLab.sd_layout.topSpaceToView(backImg, 10)
    .rightSpaceToView(backImg, 20)
    .widthIs(150)
    .heightIs(30);
    
    //  昵称
    UILabel *userName = [[UILabel alloc] init];
    userName.text = @"留言";
    userName.textColor = TextField_Text_Color;
    userName.font = [UIFont systemFontOfSize:16];
    [backImg addSubview:userName];
    userName.sd_layout.topSpaceToView(backImg, 10)
    .leftSpaceToView(headerRing, 20)
    .rightSpaceToView(timeLab, 10)
    .heightIs(30);
    
    
    //  消息条数
    UIImageView *imageV = [[UIImageView alloc] init];
    imageV.image = [UIImage imageNamed:@"message_cell_count"];
    [backImg addSubview:imageV];
    imageV.sd_layout.rightSpaceToView(backImg, 30)
    .topSpaceToView(userName, 5)
    .widthIs(25)
    .heightIs(25);
    
    UILabel *numberLab = [[UILabel alloc] init];
    numberLab.text = @"99";
    numberLab.textAlignment = NSTextAlignmentCenter;
    numberLab.textColor = ColorWithRGBA(181, 226, 248, 1);
    numberLab.font = [UIFont systemFontOfSize:12];
    [imageV addSubview:numberLab];
    numberLab.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    
    
    //  消息内容
    UILabel *messageLab = [[UILabel alloc] init];
    messageLab.text = @"王某某: 我给你留言了";
    messageLab.textColor = Label_Color;
    messageLab.font = [UIFont systemFontOfSize:14];
    [backImg addSubview:messageLab];
    messageLab.sd_layout.topSpaceToView(userName, 0)
    .leftEqualToView(userName)
    .rightSpaceToView(imageV, 10)
    .heightIs(30);
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

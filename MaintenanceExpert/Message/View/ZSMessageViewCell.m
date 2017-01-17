//
//  ZSMessageViewCell.m
//  MaintenanceExpert
//
//  Created by xpc on 16/10/28.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSMessageViewCell.h"

@implementation ZSMessageViewCell


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
    backImg.image = [UIImage imageNamed:@"message_cell_defult"];
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
    timeLab.text = @"13:25";
    timeLab.textColor = TextField_Text_Color;
    timeLab.textAlignment = NSTextAlignmentRight;
    timeLab.font = [UIFont systemFontOfSize:13];
    [backImg addSubview:timeLab];
    timeLab.sd_layout.topSpaceToView(backImg, 10)
    .rightSpaceToView(backImg, 40)
    .widthIs(60)
    .heightIs(30);
    
    //  昵称
    UILabel *userName = [[UILabel alloc] init];
    userName.text = @"老张头";
    userName.textColor = TextField_Text_Color;
    userName.font = [UIFont systemFontOfSize:16];
    [backImg addSubview:userName];
    userName.sd_layout.topSpaceToView(backImg, 10)
    .leftSpaceToView(headerRing, 20)
    .rightSpaceToView(timeLab, 10)
    .heightIs(30);
    
    //  消息内容
    UILabel *messageLab = [[UILabel alloc] init];
    messageLab.text = @"我给你发了一条消息,你看到了吗，啦啦啦啦啦啦";
    messageLab.textColor = Label_Color;
    messageLab.font = [UIFont systemFontOfSize:14];
    [backImg addSubview:messageLab];
    messageLab.sd_layout.topSpaceToView(userName, 0)
    .leftEqualToView(userName)
    .rightEqualToView(timeLab)
    .heightIs(30);
    
}




@end

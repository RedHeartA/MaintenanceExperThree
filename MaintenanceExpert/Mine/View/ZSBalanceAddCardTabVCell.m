//
//  ZSBalanceAddCardTabVCell.m
//  MaintenanceExpert
//
//  Created by xpc on 16/11/30.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSBalanceAddCardTabVCell.h"

#define CELL_BGVIEW_HEIGHT 80

@interface ZSBalanceAddCardTabVCell ()

{
    UIImageView *_cellBgImgView;
    
}

@end

@implementation ZSBalanceAddCardTabVCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = ViewController_Back_Color;
        
        [self creatCellBackView];
        [self creatView];
    }
    
    return self;
}

- (void)creatCellBackView {
    
    _cellBgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, KScreenWidth - 10, CELL_BGVIEW_HEIGHT)];
    _cellBgImgView.backgroundColor = ColorWithRGBA(30, 54, 98, 1);
    _cellBgImgView.layer.cornerRadius = 5;
    _cellBgImgView.layer.masksToBounds = YES;
    [self.contentView addSubview:_cellBgImgView];
}

- (void)creatView {
    
    _cardIcon = [[UIImageView alloc] init];
    _cardIcon.backgroundColor = [UIColor redColor];
    _cardIcon.layer.cornerRadius = 30;
    _cardIcon.layer.masksToBounds = YES;    //  clipsToBounds
//    _cardIcon.clipsToBounds = YES;
    [_cellBgImgView addSubview:_cardIcon];
    _cardIcon.sd_layout.leftSpaceToView(_cellBgImgView, 20)
    .topSpaceToView(_cellBgImgView, 10)
    .widthIs(60)
    .heightIs(60);
    
    _cardName = [[UILabel alloc] init];
    _cardName.textColor = Label_Color;
    _cardName.font = [UIFont systemFontOfSize:16];
    [_cellBgImgView addSubview:_cardName];
    _cardName.sd_layout.leftSpaceToView(_cardIcon, 20)
    .topEqualToView(_cardIcon)
    .widthIs(KScreenWidth* 0.4)
    .heightIs(30);
    
    _cardType = [[UILabel alloc] init];
    _cardType.textColor = Label_Color;
    _cardType.textAlignment = NSTextAlignmentRight;
    _cardType.font = [UIFont systemFontOfSize:14];
    [_cellBgImgView addSubview:_cardType];
    _cardType.sd_layout.rightSpaceToView(_cellBgImgView, 30)
    .topEqualToView(_cardName)
    .widthIs(80)
    .heightIs(30);
    
    _cardNumber = [[UILabel alloc] init];
    _cardNumber.textColor = Label_Color;
    _cardNubLastFour = [[NSString alloc]init];
    _cardNumber.textAlignment = NSTextAlignmentRight;
    _cardNumber.font = [UIFont systemFontOfSize:20 weight:2];
    [_cellBgImgView addSubview:_cardNumber];
    _cardNumber.sd_layout.rightSpaceToView(_cellBgImgView, 30)
    .topSpaceToView(_cardName, 5)
    .leftEqualToView(_cardName)
    .heightIs(30);
//    
//    UIImageView *starNum = [[UIImageView alloc] init];
//    starNum.image = [UIImage imageNamed:@"bankCard_starNum"];
//    [_cellBgImgView addSubview:starNum];
//    starNum.sd_layout.rightSpaceToView(_cardNumber, 10)
//    .topSpaceToView(_cardName, 15)
//    .widthIs(80)
//    .heightIs(15);
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

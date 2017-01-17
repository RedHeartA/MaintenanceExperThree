//
//  ZSHomeTableViewCell.m
//  MaintenanceExpert
//
//  Created by xpc on 16/11/4.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSHomeTableViewCell.h"

@implementation ZSHomeTableViewCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        self.backgroundColor = ViewController_Back_Color;
//        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_cell_backImg"]];
        
        [self creatCellView];
        
    }
    
    return self;
}


- (void)creatCellView {
    
    
    UIImageView *cellBackImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 7, KScreenWidth, KScreenHeight *0.09)];
    cellBackImg.contentMode = UIViewContentModeScaleAspectFill;
    cellBackImg.userInteractionEnabled = YES;
    //  设置阴影
    cellBackImg.layer.shadowOffset = CGSizeMake(1, 1);
    cellBackImg.layer.shadowOpacity = 0.3;
    cellBackImg.layer.shadowColor = [UIColor blackColor].CGColor;
    cellBackImg.image = [UIImage imageNamed:@"home_cell_backImg"];
    [self addSubview:cellBackImg];
    
    _homeImgType = [[UIImageView alloc] initWithFrame:CGRectMake(10, 3, KScreenHeight * 0.09 - 10, KScreenHeight * 0.09 - 10)];
    _homeImgType.image = [UIImage imageNamed:@"home_wei"];
//    _homeImgType.backgroundColor = [UIColor cyanColor];
    [cellBackImg addSubview:_homeImgType];
    
    //  机房位置
    _homeCellAddress = [[UILabel alloc] init];
//    _homeCellAddress.backgroundColor = [UIColor cyanColor];
    _homeCellAddress.text = @"青岛市北区政府";
    _homeCellAddress.textColor = Home_Order_titleColor;
    [_homeCellAddress setFont:[UIFont systemFontOfSize:14]];
    CGSize size = [_homeCellAddress.text sizeWithFont:_homeCellAddress.font constrainedToSize:CGSizeMake(MAXFLOAT, _homeCellAddress.frame.size.height)];
    [cellBackImg addSubview:_homeCellAddress];
    _homeCellAddress.sd_layout.leftSpaceToView(_homeImgType, 8)
    .topEqualToView(_homeImgType)
    .widthIs(size.width)
    .heightRatioToView(_homeImgType, 0.4);
    
    //  分类
    _homeCellType = [[UILabel alloc] init];
//    _homeCellType.backgroundColor = [UIColor magentaColor];
    _homeCellType.text = @"故障分类:机房供电";
    _homeCellType.textColor = Home_Order_secendColor;
    [_homeCellType setFont:[UIFont systemFontOfSize:10]];
    [cellBackImg addSubview:_homeCellType];
    _homeCellType.sd_layout.leftSpaceToView(_homeImgType, 8)
    .topSpaceToView(_homeCellAddress, 2)
    .widthIs(90)
    .heightRatioToView(_homeImgType, 0.25);
    
    //  机房等级
    _homeCellGrades = [[UILabel alloc] init];
//    _homeCellGrades.backgroundColor = [UIColor cyanColor];
    _homeCellGrades.text = @"机房等级:A";
    _homeCellGrades.textColor = Home_Order_secendColor;
    [_homeCellGrades setFont:[UIFont systemFontOfSize:10]];
    [cellBackImg addSubview:_homeCellGrades];
    _homeCellGrades.sd_layout.bottomEqualToView(_homeImgType)
    .leftEqualToView(_homeCellType)
    .widthIs(KScreenWidth * 0.23)
    .heightRatioToView(_homeImgType, 0.25);
    
    //  距离
    UIImageView *distabceImg = [[UIImageView alloc] init];
    distabceImg.image = [UIImage imageNamed:@"home_jvli"];
    distabceImg.contentMode = UIViewContentModeScaleAspectFill;
    [cellBackImg addSubview:distabceImg];
    distabceImg.sd_layout.topEqualToView(_homeImgType)
    .rightSpaceToView(cellBackImg, 10)
    .widthRatioToView(_homeImgType, 0.8)
    .heightRatioToView(_homeImgType, 0.8);
    
    _homeCellDistance = [[UILabel alloc] init];
//    _homeCellDistance.backgroundColor = [UIColor cyanColor];
    _homeCellDistance.text = [NSString stringWithFormat:@"0.20\nKm"];
    _homeCellDistance.numberOfLines = 2;    //表示label可以多行显示
    _homeCellDistance.textColor = ColorWithRGBA(122, 100, 255, 1);
    _homeCellDistance.textAlignment = NSTextAlignmentCenter;
    [_homeCellDistance setFont:[UIFont systemFontOfSize:11]];
    [distabceImg addSubview:_homeCellDistance];
    _homeCellDistance.sd_layout.spaceToSuperView(UIEdgeInsetsMake(7, 5, 5, 5));
//    _homeCellDistance.sd_layout.topEqualToView(_homeImgType)
//    .rightSpaceToView(cellBackImg, 10)
//    .widthIs(60)
//    .heightRatioToView(_homeImgType, 0.5);
    
    //  发布日期
    _homeCellTime = [[UILabel alloc] init];
//    _homeCellTime.backgroundColor = [UIColor cyanColor];
    _homeCellTime.text = @"发布日期:2016/11/11";
    _homeCellTime.textColor = ColorWithRGBA(4, 151, 213, 1);
    _homeCellTime.textAlignment = NSTextAlignmentRight;
    [_homeCellTime setFont:[UIFont systemFontOfSize:10]];
    [cellBackImg addSubview:_homeCellTime];
    _homeCellTime.sd_layout.topEqualToView(_homeCellGrades)
    .rightSpaceToView(cellBackImg, 10)
    .widthIs(100)
    .heightRatioToView(_homeImgType, 0.25);
    
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

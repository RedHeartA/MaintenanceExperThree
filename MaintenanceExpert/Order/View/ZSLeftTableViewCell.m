//
//  ZSLeftTableViewCell.m
//  MaintenanceExpert
//
//  Created by xpc on 16/10/31.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSLeftTableViewCell.h"

#define BGVIEW_HEIGHT 120

@interface ZSLeftTableViewCell ()

@property(strong, nonatomic)UIView *bgView;

@end


@implementation ZSLeftTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = ViewController_Back_Color;
        //  设置 Cell 点击后 不变灰
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self creatBackUI];
        [self creatView];
        
    }
    return self;
}


- (void)creatBackUI {
    
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, KScreenWidth, BGVIEW_HEIGHT)];
    _bgView.backgroundColor = UIView_BackView_color;
    //  为边框设置阴影
    _bgView.layer.shadowOffset = CGSizeMake(1, 1);
    _bgView.layer.shadowOpacity = 0.3;
    _bgView.layer.shadowColor = [UIColor blackColor].CGColor;
    [self.contentView addSubview:_bgView];
    
    UIImageView *leftTop = [[UIImageView alloc] init];
    leftTop.image = [UIImage imageNamed:@"dingdan-LeftTop"];
    [_bgView addSubview:leftTop];
    leftTop.sd_layout.topSpaceToView(_bgView, 5)
    .leftSpaceToView(_bgView, 3)
    .widthIs(20)
    .heightIs(20);
    
    UIImageView *leftBottom = [[UIImageView alloc] init];
    leftBottom.image = [UIImage imageNamed:@"dingdan-LeftBottom"];
    [_bgView addSubview:leftBottom];
    leftBottom.sd_layout.bottomSpaceToView(_bgView, 5)
    .leftSpaceToView(_bgView, 3)
    .widthIs(20)
    .heightIs(20);
    
    UIImageView *rightTop = [[UIImageView alloc] init];
    rightTop.image = [UIImage imageNamed:@"dingdan-RightTop"];
    [_bgView addSubview:rightTop];
    rightTop.sd_layout.topSpaceToView(_bgView, 5)
    .rightSpaceToView(_bgView, 3)
    .widthIs(20)
    .heightIs(20);
    
    UIImageView *rightBottom = [[UIImageView alloc] init];
    rightBottom.image = [UIImage imageNamed:@"dingdan-RightBottom"];
    [_bgView addSubview:rightBottom];
    rightBottom.sd_layout.bottomSpaceToView(_bgView, 5)
    .rightSpaceToView(_bgView, 3)
    .widthIs(20)
    .heightIs(20);
}

- (void)creatView {
    
    //  类型  图片
    _imgType = [[UIImageView alloc] init];
//    _imgType.backgroundColor = [UIColor cyanColor];
    //[_imgType setImage:[UIImage imageNamed:@"home_xiu"]];
    [_bgView addSubview:_imgType];
    _imgType.sd_layout.topSpaceToView(_bgView, 13)
    .leftSpaceToView(_bgView, 8)
    .widthIs(60)
    .heightEqualToWidth(_imgType);
    
    //  地址
    _address = [[UILabel alloc] init];
//    _address.backgroundColor = [UIColor cyanColor];
    //_address.text = @"青岛市敦化路325号青岛银行机房建设建设建设建设建设";
    _address.textColor = Home_Order_titleColor;
    [_address setFont:[UIFont systemFontOfSize:15]];
    [_bgView addSubview:_address];
    _address.sd_layout.leftSpaceToView(_imgType, 10)
    .topEqualToView(_imgType)
    .rightSpaceToView(_bgView, 30)
    .heightIs(20);
    
    //  价格
    _money = [[UILabel alloc] init];
//    _money.backgroundColor = [UIColor cyanColor];
    //_money.text = @"¥5000.00/次*12";
    _money.textColor = Home_Order_secendColor;
    [_money setFont:[UIFont systemFontOfSize:12]];
    [_bgView addSubview:_money];
    _money.sd_layout.leftEqualToView(_address)
    .topSpaceToView(_address, 5)
    .widthIs(120)
    .heightIs(15);
    
    //  巡检/故障 图片
    _imgXunJian = [[UIImageView alloc] init];
//    _imgXunJian.backgroundColor = [UIColor cyanColor];
    [_imgXunJian setImage:[UIImage imageNamed:@"clock"]];
    [_bgView addSubview:_imgXunJian];
    _imgXunJian.sd_layout.leftEqualToView(_money)
    .bottomEqualToView(_imgType)
    .widthIs(15)
    .heightIs(15);
    
    UILabel *xunjianLabel = [[UILabel alloc] init];
    //xunjianLabel.text = @"定期巡检";
    xunjianLabel.textColor = Home_Order_secendColor;
    xunjianLabel.font = [UIFont systemFontOfSize:12];
    [_bgView addSubview:xunjianLabel];
    xunjianLabel.sd_layout.topEqualToView(_imgXunJian)
    .leftSpaceToView(_imgXunJian, 1)
    .widthIs(60)
    .heightIs(15);
    _xunjianLabel = xunjianLabel;
    
    //  横线
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = Line_Color;
    [_bgView addSubview:line];
    line.sd_layout.leftSpaceToView(_bgView, 0)
    .topSpaceToView(_bgView, (_bgView.frame.size.height / 3)*2)
    .rightSpaceToView(_bgView, 0)
    .heightIs(1);
    
    //  发布日期
    _releaseTime = [[UILabel alloc] init];
//    _releaseTime.backgroundColor = [UIColor cyanColor];
    //_releaseTime.text = @"发布日期:2016年09月01日";
    _releaseTime.textColor = Home_Order_secendColor;
    [_releaseTime setFont:[UIFont systemFontOfSize:10]];
    [_bgView addSubview:_releaseTime];
    _releaseTime.sd_layout.rightSpaceToView(_bgView, 8)
    .bottomEqualToView(_imgXunJian)
    .widthIs(130)
    .heightIs(10);
    
    //  剩余时间
    _timeShengYu = [[UILabel alloc] init];
//    _timeShengYu.backgroundColor = [UIColor cyanColor];
    _timeShengYu.text = @"还剩7天1小时";
    _timeShengYu.textColor = Home_Order_secendColor;
    [_timeShengYu setFont:[UIFont systemFontOfSize:10]];
    [_bgView addSubview:_timeShengYu];
    _timeShengYu.sd_layout.bottomSpaceToView(_releaseTime, 1)
    .rightEqualToView(_releaseTime)
    .widthIs(80)
    .heightIs(10);
    
    
    //  下次巡检时间/发布日期
    _nextXunJian = [[UILabel alloc] init];
//    _nextXunJian.backgroundColor = [UIColor cyanColor];
    //_nextXunJian.text = @"下次巡检:2016年10月28日";
    _nextXunJian.textColor = Home_Order_secendColor;
    [_nextXunJian setFont:[UIFont systemFontOfSize:10]];
    [_bgView addSubview:_nextXunJian];
    _nextXunJian.sd_layout.rightSpaceToView(_bgView, 8);
    _nextXunJian.sd_layout.bottomSpaceToView(_timeShengYu, 1)
    .rightEqualToView(_timeShengYu)
    .widthIs(130)
    .heightIs(10);
    
    
    //  联系
    UIButton *callBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [callBtn setBackgroundImage:[UIImage imageNamed:@"calling"] forState:UIControlStateNormal];
    [_bgView addSubview:callBtn];
    callBtn.sd_layout.leftSpaceToView(_bgView, 73)
    .topSpaceToView(line, 13)
    .widthIs(15)
    .heightIs(15);
    
    //  联系客户
    _relation = [[UIButton alloc] init];
//    _relation.backgroundColor = [UIColor cyanColor];
//    [_relation setBackgroundImage:[UIImage imageNamed:@"lianxi"] forState:UIControlStateNormal];
    [_relation setTitle:@"联系客服" forState:UIControlStateNormal];
    [_relation setTitleColor:Home_Order_secendColor forState:UIControlStateNormal];
    [_relation.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_relation addTarget:self action:@selector(leftRelationButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:_relation];
    _relation.sd_layout.leftSpaceToView(callBtn, 1)
    .topSpaceToView(line, 10)
    .widthIs(60)
    .heightIs(20);
    
    //  更多
//    _another = [[UIButton alloc] init];
//    _another.backgroundColor = [UIColor cyanColor];
//    [_another setTitle:@"● ● ●" forState:UIControlStateNormal];
//    [_another setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [_another.titleLabel setFont:[UIFont systemFontOfSize:10]];
//    [_another addTarget:self action:@selector(anotherButtonClick) forControlEvents:UIControlEventTouchDown];
//    [_bgView addSubview:_another];
//    _another.sd_layout.rightSpaceToView(_bgView, 10)
//    .topSpaceToView(line, 10)
//    .widthIs(33)
//    .heightIs(33);
    
    
    //  查看评价
//    _appraisal = [[UIButton alloc] init];
//    _appraisal.backgroundColor = [UIColor cyanColor];
//    [_appraisal setTitle:@"查看评价" forState:UIControlStateNormal];
//    [_appraisal setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [_appraisal.titleLabel setFont:[UIFont systemFontOfSize:16]];
//    [_appraisal addTarget:self action:@selector(appraisalButtonClick) forControlEvents:UIControlEventTouchDown];
//    [_bgView addSubview:_appraisal];
//    _appraisal.sd_layout.rightSpaceToView(_another, 10)
//    .topEqualToView(_another)
//    .widthIs(90)
//    .heightIs(33);
    
    
}

- (void)layoutSubviews {
    
//    [_imgType setImage:[UIImage imageNamed:@"home_xiu"]];
//    _address.text = @"青岛市敦化路325号青岛银行机房建设建设建设建设建设";
//    _money.text = @"¥5000.00/次*12";
//    _xunjianLabel.text = @"定期巡检";
//    _releaseTime.text = @"发布日期:2016年09月01日";
//    _nextXunJian.text = @"下次巡检:2016年10月28日";
    [_imgType setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",self.model.kindImageName]]];
    _address.text = self.model.title;
    _money.text = [NSString stringWithFormat:@"¥%@/次*12",self.model.price];
    _xunjianLabel.text = self.model.orderStatus;
    _releaseTime.text = [NSString stringWithFormat:@"发布日期:%@",self.model.pushorderTime];
    _nextXunJian.text = [NSString stringWithFormat:@"下次巡检:%@",self.model.receiveorderTime];
    
}

- (void)btnClick {
    
    NSLog(@"按钮被点击");
}

+ (CGFloat)getHeight{
    //在这里能计算高度，动态调整
    return BGVIEW_HEIGHT;
}


//  联系客户 按钮
- (void)leftRelationButtonClick {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"联系客户" delegate:self cancelButtonTitle:@"电话" otherButtonTitles:@"短信", nil];

    [alertView show];
    
}

//  查看评价 按钮
- (void)appraisalButtonClick {
    NSLog(@"查看评价");
}

//  更多 按钮 跳转到订单状态
- (void)anotherButtonClick {
    
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  ZSOrderStatusView.m
//  MaintenanceExpert
//
//  Created by koka on 16/12/6.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSOrderStatusView.h"

@implementation ZSOrderStatusView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(19, 29, 27, 27)];
    image.backgroundColor = ColorWithRGBA(24, 63, 105, 1);
    image.layer.borderWidth = 1.0;
    image.layer.borderColor = ColorWithRGBA(67, 169, 190, 1).CGColor;
    image.layer.cornerRadius = 13.5;
    [self addSubview:image];
    
    [self addSubview:self.Statusimageview];
    [self addSubview:self.backgroundimageview];
    [self.backgroundimageview addSubview:self.Statuslabel];
    [self.backgroundimageview addSubview:self.StatusSublabel];
    [self.backgroundimageview addSubview:self.Timelabel];
}

- (UIImageView *)Statusimageview {
    if (!_Statusimageview) {
        _Statusimageview = [[UIImageView alloc]initWithFrame:CGRectMake(24.5, 34.5, 16, 16)];
        _Statusimageview.layer.cornerRadius = 12.5;

    }
    return _Statusimageview;
}

- (UIImage *)backimage {
    if (!_backimage) {
        _backimage =[UIImage imageNamed:@"ReceiverTextNodeBkg"];
        _backimage = [self.backimage stretchableImageWithLeftCapWidth:self.backimage.size.width * 0.5 topCapHeight:0];
    }
    return _backimage;
}

- (UIImageView *)backgroundimageview {
    if (!_backgroundimageview) {
        _backgroundimageview = [[UIImageView alloc]initWithFrame:CGRectMake(55, 10, KScreenWidth - 65, 60)];
        _backgroundimageview.image = self.backimage;
        //_backgroundimageview.alpha = 0.4;
    }
    return _backgroundimageview;
}

- (UILabel *)Statuslabel {
    if (!_Statuslabel) {
        _Statuslabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, 200, 20)];
        _Statuslabel.textAlignment = NSTextAlignmentLeft;
        _Statuslabel.textColor =ColorWithRGBA(92, 232, 226, 1);
    }
    return _Statuslabel;
}

- (UILabel *)StatusSublabel {
    if (!_StatusSublabel) {
        _StatusSublabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 30, KScreenWidth, 20)];
        _StatusSublabel.textColor = ColorWithRGBA(63, 174, 193, 1);
        _StatusSublabel.textAlignment = NSTextAlignmentLeft;
        _StatusSublabel.font = [UIFont systemFontOfSize:13];
    }
    return _StatusSublabel;
}

- (UILabel *)Timelabel {
    if (!_Timelabel) {
        _Timelabel = [[UILabel alloc]initWithFrame:CGRectMake(self.backgroundimageview.frame.size.width * 3 / 4, 5, KScreenWidth/4, 20)];
        _Timelabel.textColor = ColorWithRGBA(56, 144, 158, 1);
        _Timelabel.text = @"10/20 11:09";
        _Timelabel.textAlignment = NSTextAlignmentLeft;
        _Timelabel.font = [UIFont systemFontOfSize:13];
    }
    return _Timelabel;
}
@end

//
//  ZSOrderStatusView.h
//  MaintenanceExpert
//
//  Created by koka on 16/12/6.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZSOrderStatusView : UIView

@property(nonatomic,strong)UIImageView *Statusimageview;
@property(nonatomic,strong)UIImageView *backgroundimageview;
@property(nonatomic,strong)UILabel *Statuslabel;
@property(nonatomic,strong)UILabel *StatusSublabel;
@property(nonatomic,strong)UILabel *Timelabel;
@property(nonatomic,strong)UIImage *backimage;

- (void)setupUI;


@end

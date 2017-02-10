//
//  ZSBalanceViewController.m
//  MaintenanceExpert
//
//  Created by xpc on 16/11/14.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSBalanceViewController.h"
#import "ZSBalanceAddCardVc.h"
#import "ZSBalanceRechargeVc.h"
#import "ZSBalanceCashVc.h"

@interface ZSBalanceViewController ()

{
    UIView *_backView;
    UIImageView *_headerRing;
    UIImageView *_moneyIcon;
    
    UIImageView *_moneyimageview;
    UILabel *_moneynum;
}

@end

@implementation ZSBalanceViewController

- (void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBarHidden = NO;
    
    
    //  头像动画
    if (!_headerRing) {
        
    }else{
        
        CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        basicAnimation.fromValue = @0;
        basicAnimation.toValue = @(2*M_PI);
        basicAnimation.duration = 10;
        basicAnimation.repeatCount = HUGE_VALF;
        basicAnimation.removedOnCompletion = NO;
        basicAnimation.fillMode = kCAFillModeBoth;
        [_headerRing.layer addAnimation:basicAnimation forKey:@"rotation"];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = ViewController_Back_Color;
    view.frame = CGRectMake(0, -64, KScreenWidth, 64);
    [self.view addSubview:view];
    
    self.view.backgroundColor = ViewController_Back_Color;
    
    
    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,35,35)];
    [rightButton setImage:[UIImage imageNamed:@"card"]forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(bankCardBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self creatMoneyImage];
    
    [self creatAnimation];
}


- (void)creatMoneyImage {
    
    if (iPhone5SE) {
        
        _backView = [[UIView alloc] initWithFrame:CGRectMake(10, 20, KScreenWidth - 20, KScreenHeight * 0.32)];
    }else {
        
        _backView = [[UIView alloc] initWithFrame:CGRectMake(10, 20, KScreenWidth - 20, KScreenHeight * 0.3)];
    }
    
    _backView.backgroundColor = UIView_BackView_color;
    _backView.layer.cornerRadius = 2;
    _backView.layer.shadowOffset = CGSizeMake(0, 2);
    _backView.layer.shadowOpacity = 0.5;
    _backView.layer.shadowColor = [UIColor blackColor].CGColor;
    [self.view addSubview:_backView];
    
    
    UIView *headerBackView = [[UIView alloc] init];
    [_backView addSubview:headerBackView];
    headerBackView.sd_layout.topSpaceToView(_backView, 15)
    .leftSpaceToView(_backView, KScreenWidth/2 - KScreenWidth/8 -10)
    .widthIs(KScreenWidth/4)
    .heightIs(KScreenWidth/4);
    
    //  -----
    _headerRing = [[UIImageView alloc] init];
    _headerRing.image = [UIImage imageNamed:@"balance_back_icon"];
    [_backView addSubview:_headerRing];
    _headerRing.sd_layout.topSpaceToView(_backView, 15)
    .leftSpaceToView(_backView, KScreenWidth/2 - KScreenWidth/8 -10)
    .widthIs(KScreenWidth/4)
    .heightIs(KScreenWidth/4);
    
    
    _moneyIcon = [[UIImageView alloc] init];
    _moneyIcon.image = [UIImage imageNamed:@"defult_header_icon"];
    _moneyIcon.layer.cornerRadius = _moneyIcon.frame.size.width / 2;
    _moneyIcon.layer.masksToBounds = YES;
    _moneyIcon.contentMode = UIViewContentModeScaleAspectFill;
    [headerBackView addSubview:_moneyIcon];
    _moneyIcon.sd_layout.spaceToSuperView(UIEdgeInsetsMake(5, 5, 5, 5));
    
    
    [self creatlabel];
    [self createButton];
}

- (void)creatlabel {
    
    UILabel *moneylabel = [[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth/2 - KScreenWidth/4 -10, _headerRing.frame.origin.y +KScreenWidth/4 +30, KScreenWidth/2, 30)];
    moneylabel.textAlignment = NSTextAlignmentCenter;
    moneylabel.text = @"账户余额";
    moneylabel.textColor = ColorWithRGBA(98, 191, 244, 1);
    moneylabel.font = [UIFont systemFontOfSize:20];
    [_backView addSubview:moneylabel];
    
    _moneynum = [[UILabel alloc]initWithFrame:CGRectMake(0, moneylabel.frame.origin.y +moneylabel.frame.size.height, KScreenWidth -20, 30)];
    _moneynum.textAlignment = NSTextAlignmentCenter;
    NSString *str = @"10000.00";
    _moneynum.textColor = ColorWithRGBA(98, 191, 244, 1);
    _moneynum.font = [UIFont systemFontOfSize:25];
    _moneynum.text = [NSString stringWithFormat:@"￥%@",str];
    [_backView addSubview:_moneynum];
    
}

- (void)createButton {
    
    UIButton *rechargeBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, _backView.frame.origin.y + _backView.frame.size.height + 30, KScreenWidth - 20, 40)];
    [rechargeBtn setBackgroundImage:[UIImage imageNamed:@"wancheng"] forState:UIControlStateNormal];
    [rechargeBtn setTitle:@"充    值" forState:UIControlStateNormal];
    rechargeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    rechargeBtn.titleLabel.font = [UIFont systemFontOfSize:20 weight:1];
    rechargeBtn.layer.cornerRadius = 10;
    [self.view addSubview:rechargeBtn];
    [rechargeBtn addTarget:self action:@selector(rechargeBtnClick) forControlEvents:UIControlEventTouchDown];
    
    UIButton *CashBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, rechargeBtn.frame.origin.y + rechargeBtn.frame.size.height + 10, KScreenWidth - 20, 40)];
    [CashBtn setBackgroundImage:[UIImage imageNamed:@"wancheng-hov"] forState:UIControlStateNormal];
    [CashBtn setTitle:@"提    现" forState:UIControlStateNormal];
    CashBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    CashBtn.titleLabel.font = [UIFont systemFontOfSize:20 weight:1];
    CashBtn.layer.cornerRadius = 10;
    [self.view addSubview:CashBtn];
    [CashBtn addTarget:self action:@selector(CashBtnClick) forControlEvents:UIControlEventTouchDown];
    
}

- (void)creatAnimation {
    
    UIImageView *backimageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"OrderBackBig"]];
    backimageview.frame = CGRectMake(0, KScreenHeight/5 -64, KScreenWidth, KScreenWidth);
    
    CABasicAnimation *basicAnimation1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    basicAnimation1.fromValue = @(2*M_PI);
    basicAnimation1.toValue = @0;
    basicAnimation1.duration = 15;
    basicAnimation1.repeatCount = 20;
    basicAnimation1.removedOnCompletion = NO;
    basicAnimation1.fillMode = kCAFillModeBoth;
    [backimageview.layer addAnimation:basicAnimation1 forKey:@"rotation"];
    
    [self.view addSubview:backimageview];
    
}


//  bankCardBtnClick 添加银行卡
- (void)bankCardBtnClick {
    
    ZSBalanceAddCardVc *addCard = [[ZSBalanceAddCardVc alloc] init];
    [self.navigationController pushViewController:addCard animated:YES];
}

//  提现按钮方法
- (void)rechargeBtnClick {
    
    ZSBalanceRechargeVc *rechargeVc = [[ZSBalanceRechargeVc alloc] init];
    [self.navigationController pushViewController:rechargeVc animated:YES];
    
    NSLog(@"提现");
}

//  充值按钮方法
- (void)CashBtnClick {
    
    ZSBalanceCashVc *cashVc = [[ZSBalanceCashVc alloc] init];
    [self.navigationController pushViewController:cashVc animated:YES];
    
    NSLog(@"充值");
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

//
//  ZSBalanceRechargeVc.m
//  MaintenanceExpert
//
//  Created by xpc on 16/11/22.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSBalanceRechargeVc.h"
#import "ZSBalanceRechargeOkVc.h"
#import "GalenPayPasswordView.h"


#define ColorHUI [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1.0]

@interface ZSBalanceRechargeVc ()<UITextFieldDelegate, UIAlertViewDelegate>


@property(nonatomic,strong)UIView * backView;
@property(nonatomic,strong)UIView * keyBordView;
@property(nonatomic,strong)UIView * PhotoView;

@end

@implementation ZSBalanceRechargeVc

- (void)donghuaView:(UIView*)view  Rect:(CGRect)rect {
    [UIView beginAnimations:@"animationID" context:nil];
    [UIView setAnimationDuration:0.35f];
    [view setFrame:rect];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:view cache:YES];
    [UIView commitAnimations];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"充值页面";
    self.view.backgroundColor = ViewController_Back_Color;
    
    [self creatAnimation];
    
    [self creatRechargeView];
}



///** 视图完全显示 */
//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    
//    // 弹出键盘
//    [self.moneyTF becomeFirstResponder];
//}

///** 视图将要消失 */
//- (void)viewWillDisappear:(BOOL)animated {
//    
//    [super viewWillDisappear:animated];
//    
//    //  移除键盘
//    [self.moneyTF resignFirstResponder];
//}


- (void)creatAnimation {
    
    UIImageView *backimageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"OrderBackBig"]];
    backimageview.frame = CGRectMake(0, KScreenHeight/5 -64, KScreenWidth, KScreenWidth);
    
    CABasicAnimation *basicAnimation1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    basicAnimation1.fromValue = @(2*M_PI);
    basicAnimation1.toValue = @0;
    basicAnimation1.duration = 15;
    basicAnimation1.repeatCount = HUGE_VALF;
    basicAnimation1.removedOnCompletion = NO;
    basicAnimation1.fillMode = kCAFillModeBoth;
    [backimageview.layer addAnimation:basicAnimation1 forKey:@"rotation"];
    
    [self.view addSubview:backimageview];
    
}

- (void)creatRechargeView {
    
    UIView *BGView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, KScreenWidth, 130)];
    BGView.backgroundColor = UIView_BackView_color;
    [self.view addSubview:BGView];
    
    //  银行卡Label
    UILabel *bankCard = [[UILabel alloc] init];  // WithFrame:CGRectMake(20, 10, 60, 30)];
    bankCard.text = @"银行卡";
    bankCard.textColor = Label_Color;
    bankCard.font = [UIFont systemFontOfSize:16];
    [BGView addSubview:bankCard];
    bankCard.sd_layout.leftSpaceToView(BGView, 20)
    .topSpaceToView(BGView, 10)
    .widthIs(60)
    .heightIs(30);
    
    //  银行/卡号
    _cardNumb = [[UILabel alloc] init];
    _cardNumb.text = @"中国银行储蓄卡(8888)";
    _cardNumb.textColor = TextField_Text_Color;
    _cardNumb.font = [UIFont systemFontOfSize:15];
    [BGView addSubview:_cardNumb];
    _cardNumb.sd_layout.leftSpaceToView(bankCard, 10)
    .topEqualToView(bankCard)
    .widthRatioToView(BGView, 0.5)
    .heightIs(30);
    
#warning 换个图
    //  按钮
//    UIButton *chooseCard = [UIButton buttonWithType:UIButtonTypeCustom];
//    [chooseCard setBackgroundImage:[UIImage imageNamed:@"2_2"] forState:UIControlStateNormal];
//    [BGView addSubview:chooseCard];
//    chooseCard.sd_layout.topSpaceToView(BGView, 17)
//    .leftSpaceToView(_cardNumb, 20)
//    .heightIs(15)
//    .widthIs(15);
    
    //  银行卡单日交易限额
    UILabel *xianZhi = [[UILabel alloc] init];
    xianZhi.text = @"单日交易限额¥20000.00";
    xianZhi.textColor = Label_Color;
    xianZhi.font = [UIFont systemFontOfSize:14];
    [BGView addSubview:xianZhi];
    xianZhi.sd_layout.leftEqualToView(_cardNumb)
    .topSpaceToView(_cardNumb, 5)
    .widthRatioToView(BGView, 0.5)
    .heightIs(30);
    
    //  分割线
    UIView *lianView = [[UIView alloc] init];  // WithFrame:CGRectMake(10, 80, KScreenWidth - 20, 1)];
    lianView.backgroundColor = Line_Color;
    [BGView addSubview:lianView];
    lianView.sd_layout.leftSpaceToView(BGView, 10)
    .topSpaceToView(xianZhi, 5)
    .rightSpaceToView(BGView, 10)
    .heightIs(1);
    
    //  金额(¥)Label
    UILabel *money = [[UILabel alloc] init];
//    money.backgroundColor = [UIColor cyanColor];
    money.text = @"金额(¥)";
    money.textColor = Label_Color;
    money.font = [UIFont systemFontOfSize:16];
    [BGView addSubview:money];
    money.sd_layout.leftEqualToView(bankCard)
    .topSpaceToView(lianView, 10)
    .widthIs(60)
    .heightIs(30);
    
    //  填写金额
    _moneyTF = [[UITextField alloc] init];
    _moneyTF.textColor = TextField_Text_Color;
    NSString *moneyStr = @"";
    NSMutableAttributedString *placeholderMoney = [[NSMutableAttributedString alloc]initWithString:moneyStr];
    [placeholderMoney addAttribute:NSForegroundColorAttributeName
                                 value:Placeholder_Color
                                 range:NSMakeRange(0, moneyStr.length)];
    _moneyTF.attributedPlaceholder = placeholderMoney;
    _moneyTF.delegate = self;
    _moneyTF.keyboardType = UIKeyboardTypeNumberPad;
    [BGView addSubview:_moneyTF];
    _moneyTF.sd_layout.leftEqualToView(_cardNumb)
    .topEqualToView(money)
    .widthRatioToView(BGView, 0.5)
    .heightIs(30);
    
    //  下一步 按钮
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setBackgroundImage:[UIImage imageNamed:@"wancheng"] forState:UIControlStateNormal];
    [nextBtn setBackgroundImage:[UIImage imageNamed:@"wancheng-hov"] forState:UIControlStateHighlighted];
    [nextBtn setTitle:@"提 交" forState:UIControlStateNormal];
    nextBtn.layer.cornerRadius = 3;
    [nextBtn addTarget:self action:@selector(nextButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    nextBtn.sd_layout.leftSpaceToView(self.view, 15)
    .topSpaceToView(BGView, 20)
    .rightSpaceToView(self.view, 15)
    .heightIs(40);
    
}




- (void)nextButtonClick {
    
    [_moneyTF resignFirstResponder];
    
    if ([_moneyTF.text isEqual: @""]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请填写金额" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alert show];
    }else if(_moneyTF.text != (NSString *)@""){
        
        [self rechargePayPasswordView];
    }
}



#pragma mark - 键盘响应  //
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_moneyTF resignFirstResponder];
    
}

#define mark - 支付密码输入框
- (void)rechargePayPasswordView {
    
    GalenPayPasswordView *payPassword=[GalenPayPasswordView tradeView];
    [payPassword showInView:self.view.window];
    
    __block typeof(GalenPayPasswordView *) blockPay=payPassword;
    [payPassword setFinish:^(NSString * pwd) {
        
        [blockPay showProgressView:@"正在处理..."];
        
        [blockPay performSelector:@selector(showSuccess:) withObject:self afterDelay:3.0];
        
#warning 这里页面跳转，代码位置要变动！
        ZSBalanceRechargeOkVc *rechargeOk = [[ZSBalanceRechargeOkVc alloc] init];
        [self.navigationController pushViewController:rechargeOk animated:YES];
        
    }];
    
    
    [payPassword setLessPassword:^{
        
        
        NSLog(@"忘记密码？");
    }];
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

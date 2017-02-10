//
//  ZSBalanceCashVc.m
//  MaintenanceExpert
//
//  Created by xpc on 16/11/22.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSBalanceCashVc.h"
#import "ZSBalanceCashOkVc.h"
#import "GalenPayPasswordView.h"

#define ColorHUI [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1.0]

@interface ZSBalanceCashVc ()<UITextFieldDelegate, UIAlertViewDelegate>


@property(nonatomic,strong)UIView * backView;
@property(nonatomic,strong)UIView * keyBordView;
@property(nonatomic,strong)UIView * PhotoView;


@end

@implementation ZSBalanceCashVc

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
    
    self.title = @"提现页面";
    self.view.backgroundColor = ViewController_Back_Color;
    
    [self creatAnimation];
    
    //  加载视图
    [self creatCashView];

}


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


/*
 
 使用新卡支付 ： 1。 充值仅支持储蓄卡
 
 */
- (void)creatCashView {
    
    UIView *BGView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, KScreenWidth, 235)];
    BGView.backgroundColor = UIView_BackView_color;
    [self.view addSubview:BGView];
    
    
    //  银行卡Label
    UILabel *bankCard = [[UILabel alloc] init];
    bankCard.text = @"银行卡";
    bankCard.textColor = Label_Color;
    bankCard.font = [UIFont systemFontOfSize:16];
    [BGView addSubview:bankCard];
    bankCard.sd_layout.leftSpaceToView(BGView, 15)
    .topSpaceToView(BGView, 20)
    .widthIs(60)
    .heightIs(30);
    
    //  银行/卡号
    _cashCardNumb = [[UILabel alloc] init];  // WithFrame:CGRectMake(KScreenWidth * 0.33, 10, KScreenWidth * 0.5, 30)];
    _cashCardNumb.text = @"中国银行储蓄卡(8888)";
    _cashCardNumb.textColor = TextField_Text_Color;
    _cashCardNumb.adjustsFontSizeToFitWidth = YES;
    [BGView addSubview:_cashCardNumb];
    _cashCardNumb.sd_layout.leftSpaceToView(bankCard, 20)
    .topEqualToView(bankCard)
    .widthRatioToView(BGView, 0.5)
    .heightIs(30);
    
    //  按钮
//    UIButton *chooseCard = [UIButton buttonWithType:UIButtonTypeCustom];
//    [chooseCard setBackgroundImage:[UIImage imageNamed:@"wancheng"] forState:UIControlStateNormal];
//    [chooseCard setBackgroundImage:[UIImage imageNamed:@"wancheng-hov"] forState:UIControlStateHighlighted];
//    [BGView addSubview:chooseCard];
//    chooseCard.sd_layout.topSpaceToView(BGView, 28)
//    .leftSpaceToView(_cashCardNumb, 20)
//    .heightIs(15)
//    .widthIs(15);
    
    //  银行卡 提现 手续费
    UILabel *xianZhi = [[UILabel alloc] init];
    xianZhi.text = @"提现到中国银行，手续费率0.1%";
    xianZhi.textColor = Label_Color;
    xianZhi.adjustsFontSizeToFitWidth = YES;                //  根据Label长短设置字体大小
    [BGView addSubview:xianZhi];
    xianZhi.sd_layout.leftEqualToView(_cashCardNumb)
    .topSpaceToView(_cashCardNumb, 5)
    .widthRatioToView(BGView, 0.5)
    .heightIs(30);
    
    
    UIView *upLineView = [[UIView alloc] init];
    upLineView.backgroundColor = Line_Color;
    [BGView addSubview:upLineView];
    upLineView.sd_layout.leftSpaceToView(BGView, 0)
    .topSpaceToView(xianZhi, 10)
    .rightSpaceToView(BGView, 0)
    .heightIs(1);
    
    
    //  提现金额Label
    UILabel *cashLabel = [[UILabel alloc] init];
    cashLabel.text = @"提现金额";
    cashLabel.textColor = Label_Color;
    cashLabel.font = [UIFont systemFontOfSize:16];
    [BGView addSubview:cashLabel];
    cashLabel.sd_layout.leftEqualToView(bankCard)
    .topSpaceToView(upLineView, 10)
    .widthIs(80)
    .heightIs(30);
    
#warning 更改图片3
    //  ¥
    UIImageView *imageV = [[UIImageView alloc] init];
    imageV.image = [UIImage imageNamed:@"2_2"];
    [BGView addSubview:imageV];
    imageV.sd_layout.leftEqualToView(bankCard)
    .topSpaceToView(cashLabel, 10)
    .widthIs(30)
    .heightIs(30);
    
    //  输入的提款金额 TextField
    _cashMoney = [[UITextField alloc] init];
    _cashMoney.textColor = TextField_Text_Color;
    NSString *cashMoneyStr = @"请填写金额";
    NSMutableAttributedString *placeholderCashMoney = [[NSMutableAttributedString alloc]initWithString:cashMoneyStr];
    [placeholderCashMoney addAttribute:NSForegroundColorAttributeName
                         value:Placeholder_Color
                         range:NSMakeRange(0, cashMoneyStr.length)];
    _cashMoney.attributedPlaceholder = placeholderCashMoney;
    _cashMoney.font = [UIFont systemFontOfSize:40];
    _cashMoney.delegate = self;
    _cashMoney.keyboardType = UIKeyboardTypeNumberPad;
    [BGView addSubview:_cashMoney];
    _cashMoney.sd_layout.leftSpaceToView(imageV, 0)
    .topSpaceToView(cashLabel, 0)
    .rightSpaceToView(BGView, 20)
    .heightIs(50);
    
    
    UIView *downLineView = [[UIView alloc] init];
    downLineView.backgroundColor = Line_Color;
    [BGView addSubview:downLineView];
    downLineView.sd_layout.leftSpaceToView(BGView, 15)
    .topSpaceToView(_cashMoney, 5)
    .rightSpaceToView(BGView, 15)
    .heightIs(1);
    
    
    //  当前余额   全部提现按钮
    UILabel *newMoneyLabel = [[UILabel alloc] init];
    newMoneyLabel.text = @"当前零钱余额10000.00元";
    newMoneyLabel.textColor = Label_Color;
    newMoneyLabel.adjustsFontSizeToFitWidth = YES;                //  根据Label长短设置字体大小
//    newMoneyLabel.font = [UIFont systemFontOfSize:12];
    [BGView addSubview:newMoneyLabel];
    newMoneyLabel.sd_layout.leftEqualToView(downLineView)
    .topSpaceToView(downLineView, 10)
    .widthIs(KScreenWidth * 0.4)
    .heightIs(20);
    
    
    
    //  提现 按钮
    UIButton *cashButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cashButton setTitle:@"提 现" forState:UIControlStateNormal];
    [cashButton setBackgroundImage:[UIImage imageNamed:@"wancheng"] forState:UIControlStateNormal];
    [cashButton setBackgroundImage:[UIImage imageNamed:@"wancheng-hov"] forState:UIControlStateHighlighted];
    [cashButton addTarget:self action:@selector(cashButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cashButton];
    cashButton.sd_layout.leftSpaceToView(self.view, 15)
    .topSpaceToView(BGView, 50)
    .rightSpaceToView(self.view, 15)
    .heightIs(40);
}

- (void)cashButtonClick {
    
    [_cashMoney resignFirstResponder];
    
    if ([_cashMoney.text isEqual: @""]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请填写金额" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alert show];
    }else if(_cashMoney.text != (NSString *)@""){
        
        [self cashPayPasswordView];
    }
}



#pragma mark - 键盘响应  //
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_cashMoney resignFirstResponder];
    
}

#define mark - 支付密码输入框
- (void)cashPayPasswordView {
    
    GalenPayPasswordView *payPassword=[GalenPayPasswordView tradeView];
    [payPassword showInView:self.view.window];
    
    __block typeof(GalenPayPasswordView *) blockPay=payPassword;
    [payPassword setFinish:^(NSString * pwd) {
        
        [blockPay showProgressView:@"正在处理..."];
        
        [blockPay performSelector:@selector(showSuccess:) withObject:self afterDelay:3.0];
        
#warning 这里页面跳转，代码位置要变动！
        ZSBalanceCashOkVc *cashOk = [[ZSBalanceCashOkVc alloc] init];
        [self.navigationController pushViewController:cashOk animated:YES];
        
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

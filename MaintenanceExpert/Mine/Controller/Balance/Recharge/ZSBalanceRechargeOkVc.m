//
//  ZSBalanceRechargeOkVc.m
//  MaintenanceExpert
//
//  Created by xpc on 16/11/24.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSBalanceRechargeOkVc.h"

@interface ZSBalanceRechargeOkVc ()

@end

@implementation ZSBalanceRechargeOkVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = ViewController_Back_Color;
    
    [self creatAnimation];
    
    [self creatRechargeOkView];
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

- (void)creatRechargeOkView {
    
    //  top 65  H.W 75
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(KScreenWidth / 2 - KScreenWidth/8, KScreenHeight * 0.1, KScreenWidth/4, KScreenWidth/4)];
    imageV.backgroundColor = [UIColor cyanColor];
    imageV.layer.cornerRadius = imageV.frame.size.width / 2;
    imageV.layer.masksToBounds = YES;
    [self.view addSubview:imageV];
    
    //  充值成功Label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth / 2 - 50, KScreenHeight * 0.25, 100, 30)];
    label.text = @"充值成功";
    label.textColor = Label_Color;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:label];
    
    
    UIView *topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, KScreenHeight * 0.35, KScreenWidth, 1)];
    topLineView.backgroundColor = Line_Color;
    [self.view addSubview:topLineView];
    
    
    //  银行卡Label
    UILabel *bankCard = [[UILabel alloc] initWithFrame:CGRectMake(15, KScreenHeight * 0.37, 70, 25)];
    bankCard.text = @"银行卡";
    bankCard.textAlignment = NSTextAlignmentLeft;
    bankCard.textColor = Label_Color;
    [self.view addSubview:bankCard];
    
        //  银行卡 卡号
    self.okCardNumber = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth / 2, KScreenHeight * 0.37, KScreenWidth / 2 - 15, 25)];
    self.okCardNumber.text = @"中国银行 尾号8888";
    self.okCardNumber.textColor = TextField_Text_Color;
    self.okCardNumber.font = [UIFont systemFontOfSize:15];
    self.okCardNumber.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:self.okCardNumber];
    
    
    //  金 额Label
    UILabel *money = [[UILabel alloc] initWithFrame:CGRectMake(15, KScreenHeight * 0.42, 70, 25)];
    money.text = @"金 额";
    money.textAlignment = NSTextAlignmentLeft;
    money.textColor = Label_Color;
    [self.view addSubview:money];
    
        //  多少钱
    UILabel *montyLabel = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth / 2, KScreenHeight * 0.42, KScreenWidth / 2 - 15, 25)];
    montyLabel.text = @"¥10000.00";
    montyLabel.textColor = TextField_Text_Color;
    montyLabel.font = [UIFont systemFontOfSize:15];
    montyLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:montyLabel];
    
    UIView *downLineView = [[UIView alloc] initWithFrame:CGRectMake(0, KScreenHeight * 0.48, KScreenWidth, 1)];
    downLineView.backgroundColor = Line_Color;
    [self.view addSubview:downLineView];
    
    
    
    //  完成 按钮
    UIButton *okButton = [[UIButton alloc] initWithFrame:CGRectMake(20, KScreenHeight * 0.54, KScreenWidth - 40, 40)];
    [okButton setBackgroundImage:[UIImage imageNamed:@"wancheng"] forState:UIControlStateNormal];
    [okButton setBackgroundImage:[UIImage imageNamed:@"wancheng-hov"] forState:UIControlStateHighlighted];
    [okButton setTitle:@"完 成" forState:UIControlStateNormal];
    [okButton addTarget:self action:@selector(okButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:okButton];
    
}


- (void)okButtonClick {
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
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

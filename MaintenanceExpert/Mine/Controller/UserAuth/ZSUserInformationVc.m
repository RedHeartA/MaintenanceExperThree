//
//  ZSUserInformationVc.m
//  MaintenanceExpert
//
//  Created by xpc on 16/11/29.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSUserInformationVc.h"
#import "ZSUserAuthViewController.h"
#import "MineInfModel.h"

@interface ZSUserInformationVc ()

{
    MineInfModel *_Model;
    UILabel *userAuthName;
    UIImageView *yiYanZheng;
    UILabel *userID;
    UIView *secendView;
}

@end

@implementation ZSUserInformationVc

- (void)viewWillAppear:(BOOL)animated {
    
    [self loadDate];
    
    if (![userAuthName.text isEqual: @"未认证"]) {
        
        secendView.hidden = YES;
        yiYanZheng.hidden = NO;
    }else {
        
        secendView.hidden = NO;
        yiYanZheng.hidden = YES;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = ViewController_Back_Color;
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = ViewController_Back_Color;
    view.frame = CGRectMake(0, -64, KScreenWidth, 64);
    [self.view addSubview:view];
    
    self.title = @"身份校验";
    
    [self creatAnimation];
    
    [self creatView];
//    [self loadDate];
    
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

- (void)loadDate {
    
    //  取值
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSData *data = [user objectForKey:@"USER"];
    MineInfModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    _Model = model;
    
    self.headerImgV.image = _Model.usericon;
    userAuthName.text = _Model.userAuthName;
}


- (void)creatView {
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, KScreenWidth, KScreenWidth/6 + 30)];
    backView.backgroundColor = UIView_BackView_color;
    [self.view addSubview:backView];
    
    _headerImgV = [[UIImageView alloc] init];
    _headerImgV.layer.cornerRadius = KScreenWidth/12;
    _headerImgV.layer.masksToBounds = YES;
    [backView addSubview:_headerImgV];
    _headerImgV.sd_layout.leftSpaceToView(backView, 15)
    .topSpaceToView(backView, 15)
    .widthIs(KScreenWidth/6)
    .heightIs(KScreenWidth/6);
    
    userAuthName = [[UILabel alloc] init];
    userAuthName.text = @"model传值";
    userAuthName.textColor = TextField_Text_Color;
    userAuthName.font = [UIFont systemFontOfSize:18];
    [backView addSubview:userAuthName];
    userAuthName.sd_layout.leftSpaceToView(_headerImgV, 10)
    .topEqualToView(_headerImgV)
    .widthIs(60)
    .heightRatioToView(_headerImgV, 0.6);
    
    yiYanZheng = [[UIImageView alloc] init];
    yiYanZheng.image = [UIImage imageNamed:@"user_Authed"];
    yiYanZheng.layer.cornerRadius = 5;
    [backView addSubview:yiYanZheng];
    yiYanZheng.sd_layout.leftSpaceToView(userAuthName, 5)
    .topSpaceToView(backView, _headerImgV.height * 0.1 + 16)
    .widthIs(25)
    .heightIs(25);
    
    
    userID = [[UILabel alloc] init];
    userID.text = @"1****************1";
    userID.textColor = Label_Color;
    CGSize userIDSize = [userID.text sizeWithFont:userID.font constrainedToSize:CGSizeMake(MAXFLOAT, userID.frame.size.height)];
    userID.font = [UIFont systemFontOfSize:13];
    [backView addSubview:userID];
    userID.sd_layout.leftEqualToView(userAuthName)
    .topSpaceToView(userAuthName, 0)
    .widthIs(userIDSize.width)
    .heightRatioToView(_headerImgV, 0.4);
    
    
    secendView = [[UIView alloc] initWithFrame:CGRectMake(0, backView.height + 12, KScreenWidth, 50)];
    secendView.backgroundColor = UIView_BackView_color;
    [self.view addSubview:secendView];
    
    UILabel *lab1 = [[UILabel alloc] init];
//    lab1.backgroundColor = [UIColor cyanColor];
    lab1.text = @"请前往进行实名认证，获得更多权限以及订单操作";
    lab1.textColor = Label_Color;
    lab1.numberOfLines = 2;
    CGSize lab1Size = [lab1.text sizeWithFont:lab1.font constrainedToSize:CGSizeMake(MAXFLOAT, lab1.frame.size.height)];
    lab1.font = [UIFont systemFontOfSize:14];
    [secendView addSubview:lab1];
    lab1.sd_layout.leftSpaceToView(secendView, 15)
    .topSpaceToView(secendView, secendView.height * 0.1)
    .widthIs(KScreenWidth - 100)
    .heightRatioToView(secendView, 0.8);
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.backgroundColor = ViewController_Back_Color;
    button1.layer.cornerRadius = 3;
    [button1 setTitle:@"前往认证" forState:UIControlStateNormal];
    [button1.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [button1 setTitleColor:TextField_Text_Color forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(renzhengButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [secendView addSubview:button1];
    button1.sd_layout.leftSpaceToView(lab1, 5)
    .topSpaceToView(secendView, secendView.height * 0.25)
    .widthIs(65)
    .heightRatioToView(lab1, 0.6);
}


- (void)renzhengButtonClick {
    
    ZSUserAuthViewController *userAuth = [[ZSUserAuthViewController alloc] init];
    [self.navigationController pushViewController:userAuth animated:YES];
    
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

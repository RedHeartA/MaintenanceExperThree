//
//  ZSLoginViewController.m
//  MaintenanceExpert
//
//  Created by koka on 16/10/20.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSLoginViewController.h"
#import "ZSNavigationController.h"
#import "ZSRegisterViewController.h"
#import "ZSChangePasswordVC.h"
#import "MineInfModel.h"

#import "ZSHomeViewController.h"
#import "ZSNavigationController.h"
#import "ZSTabBarController.h"

#import "UIView+ZSExtension.h"
#import "UIbutton.h"

#import <SMS_SDK/SMSSDK.h>
#import <ShareSDK/ShareSDK.h>


#define KScreenWidth [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ZSLoginViewController ()
{
    BOOL _yanzhengmalog;
    
    UIView *logoBackView;   //  最外圈背景图
    
    UIImageView *passwordImgV;  //  密码输入框
    
    UIButton *LoginButton;  //  loginButton
}

@property (strong, nonatomic) CCActivityHUD *activityHUD;

@property (nonatomic, readonly) NeedDrawView *pathBuilderView;

@end


@implementation ZSLoginViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _loginbtn = [[UIButton alloc]init];
    _otherBtn = [[UIButton alloc]init];
    _phone = [[UITextField alloc]init];
    _secret = [[UITextField alloc]init];
    
    self.activityHUD = [CCActivityHUD new];
    self.activityHUD.isTheOnlyActiveView = NO;  //唯一的活动视图
    self.activityHUD.appearAnimationType = CCActivityHUDAppearAnimationTypeZoomIn; //变大-出现
    self.activityHUD.disappearAnimationType = CCActivityHUDDisappearAnimationTypeZoomOut; //缩小-消失
    self.activityHUD.overlayType = CCActivityHUDOverlayTypeShadow;  //    阴影
    
    //背景图片
    UIImageView *loginBackImg = [[UIImageView alloc]initWithFrame:self.view.frame];
    loginBackImg.contentMode = UIViewContentModeScaleAspectFill;
    loginBackImg.image = [UIImage imageNamed:@"Login_back_img"];
    loginBackImg.userInteractionEnabled = YES;
    [self.view addSubview:loginBackImg];

    [self createUI];
}


- (void)createUI {
   
    [self createLogo];
    
    [self createTextfield];
    
    [self createLoginButton];
    
//    [self createOtherlogin];  //  第三方登录
    
    [self createRegisterAndForgetsecret];
    
}

//  Logo 动画
- (void)createLogo {
    
    //  最外圈 背景图
    logoBackView = [[UIView alloc] initWithFrame:CGRectMake(KScreenWidth/4, 50, KScreenWidth/2, KScreenWidth/2)];
    [self.view addSubview:logoBackView];
    //  最外圈 图片--转动
    UIImageView *logoBackImg = [[UIImageView alloc] initWithFrame:CGRectMake(KScreenWidth/4, 50, KScreenWidth/2, KScreenWidth/2)];
    logoBackImg.image = [UIImage imageNamed:@"Login_Logo_outside"];
    [self.view addSubview:logoBackImg];
    
    //  内圈 背景图
    UIView *headerImageV = [[UIView alloc] init];
    [logoBackView addSubview:headerImageV];
    headerImageV.sd_layout.spaceToSuperView(UIEdgeInsetsMake(30, 30, 30, 30));

    //  内圈 图片--转动
    UIImageView *headerRing = [[UIImageView alloc] init];
    headerRing.image = [UIImage imageNamed:@"header_ring_icon"];
    headerRing.userInteractionEnabled = YES;
    [self.view addSubview:headerRing];
    headerRing.sd_layout.topSpaceToView(self.view, 80)
    .leftSpaceToView(self.view, KScreenWidth/2 -KScreenWidth/6)
    .widthIs(KScreenWidth/3)
    .heightIs(KScreenWidth/3);
    
    //  最内 图片--头像
    UIImageView *icon = [[UIImageView alloc] init];
    icon.image = [UIImage imageNamed:@"Login_Logo_Inside"];
    icon.height = icon.width = KScreenWidth/5;
    icon.layer.cornerRadius = icon.width * 0.5;
    icon.layer.masksToBounds = YES;
    icon.contentMode = UIViewContentModeScaleAspectFill;
    icon.userInteractionEnabled = YES;
    [headerImageV addSubview:icon];
    icon.sd_layout.spaceToSuperView(UIEdgeInsetsMake(22, 22, 22, 22));

    //  外圈
    CABasicAnimation *basicAnimation1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    basicAnimation1.fromValue = @(2*M_PI);
    basicAnimation1.toValue = @0;
    basicAnimation1.duration = 15;
    basicAnimation1.repeatCount = 100;
    basicAnimation1.removedOnCompletion = NO;
    basicAnimation1.fillMode = kCAFillModeBoth;
    [logoBackImg.layer addAnimation:basicAnimation1 forKey:@"rotation"];
    
    //  内圈
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    basicAnimation.fromValue = @0;
    basicAnimation.toValue = @(2*M_PI);
    basicAnimation.duration = 15;
    basicAnimation.repeatCount = 100;
    basicAnimation.removedOnCompletion = NO;
    basicAnimation.fillMode = kCAFillModeBoth;
    [headerRing.layer addAnimation:basicAnimation forKey:@"rotation"];
}

/**
 *  手机号和密码 文本框
 */
- (void)createTextfield {
    
    UIImageView *phoneImgV = [[UIImageView alloc] init];
    phoneImgV.image = [UIImage imageNamed:@"Login_btn_select"];
    phoneImgV.userInteractionEnabled = YES;
    phoneImgV.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:phoneImgV];
    phoneImgV.sd_layout.topSpaceToView(logoBackView, 20)
    .leftSpaceToView(self.view, 30)
    .rightSpaceToView(self.view, 30)
    .heightIs(40);
    
    UIImageView *phoneIcon = [[UIImageView alloc] init];
    phoneIcon.image = [UIImage imageNamed:@"Login_account"];
    phoneIcon.contentMode = UIViewContentModeScaleAspectFill;
    [phoneImgV addSubview:phoneIcon];
    phoneIcon.sd_layout.topSpaceToView(phoneImgV, 6)
    .leftSpaceToView(phoneImgV, 15)
    .widthIs(15)
    .heightIs(20);
    
    UITextField *phonetextfield = [[UITextField alloc]init];
    phonetextfield.textColor = TextField_Text_Color;
    NSString *placeholderPhone = @"请输入账号";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:placeholderPhone];
    
    [placeholder addAttribute:NSForegroundColorAttributeName
                         value:Placeholder_Color
                         range:NSMakeRange(0, placeholderPhone.length)];
    [placeholder addAttribute:NSFontAttributeName
                       value:[UIFont systemFontOfSize:16]
                       range:NSMakeRange(0, placeholderPhone.length)];
    phonetextfield.attributedPlaceholder = placeholder;
    
    phonetextfield.clearButtonMode = UITextFieldViewModeAlways;
    phonetextfield.keyboardType = UIKeyboardTypePhonePad;
    [phoneImgV addSubview:phonetextfield];
    phonetextfield.sd_layout.topSpaceToView(phoneImgV, 3)
    .leftSpaceToView(phoneIcon, 10)
    .widthIs(KScreenWidth -105)
    .heightIs(30);
    
    //  传值
    _phone = phonetextfield;
    
    //      密码框
    passwordImgV = [[UIImageView alloc] init];
    passwordImgV.image = [UIImage imageNamed:@"Login_btn_select"];
    passwordImgV.userInteractionEnabled = YES;
    passwordImgV.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:passwordImgV];
    passwordImgV.sd_layout.topSpaceToView(phoneImgV, 20)
    .leftSpaceToView(self.view, 30)
    .rightSpaceToView(self.view, 30)
    .heightIs(40);
    
    UIImageView *passwordIcon = [[UIImageView alloc] init];
    passwordIcon.image = [UIImage imageNamed:@"Login_lock"];
    passwordIcon.contentMode = UIViewContentModeScaleAspectFill;
    [passwordImgV addSubview:passwordIcon];
    passwordIcon.sd_layout.topSpaceToView(passwordImgV, 6)
    .leftSpaceToView(passwordImgV, 15)
    .widthIs(15)
    .heightIs(20);
    
    UITextField *secrettextfield = [[UITextField alloc]init];
    secrettextfield.textColor = TextField_Text_Color;
    NSString *placeholderPassword = @"请输入密码";
    NSMutableAttributedString *placeholder2 = [[NSMutableAttributedString alloc]initWithString:placeholderPassword];
    
    [placeholder2 addAttribute:NSForegroundColorAttributeName
                        value:Placeholder_Color
                        range:NSMakeRange(0, placeholderPassword.length)];
    [placeholder2 addAttribute:NSFontAttributeName
                        value:[UIFont systemFontOfSize:16]
                        range:NSMakeRange(0, placeholderPassword.length)];
    secrettextfield.attributedPlaceholder = placeholder2;
    
    secrettextfield.secureTextEntry = YES;  //  密码隐藏
    secrettextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    [passwordImgV addSubview:secrettextfield];
    secrettextfield.sd_layout.topSpaceToView(passwordImgV, 3)
    .leftSpaceToView(passwordIcon, 10)
    .widthIs(KScreenWidth -105)
    .heightIs(30);

    _secret = secrettextfield;
    
    //      验证码
    _messageTF = [[UITextField alloc]init];
    _messageTF.textColor = TextField_Text_Color;
    NSString *messageStr = @"请输入验证码";
    NSMutableAttributedString *placeholder3 = [[NSMutableAttributedString alloc]initWithString:messageStr];
    
    [placeholder3 addAttribute:NSForegroundColorAttributeName
                         value:Placeholder_Color
                         range:NSMakeRange(0, messageStr.length)];
    [placeholder3 addAttribute:NSFontAttributeName
                         value:[UIFont systemFontOfSize:16]
                         range:NSMakeRange(0, messageStr.length)];
    _messageTF.attributedPlaceholder = placeholder3;

    _messageTF.keyboardType = UIKeyboardTypeNumberPad;
    _messageTF.clearButtonMode = UITextFieldViewModeAlways;
    [passwordImgV addSubview:_messageTF];
    _messageTF.sd_layout.topSpaceToView(passwordImgV, 3)
    .leftSpaceToView(passwordIcon, 10)
    .widthIs(KScreenWidth -160)
    .heightIs(30);
    
    
    
    /**
     验证码按钮
     */
    
    _messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_messageBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_messageBtn.titleLabel setFont:[UIFont systemFontOfSize:14 weight:2]];
    [_messageBtn setBackgroundImage:[UIImage imageNamed:@"sendMessage"] forState:UIControlStateNormal];
    [_messageBtn addTarget:self action:@selector(startTime) forControlEvents:UIControlEventTouchDown];
    [passwordImgV addSubview:_messageBtn];
    _messageBtn.sd_layout.topSpaceToView(passwordImgV, 5)
    .rightSpaceToView(passwordImgV, 20)
    .widthIs(80)
    .heightIs(20);
    
    _messageTF.hidden = YES;
    _messageBtn.hidden = YES;
    _secret.hidden = NO;
    
    _yanzhengmalog = YES;
    
}

/**
 *  登录按钮
 */
- (void)createLoginButton {
    
    
    LoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [LoginButton setBackgroundImage:[UIImage imageNamed:@"Login_btn_nomal"] forState:UIControlStateNormal];
    [LoginButton setBackgroundImage:[UIImage imageNamed:@"Login_btn_select"] forState:UIControlStateHighlighted];
    [LoginButton setTitle:@"登        录" forState:UIControlStateNormal];
    [LoginButton setTitleColor:ColorWithRGBA(136, 228, 241, 1) forState:UIControlStateNormal];
    LoginButton.contentMode = UIViewContentModeScaleAspectFill;
    [LoginButton.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [LoginButton addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:LoginButton];
    LoginButton.sd_layout.topSpaceToView(passwordImgV, 30)
    .leftSpaceToView(self.view, 30)
    .rightSpaceToView(self.view, 30)
    .heightIs(50);
    
    _loginbtn = LoginButton;
    
}

//  登录按钮 点击事件
- (void)loginBtnClick {
    
    
    [_phone resignFirstResponder];
    [_secret resignFirstResponder];
    
    /**
     *  测试账号⬇️
     */
    if ([self.phone.text isEqualToString:@""] || [self.secret.text isEqualToString:@""]) {
        
        [self.activityHUD showWithText:@"账号密码不可为空" shimmering:YES];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.activityHUD dismissWithText:@"如果没有账号请前往注册" delay:0.7 success:NO];
        });
        
    }else{
    
    if ([self.secret.text isEqualToString:@"1"] && [self.phone.text isEqualToString:@"1"]) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:self.phone.text forKey:@"username"];
        
        MineInfModel *model = [[MineInfModel alloc]init];
        model.username = @"大白";
        model.usericon = [UIImage imageNamed:@"defult_header_icon"];
        model.moneynum = @"1000";
        
        model.userAuthName = @"未认证";
        model.Mymoney = @"1000000";
        model.userkind = @"engineer";
        model.leftlabelnum = @"6";
        model.rightlabelnum = @"8.9";
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
        NSUserDefaults *users = [NSUserDefaults standardUserDefaults];
        [users setObject:data forKey:@"USER"];

        ZSTabBarController *tab = [[ZSTabBarController alloc]init];
        
        ZSNavigationController *nav = [[ZSNavigationController alloc]initWithRootViewController:tab];
        self.view.window.rootViewController = nav;
    }else {
        
        /**
         *  测试账号⤴️
         */
  
        NSDictionary *dict =@{
                              @"password":self.secret.text,
                              @"mobile":self.phone.text,
                            };
        AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
        manage.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [manage POST:@LoginURL parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            [_loginbtn setTitle:@"正在登录" forState:UIControlStateNormal];
            _loginbtn.userInteractionEnabled = NO;
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
            NSLog(@"%@",dic);
            NSLog(@"%@",[dic objectForKey:@"code"]);
            [_loginbtn setTitle:@"登    录" forState:UIControlStateNormal];
            _loginbtn.userInteractionEnabled = YES;
            NSInteger str = [[dic objectForKey:@"code"] integerValue];
            if (str == 200) {
                
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:self.phone.text forKey:@"username"];
                
                MineInfModel *model = [[MineInfModel alloc]init];
                model.username = [[dic objectForKey:@"data"] objectForKey:@"contact"];
                model.usericon = [UIImage imageNamed:@"defult_header_icon"];
                model.moneynum = @"1000";
                model.userAuthName = @"未认证";
                model.Mymoney = @"1000000";
                model.leftlabelnum = @"6";
                model.rightlabelnum = @"8";
                model.userkind = @"personal";
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
                NSUserDefaults *users = [NSUserDefaults standardUserDefaults];
                [users setObject:data forKey:@"USER"];
                
                ZSHomeViewController *home = [[ZSHomeViewController alloc]init];
                ZSTabBarController *tab = [[ZSTabBarController alloc]init];
                
                ZSNavigationController *nav = [[ZSNavigationController alloc]initWithRootViewController:tab];
                self.view.window.rootViewController = nav;
    #warning 这边添加选择种类跳转分为第三方登录 还是账号密码登录--
                /**
                 验证成功后进入注册界面
                 
                 */
                //[self commitverifyCode];
                
                [self.navigationController pushViewController:home animated:YES];
            }else {
                
                [self.activityHUD showWithText:@"登录失败" shimmering:YES];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self.activityHUD dismissWithText:@"账号密码输入错误" delay:0.7];
                });
            }
          
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSString *errorStr = [NSString stringWithFormat:@"%@",error];
            NSLog(@"error:%@",errorStr);
            
            [self.activityHUD showWithText:@"登录失败" shimmering:YES];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self.activityHUD dismissWithText:@"请检查数据连接" delay:0.7];
            });
            
            [_loginbtn setTitle:@"登录" forState:UIControlStateNormal];
            _loginbtn.userInteractionEnabled = YES;
        }];

        }
    }
}

#pragma - mark 提交验证码
- (void)commitverifyCode {
    [SMSSDK commitVerificationCode:_messageTF.text phoneNumber:_phone.text zone:@"86" result:^(SMSSDKUserInfo *userInfo, NSError *error) {
        if (!error) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"成功" message:@"验证码验证成功"  delegate:self cancelButtonTitle:@"确定"  otherButtonTitles:nil, nil];
            [alert show];
            
        }else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"codesenderrtitle", nil) message:[NSString stringWithFormat:@"错误描述：%@",error.debugDescription]  delegate:self cancelButtonTitle:@"确定"  otherButtonTitles:nil, nil];
            NSLog(@"%@",error.debugDescription);
            [alert show];
        }
    }];
}


/**
 *  其他登录方式
 *
 */
- (void)createOtherlogin {
    
    /**
     其他登录方式
     */
    UILabel *otherlogin = [[UILabel alloc]initWithFrame:CGRectMake(0, _loginbtn.frame.origin.y + _loginbtn.size.height + 80, KScreenWidth , 10)];
    otherlogin.textAlignment = NSTextAlignmentCenter;
    otherlogin.text = @"其他登录方式";
    otherlogin.textColor = [UIColor colorWithRed:70.0 / 255.0 green:70.0 / 255.0 blue:70.0 / 255.0 alpha:1];
    otherlogin.font = [UIFont systemFontOfSize:14];
    
    //UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(_loginbtn.frame.origin.x, otherlogin.frame.origin.y + 5, _loginbtn.frame.size.width, 1)];
    UIView *lineView = [[UIView alloc]init];
    lineView.sd_layout.widthIs(_loginbtn.frame.size.width).xIs(_loginbtn.frame.origin.x).yIs(otherlogin.frame.origin.y - 5).heightIs(1);
    lineView.backgroundColor = [UIColor colorWithRed:150.0 / 255.0 green:170.0 / 255.0 blue:180.0 / 255.0 alpha:1];
    [self.view addSubview:lineView];
    
    [self.view addSubview:otherlogin];
    
    
    /**
     *  第三方登录
     
     每种登录的button的tag值来区分
     *
     */
    UIbutton *btn = [[UIbutton alloc]init];
    
    UIButton *QQ = [btn addButtonWithImage:@"share_platform_qqfriends" highImage:nil disableImage:nil frame:CGRectMake(_loginbtn.frame.origin.x, otherlogin.frame.origin.y + 25, _loginbtn.frame.size.width / 6, _loginbtn.frame.size.width / 6) tag:0 action:@selector(clickQQ)];
    QQ.layer.cornerRadius = 10;
    
    _otherBtn = QQ;
    [self.view addSubview:QQ];
    
    UIButton *weixin = [btn addButtonWithImage:@"share_platform_wechat" highImage:nil disableImage:nil frame:CGRectMake(_loginbtn.frame.origin.x + (_loginbtn.frame.size.width * 5) / 18, otherlogin.frame.origin.y + 25, _loginbtn.frame.size.width / 6, _loginbtn.frame.size.width / 6) tag:1 action:@selector(clickweixin)];
    weixin.layer.cornerRadius = 10;
    
    [self.view addSubview:weixin];
    
    UIButton *weibo = [btn addButtonWithImage:@"share_platform_sina" highImage:nil disableImage:nil frame:CGRectMake(_loginbtn.frame.origin.x + (_loginbtn.frame.size.width * 5) / 9, otherlogin.frame.origin.y + 25, _loginbtn.frame.size.width / 6, _loginbtn.frame.size.width / 6) tag:2 action:@selector(clickweibo)];
    weibo.layer.cornerRadius = 10;
    
    [self.view addSubview:weibo];
    
    UIButton *yanzhengma = [btn addButtonWithImage:@"post_office_icon" highImage:nil disableImage:nil frame:CGRectMake(_loginbtn.frame.origin.x + (_loginbtn.frame.size.width * 5) / 6, otherlogin.frame.origin.y + 25, _loginbtn.frame.size.width / 6, _loginbtn.frame.size.width / 6) tag:3 action:@selector(clickyanzhengma)];
    yanzhengma.layer.cornerRadius = 10;
    
    [self.view addSubview:yanzhengma];
    
    
}

/**
 *  四种第三方登录
 */
- (void)clickQQ {
    [ShareSDK getUserInfo:SSDKPlatformTypeQQ
              onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
                  if (state == SSDKResponseStateSuccess)
                  {
                      NSLog(@"uid=%@",user.uid);
                      NSLog(@"%@",user.credential);
                      NSLog(@"token=%@",user.credential.token);
                      NSLog(@"nickname=%@",user.nickname);
                  }
                  
                  else
                  {
                      NSLog(@"%@",error);
                  }

              }];
}

- (void)clickweixin {
    
    NSLog(@"weixin");
}

- (void)clickweibo {
    
    NSLog(@"weibo");
}

/**
 *  验证码登录
 */
- (void)clickyanzhengma {
    
    if (_yanzhengmalog == YES) {
        _messageTF.hidden = NO;
        _messageBtn.hidden = NO;
        _secret.hidden = YES;
        _yanzhengmalog = NO;
    }else{
        _messageTF.hidden = YES;
        _messageBtn.hidden = YES;
        _secret.hidden = NO;
        _yanzhengmalog = YES;
    }
    
    
}
/**
 *  验证码的计时器
 */
- (void)startTime {
    
    /**
     *  申请验证码
     */
    [self getRegisterCode];
    
    __block int timeout= 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout<=0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示
                
                [_messageBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                _messageBtn.userInteractionEnabled = YES;
                
            });
            
        }else{
            
            //            int minutes = timeout / 60;
            
            int seconds = timeout % 60;
            
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示
                
                [UIView beginAnimations:nil context:nil];
                
                [UIView setAnimationDuration:1];
                
                [_messageBtn setTitle:[NSString stringWithFormat:@"%@秒后重发",strTime] forState:UIControlStateNormal];
                
                [UIView commitAnimations];
                
                _messageBtn.userInteractionEnabled = NO;
                
            });
            
            timeout--;
            
            
            
        }
        
    });
    
    dispatch_resume(_timer);
    
}

#pragma - mark 申请验证码

- (void)getRegisterCode {
    
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_phone.text zone:@"86" customIdentifier:@"yanzhengma" result:^(NSError *error) {
        
        if (!error) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"成功" message:[NSString stringWithFormat:@"已向%@的发送验证码",_phone.text]  delegate:self cancelButtonTitle:@"确定"  otherButtonTitles:nil, nil];
            [alert show];
        }else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"codesenderrtitle", nil) message:[NSString stringWithFormat:@"错误描述：%@",error.debugDescription]  delegate:self cancelButtonTitle:@"确定"  otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
}

/**
 *  注册按钮
 */
- (void)createRegisterAndForgetsecret {
    
    
    //  注册账号
    UIButton *registerBtn = [[UIButton alloc]init];
    [registerBtn setTitle:@"注册账号" forState:UIControlStateNormal];
    [registerBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [registerBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    [registerBtn setTitleColor:ColorWithRGBA(89, 207, 226, 1) forState:UIControlStateNormal];
    registerBtn.sd_layout.topSpaceToView(LoginButton, 10)
    .leftSpaceToView(self.view, 30)
    .widthIs(60)
    .heightIs(15);
    
    //  忘记密码
    UIButton *forgetSecret = [[UIButton alloc]init];
    [forgetSecret setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetSecret.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [forgetSecret addTarget:self action:@selector(forgetSecretBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetSecret];
    [forgetSecret setTitleColor:ColorWithRGBA(89, 207, 226, 1) forState:UIControlStateNormal];
    forgetSecret.sd_layout.topSpaceToView(LoginButton, 10)
    .rightSpaceToView(self.view, 30)
    .widthIs(60)
    .heightIs(15);
    
}

/**
 *  跳转注册和忘记密码界面
 */
- (void)registerBtnClick {
    
    /**
     rootviewcontroller改回登录界面
     */
    ZSNavigationController *nav = [[ZSNavigationController alloc]initWithRootViewController:self];
    self.view.window.rootViewController = nav;
    
    ZSRegisterViewController *registerVC= [[ZSRegisterViewController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];

}

- (void)forgetSecretBtnClick {
    //NSLog(@"跳转改密");
    ZSNavigationController *nav = [[ZSNavigationController alloc] initWithRootViewController:self];
    self.view.window.rootViewController = nav;
    
    ZSChangePasswordVC *changeVc = [[ZSChangePasswordVC alloc] init];
    [self.navigationController pushViewController:changeVc animated:YES];    //[self presentViewController:changeVC animated:YES completion:nil];
}

/**
 *  键盘响应
 *
 */
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_phone resignFirstResponder];
    [_secret resignFirstResponder];
    [_messageTF resignFirstResponder];
    
}


@end

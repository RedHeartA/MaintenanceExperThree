//
//  ZSRegisterViewController.m
//  MaintenanceExpert
//
//  Created by xpc on 16/10/20.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSRegisterViewController.h"
#import "ZSRegisterCustomerVC.h"
#import "ZHBtnSelectView.h"
#import "ZHCustomBtn.h"
#import "ZSDetailRegisterModel.h"
#import "ZSRegisterBusinessVc.h"
#import "ZSRegisterHardwareVc.h"

#import <SMS_SDK/SMSSDK.h>

//typedef enum{
//    ZHProgressModeText = 0,           //文字
//    ZHProgressModeLoading,              //加载菊花
//    ZHProgressModeGIF,            //加载动画
//    ZHProgressModeSuccess               //成功
//    
//}ZHProgressMode;

@interface ZSRegisterViewController ()<ZHBtnSelectViewDelegate,UITextFieldDelegate>{
    
    BOOL _yanzhengmaRight;
    BOOL _messageBtnSelected;
    UIButton *_messageBtn;
    UIButton *doneBtn;  //  注册按钮
    
}

@property (strong, nonatomic) CCActivityHUD *activityHUD;
@property (nonatomic,weak) ZHCustomBtn *currentkindBtn;
@property (nonatomic,weak) ZHBtnSelectView *btnkindView;

@property (nonatomic,assign)NSInteger registerkind;

@property (nonatomic,strong)NSArray *kindArr;

@end


@implementation ZSRegisterViewController


////  提示 弹出框显示位置
//- (instancetype)shareinstance{
//    
//    static ZSRegisterViewController *instance = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        instance = [[ZSRegisterViewController alloc] init];
//    });
//    
//    return instance;
//    
//}

- (void)viewWillDisappear:(BOOL)animated {
    
    if (self.activityHUD) {
        
        [self.activityHUD dismissNoSecondView];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ViewController_Back_Color;
    self.title = @"注册帐号";
    self.navigationController.navigationBarHidden = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;

    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navgation"] forBarMetrics:UIBarMetricsDefault];
    
    [self creatView];
    
    _messageBtnSelected = NO;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBG:)];
    [self.view addGestureRecognizer:tapGesture];
    self.registerkind = 109;
    
    
    self.activityHUD = [[CCActivityHUD alloc] init];
    self.activityHUD.backgroundColor = [UIColor blackColor];
    self.activityHUD.isTheOnlyActiveView = NO;  //唯一的活动视图(有问题，根据情况判断  YES?NO )
    self.activityHUD.appearAnimationType = CCActivityHUDAppearAnimationTypeZoomIn; //变大-出现
    self.activityHUD.disappearAnimationType = CCActivityHUDDisappearAnimationTypeZoomOut; //缩小-消失
    self.activityHUD.overlayType = CCActivityHUDOverlayTypeShadow;  //    阴影
    
}
- (void)tapBG:(UITapGestureRecognizer *)gesture {
    
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}


- (void)creatView {

    [self createkindbtn];
    [self createTextView];
    
}


//  客户还是工程师
- (void)createkindbtn {
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(60, 10, 90, 40)];
//    label.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:label];
    
    label.text = @"账户类型:";
    label.textColor = ColorWithRGBA(44, 162, 228, 1);
    
    self.kindArr = [[NSArray alloc]initWithObjects:@"客户",@"工程师",@"工程商",@"硬件商", nil];
    // 自动计算view的高度
    ZHBtnSelectView *btnView = [[ZHBtnSelectView alloc] initWithFrame:CGRectMake(KScreenWidth/2 -15, label.frame.origin.y + 3, 150, 0) titles:self.kindArr column:2];
    [self.view addSubview:btnView];
    btnView.verticalMargin = 10;
    btnView.delegate = self;
    self.btnkindView = btnView;
}

- (void)btnSelectView:(ZHBtnSelectView *)btnSelectView selectedBtn:(ZHCustomBtn *)btn {
    self.btnkindView.selectType = BtnSelectTypeSingleChoose;
    self.currentkindBtn.btnSelected = NO;
    self.currentkindBtn = btn;
    btn.btnSelected = YES;
    if ([self.currentkindBtn.titleLabel.text isEqualToString:@"客户"]) {
        [ZSDetailRegisterModel shareRegist].RegisterIndex = 110;
    }else if ([self.currentkindBtn.titleLabel.text isEqualToString:@"工程师"]){
        [ZSDetailRegisterModel shareRegist].RegisterIndex = 111;
        [ZSDetailRegisterModel shareRegist].type = @"engineer";
    }else if ([self.currentkindBtn.titleLabel.text isEqualToString:@"工程商"]){
        [ZSDetailRegisterModel shareRegist].RegisterIndex = 112;
        [ZSDetailRegisterModel shareRegist].type = @"agent";
    }else if ([self.currentkindBtn.titleLabel.text isEqualToString:@"硬件商"]){
        [ZSDetailRegisterModel shareRegist].RegisterIndex = 113;
        [ZSDetailRegisterModel shareRegist].type = @"factory";
    }else{
        [ZSDetailRegisterModel shareRegist].RegisterIndex = 114;
    }
    self.registerkind = [ZSDetailRegisterModel shareRegist].RegisterIndex;
}

- (void)createTextView {
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 90, KScreenWidth, KScreenHeight -154)];
//    backView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:backView];
    
    
    UIView *firstLineView = [[UIView alloc] init];
    [backView addSubview:firstLineView];
    firstLineView.backgroundColor = Line_Color;
    firstLineView.sd_layout.topSpaceToView(backView, 0)
    .leftSpaceToView(backView, 10)
    .rightSpaceToView(backView, 10)
    .heightIs(1);
    
    /**
     手机号码输入框
     */
    UIImageView *phoneImg = [[UIImageView alloc] init];
    phoneImg.image = [UIImage imageNamed:@"phone_Num"];
    [backView addSubview:phoneImg];
    phoneImg.sd_layout.topSpaceToView(backView, TOP_LABEL_HEIGHT +2)
    .leftSpaceToView(backView, 20)
    .widthIs(20)
    .heightIs(25);
    
    
    _registerPhoneNumTF = [[UITextField alloc] init];
    //    _phoneNumTF.backgroundColor = [UIColor cyanColor];
    _registerPhoneNumTF.textColor = TextField_Text_Color;
    NSString *phoneNumStr = @"请输入手机号";
    _registerPhoneNumTF.delegate = self;
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:phoneNumStr];
    [placeholder addAttribute:NSForegroundColorAttributeName
                        value:Placeholder_Color
                        range:NSMakeRange(0, phoneNumStr.length)];
    _registerPhoneNumTF.attributedPlaceholder = placeholder;
    [backView addSubview:_registerPhoneNumTF];
    //_registerPhoneNumTF.keyboardType = UIKeyboardTypeNumberPad;
    _registerPhoneNumTF.clearButtonMode = UITextFieldViewModeAlways;
    _registerPhoneNumTF.returnKeyType = UIReturnKeyDone;
    _registerPhoneNumTF.sd_layout.topSpaceToView(backView, TOP_LABEL_HEIGHT)
    .leftSpaceToView(backView, TEXTF_X)
    .widthIs(TEXTF_WIDTH)
    .heightIs(30);
    
    UIView *phoneLineView = [[UIView alloc] init];
    [backView addSubview:phoneLineView];
    phoneLineView.backgroundColor = Line_Color;
    phoneLineView.sd_layout.topSpaceToView(_registerPhoneNumTF, TOP_LABEL_HEIGHT)
    .leftSpaceToView(backView, 10)
    .rightSpaceToView(backView, 10)
    .heightIs(1);
    
    /**
     验证码输入框
     */
    UIImageView *messageImg = [[UIImageView alloc] init];
    messageImg.image = [UIImage imageNamed:@"message"];
    [backView addSubview:messageImg];
    messageImg.sd_layout.topSpaceToView(phoneLineView, TOP_LABEL_HEIGHT +2)
    .leftSpaceToView(backView, 20)
    .widthIs(20)
    .heightIs(25);
    
    _registerMessageTF = [[UITextField alloc] init];
    //    _messageTF.backgroundColor = [UIColor cyanColor];
    _registerMessageTF.textColor = TextField_Text_Color;
    NSString *messageStr = @"请输入验证码";
    
    NSMutableAttributedString *placeholder2 = [[NSMutableAttributedString alloc]initWithString:messageStr];
    _registerMessageTF.returnKeyType = UIReturnKeyDone;
    [placeholder2 addAttribute:NSForegroundColorAttributeName
                        value:Placeholder_Color
                        range:NSMakeRange(0, messageStr.length)];
    _registerMessageTF.attributedPlaceholder = placeholder2;
    [backView addSubview:_registerMessageTF];
    _registerMessageTF.keyboardType = UIKeyboardTypeNumberPad;
    _registerMessageTF.clearButtonMode = UITextFieldViewModeAlways;
    _registerMessageTF.sd_layout.topSpaceToView(phoneLineView, TOP_LABEL_HEIGHT)
    .leftSpaceToView(backView, TEXTF_X)
    .widthIs(TEXTF_WIDTH)
    .heightIs(30);
    
    //  验证码按钮
    _messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_messageBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_messageBtn.titleLabel setFont:[UIFont systemFontOfSize:14 weight:2]];
    [_messageBtn setBackgroundImage:[UIImage imageNamed:@"sendMessage"] forState:UIControlStateNormal];
    [_messageBtn addTarget:self action:@selector(RegisterstartTime) forControlEvents:UIControlEventTouchDown];
    [backView addSubview:_messageBtn];
    _messageBtn.sd_layout.topSpaceToView(phoneLineView, TOP_LABEL_HEIGHT -6)
    .rightSpaceToView(backView, 20)
    .widthIs(80)
    .heightIs(40);
    
    UIView *messageLineView = [[UIView alloc] init];
    [backView addSubview:messageLineView];
    messageLineView.backgroundColor = Line_Color;
    messageLineView.sd_layout.topSpaceToView(_registerMessageTF, TOP_LABEL_HEIGHT)
    .leftSpaceToView(backView, 10)
    .rightSpaceToView(backView, 10)
    .heightIs(1);
    
    /**
     新密码
     */
    UIImageView *passwordImg = [[UIImageView alloc] init];
    passwordImg.image = [UIImage imageNamed:@"password"];
    [backView addSubview:passwordImg];
    passwordImg.sd_layout.topSpaceToView(messageLineView, TOP_LABEL_HEIGHT +2)
    .leftSpaceToView(backView, 20)
    .widthIs(20)
    .heightIs(25);
    
    _registerPasswordTF = [[UITextField alloc] init];
    //    _newpasswordTF.backgroundColor = [UIColor cyanColor];
    _registerPasswordTF.textColor = TextField_Text_Color;
    
    NSString *newpasswordStr = @"请输入密码";
    _registerPasswordTF.delegate = self;
    _registerPasswordTF.returnKeyType = UIReturnKeyDone;
    NSMutableAttributedString *placeholder3 = [[NSMutableAttributedString alloc]initWithString:newpasswordStr];
    [placeholder3 addAttribute:NSForegroundColorAttributeName
                         value:Placeholder_Color
                         range:NSMakeRange(0, newpasswordStr.length)];
    _registerPasswordTF.attributedPlaceholder = placeholder3;
    [backView addSubview:_registerPasswordTF];
    _registerPasswordTF.clearButtonMode = UITextFieldViewModeAlways;
    _registerPasswordTF.secureTextEntry = YES;
    _registerPasswordTF.sd_layout.topSpaceToView(messageLineView, TOP_LABEL_HEIGHT)
    .leftSpaceToView(backView, TEXTF_X)
    .widthIs(TEXTF_WIDTH)
    .heightIs(30);
    
    UIView *passwordLineView = [[UIView alloc] init];
    [backView addSubview:passwordLineView];
    passwordLineView.backgroundColor = Line_Color;
    passwordLineView.sd_layout.topSpaceToView(_registerPasswordTF, TOP_LABEL_HEIGHT)
    .leftSpaceToView(backView, 10)
    .rightSpaceToView(backView, 10)
    .heightIs(1);
    
    /**
     确认密码
     */
    UIImageView *passwordTwoImg = [[UIImageView alloc] init];
    passwordTwoImg.image = [UIImage imageNamed:@"secondPassword"];
    [backView addSubview:passwordTwoImg];
    passwordTwoImg.sd_layout.topSpaceToView(passwordLineView, TOP_LABEL_HEIGHT +2)
    .leftSpaceToView(backView, 20)
    .widthIs(20)
    .heightIs(25);
    
    _registerPasswordTwoTF = [[UITextField alloc] init];
    _registerPasswordTwoTF.clearButtonMode = UITextFieldViewModeAlways;
    _registerPasswordTwoTF.secureTextEntry = YES;
    _registerPasswordTwoTF.textColor = TextField_Text_Color;
    NSString *newpasswordTwoStr = @"请确认密码";
    _registerPasswordTwoTF.delegate = self;
    _registerPasswordTwoTF.returnKeyType = UIReturnKeyDone;
    NSMutableAttributedString *placeholder4 = [[NSMutableAttributedString alloc]initWithString:newpasswordTwoStr];
    [placeholder4 addAttribute:NSForegroundColorAttributeName
                         value:Placeholder_Color
                         range:NSMakeRange(0, newpasswordTwoStr.length)];
    _registerPasswordTwoTF.attributedPlaceholder = placeholder4;
    [backView addSubview:_registerPasswordTwoTF];
    _registerPasswordTwoTF.sd_layout.topSpaceToView(passwordLineView, TOP_LABEL_HEIGHT)
    .leftSpaceToView(backView, TEXTF_X)
    .widthIs(TEXTF_WIDTH)
    .heightIs(30);
    
    UIView *passwordTwoLineView = [[UIView alloc] init];
    [backView addSubview:passwordTwoLineView];
    passwordTwoLineView.backgroundColor = Line_Color;
    passwordTwoLineView.sd_layout.topSpaceToView(_registerPasswordTwoTF, TOP_LABEL_HEIGHT)
    .leftSpaceToView(backView, 10)
    .rightSpaceToView(backView, 10)
    .heightIs(1);
    
    /**
     *  确认按钮
     */
    doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneBtn setBackgroundImage:[UIImage imageNamed:@"wancheng"] forState:UIControlStateNormal];
    [doneBtn setBackgroundImage:[UIImage imageNamed:@"wancheng-hov"] forState:UIControlStateSelected];
    [doneBtn setTitle:@"注    册" forState:UIControlStateNormal];
    doneBtn.userInteractionEnabled = YES;
    [doneBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [doneBtn addTarget:self action:@selector(tabButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:doneBtn];
    doneBtn.sd_layout.topSpaceToView(passwordTwoLineView, 30)
    .leftSpaceToView(backView, 5)
    .rightSpaceToView(backView, 5)
    .heightIs(40);
}


//  获取 验证码
//  点击 获取验证码后 倒计时、并按钮变灰
- (void)RegisterstartTime {
    
    BOOL phoneNumRight = [[Regex class] isMobile:_registerPhoneNumTF.text];
    
    
    /**
     *  验证码获取
     */
    if (phoneNumRight == NO) {
        
        [self.activityHUD showWithText:@"手机号输入错误" shimmering:YES];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.activityHUD dismissNoSecondView];
        });
        
    } else {
        
        [self getRegisterCode];
        
        __block int timeout= 59; //倒计时时间
        
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
        dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        
        dispatch_source_set_event_handler(_timer, ^{
            
            if(timeout<=0){ //倒计时结束，关闭
                
                dispatch_source_cancel(_timer);
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    //设置界面的按钮显示 根据自己需求设置
                    
                    [_messageBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                    
                    _messageBtn.userInteractionEnabled = YES;
                });
                
            }else{
                
                //            int minutes = timeout / 60;
                int seconds = timeout % 60;
                
                NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    //设置界面的按钮显示 根据自己需求设置
                    
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
}

#pragma - mark 申请验证码
- (void)getRegisterCode {
    
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS
                            phoneNumber:_registerPhoneNumTF.text
                            zone:@"86"
                            customIdentifier:@"yanzhengma"
                            result:^(NSError *error) {
        
        if (!error) {
            
            _messageBtnSelected = YES;
            NSLog(@"成功");
        }else {
            
            [self.activityHUD showWithText:@"验证码发送失败" shimmering:YES];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self.activityHUD dismissWithText:@"请重新获取" delay:1 success:NO];
            });
            NSLog(@"失败");
        }
    }];
}


//  注 册 按 钮 方法
//  One

//  非空判定
- (void)tabButtonTapped{
    
    [ZSDetailRegisterModel shareRegist].mobile = _registerPhoneNumTF.text;
    [ZSDetailRegisterModel shareRegist].password = _registerPasswordTwoTF.text;

    BOOL phoneright = [[Regex class] isMobile:_registerPhoneNumTF.text];
    
    NSLog(@"BOOL111:%d",_yanzhengmaRight);
    
    if (phoneright == 0) {

        [self.activityHUD showWithText:@"请输入正确的手机号" shimmering:YES];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.activityHUD dismissNoSecondView];
        });
        
    }else if (_registerMessageTF.text.length == 0) {
        
        [self.activityHUD showWithText:@"请输入验证码" shimmering:YES];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.activityHUD dismissNoSecondView];
        });
    }else if (_registerPasswordTF.text.length == 0) {
        
        [self.activityHUD showWithText:@"请输入密码" shimmering:YES];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.activityHUD dismissNoSecondView];
        });
    }else if (_registerPasswordTwoTF.text.length == 0) {
        
        [self.activityHUD showWithText:@"请再次输入密码" shimmering:YES];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.activityHUD dismissNoSecondView];
        });
    }
    else {
        
        if (self.registerkind == 109) {
            
            [self.activityHUD showWithText:@"请选择注册类型" shimmering:YES];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self.activityHUD dismissNoSecondView];
            });
        
        }else {
            
            [doneBtn setTitle:@"验证中。。。" forState:UIControlStateNormal];
            doneBtn.userInteractionEnabled = NO;
            
            //  提交验证码
            [self commitverifyCode];
        }
    }
}

#warning 验证码时效？？？？获取的验证码10Minute 内有效？
#pragma - mark 提交验证码
- (void)commitverifyCode {
    [SMSSDK commitVerificationCode:_registerMessageTF.text
                       phoneNumber:_registerPhoneNumTF.text
                              zone:@"86"
                            result:^(SMSSDKUserInfo *userInfo, NSError *error) {
                                if (!error) {
                                    /**
                                     验证成功后进入注册界面
                                     */
                                    _yanzhengmaRight = YES;
                                    
                                    NSLog(@"BOOL222:%d",_yanzhengmaRight);
                                    
                                    if (_registerPasswordTF.text.length < 6 || _registerPasswordTwoTF.text.length < 6) {
                                        
                                        [self.activityHUD showWithText:@"请输入6位以上密码" shimmering:YES];
                                        
                                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

                                            [self.activityHUD dismissNoSecondView];
                                            
                                            [doneBtn setTitle:@"注    册" forState:UIControlStateNormal];
                                            doneBtn.userInteractionEnabled = YES;
                                        });
                                        
                                    }
#warning if-phoneNum->password(wrong)->messageNum---->BUG!!!
                                    
                                    else if (![_registerPasswordTwoTF.text isEqualToString:_registerPasswordTF.text]) {
                                            
                                            [self.activityHUD showWithText:@"两次密码输入不相同" shimmering:YES];
                                            
                                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                
                                                [self.activityHUD dismissNoSecondView];
                                                
                                                [doneBtn setTitle:@"注    册" forState:UIControlStateNormal];
                                                doneBtn.userInteractionEnabled = YES;
                                            });
                                        }
                                    else {
                                            
                                            [doneBtn setTitle:@"验证中。。。" forState:UIControlStateNormal];
                                            doneBtn.userInteractionEnabled = NO;
                                            
                                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                
                                                if (self.registerkind == 110 || self.registerkind == 111) {
                                                    
                                                    ZSRegisterCustomerVC* custormerVC = [[ZSRegisterCustomerVC alloc] init];
                                                    [self.navigationController pushViewController:custormerVC animated:YES];
                                                    
                                                }else if (self.registerkind == 112) {
                                                    
                                                    ZSRegisterBusinessVc *businessVc = [[ZSRegisterBusinessVc alloc] init];
                                                    [self.navigationController pushViewController:businessVc animated:YES];
                                                    
                                                }else if (self.registerkind == 113) {
                                                    
                                                    ZSRegisterHardwareVc *hardwareVc = [[ZSRegisterHardwareVc alloc] init];
                                                    [self.navigationController pushViewController:hardwareVc animated:YES];
                                                }
                                                
                                                if (![_registerPhoneNumTF.text isEqualToString:@""] ||
                                                    ![_registerMessageTF.text isEqualToString:@""] ||
                                                    ![_registerPasswordTF.text isEqualToString:@""] ||
                                                    ![_registerPasswordTwoTF.text isEqualToString:@""])
                                                {
                                                    _registerPhoneNumTF.text = @"";
                                                    _registerMessageTF.text = @"";
                                                    _registerPasswordTF.text = @"";
                                                    _registerPasswordTwoTF.text = @"";
                                                }
                                            });
                                        }
                                        
                                        [doneBtn setTitle:@"注    册" forState:UIControlStateNormal];
                                        doneBtn.userInteractionEnabled = YES;
                                    
                                }else {
                                    
                                    
                                    NSLog(@"error:%@",error);

                                    
                                    //  验证码输入是否正确？
                                    _yanzhengmaRight = NO;
                                    
                                    
                                    NSLog(@"BOOL333:%d",_yanzhengmaRight);
                                    if (_yanzhengmaRight == NO) {
                                        
                                        [self.activityHUD showWithText:@"验证码输入错误" shimmering:YES];
                                        
                                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                            
                                            [self.activityHUD dismissNoSecondView];
                                            
                                            [doneBtn setTitle:@"注    册" forState:UIControlStateNormal];
                                            doneBtn.userInteractionEnabled = YES;
                                        });
                                    }else if (_messageBtnSelected == NO) {
                                        
                                        [self.activityHUD showWithText:@"请获取验证码" shimmering:YES];
                                        
                                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                            
                                            [self.activityHUD dismissNoSecondView];
                                            
                                            [doneBtn setTitle:@"注    册" forState:UIControlStateNormal];
                                            doneBtn.userInteractionEnabled = YES;
                                        });
                                    }
                                }
                            }];
}

//#pragma mark - 提示弹出框--自动消失[self showMessage: inView:]
//- (void)show:(NSString *)msg inView:(UIView *)view mode:(ZHProgressMode *)myMode{
//    
//    [self shareinstance].regHud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    [self shareinstance].regHud.color = [UIColor blackColor];
//    [[self shareinstance].regHud setMargin:10];
//    [self shareinstance].regHud.mode = MBProgressHUDModeText;
//    [[self shareinstance].regHud setRemoveFromSuperViewOnHide:YES];
//    [self shareinstance].regHud.detailsLabel.text = msg;
//    [self shareinstance].regHud.contentColor = [UIColor whiteColor];
//    [self shareinstance].regHud.detailsLabel.font = [UIFont systemFontOfSize:14];
//}
////  提示框消失
//- (void)hide {
//    if ([self shareinstance].regHud != nil) {
//        [[self shareinstance].regHud hideAnimated:YES];
//    }
//}
////  提示框显示
//- (void)showMessage:(NSString *)msg inView:(UIView *)view {
//    [self show:msg inView:view mode:ZHProgressModeText];
//    [[self shareinstance].regHud hideAnimated:YES afterDelay:1];
//    //用于关闭当前提示
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self hide];
//        
//    });
//}

/**
 *  键盘响应
 *
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

//- (void)textFieldDidEndEditing:( UITextField *)textField {
//    
//    
//    UILabel *label = [[UILabel alloc] init];
//    label.hidden = NO;
//    if (![_registerPasswordTwoTF.text isEqualToString:_registerPasswordTF.text]) {
//
//        label.text = @"X";
//        label.textColor = TextField_Text_Color;
//        [self.view addSubview:label];
//        label.sd_layout.topEqualToView(_registerPasswordTwoTF)
//        .leftSpaceToView(_registerPasswordTwoTF, 10)
//        .widthIs(20)
//        .heightIs(20);
//        
////        [self.activityHUD showWithText:@"两次密码输入不相同" shimmering:YES];
////        
////        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////            
////            [self.activityHUD dismissNoSecondView];
////            
////            [doneBtn setTitle:@"注    册" forState:UIControlStateNormal];
////            doneBtn.userInteractionEnabled = YES;
////        });
//    }else {
//        label.hidden = YES;
//    }
//}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_registerMessageTF resignFirstResponder];
    [_registerPhoneNumTF resignFirstResponder];
    [_registerPasswordTF resignFirstResponder];
    [_registerPasswordTwoTF resignFirstResponder];
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

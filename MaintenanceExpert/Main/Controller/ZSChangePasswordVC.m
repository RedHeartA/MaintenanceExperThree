//
//  ZSChangePasswordVC.m
//  MaintenanceExpert
//
//  Created by koka on 16/10/21.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSChangePasswordVC.h"

@interface ZSChangePasswordVC ()

@property (strong, nonatomic) CCActivityHUD *activityHUD;

@end


@implementation ZSChangePasswordVC


- (void)viewWillDisappear:(BOOL)animated {
    
    if (self.activityHUD) {
        
        [self.activityHUD dismissNoSecondView];
    }
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = ViewController_Back_Color;
    self.navigationController.navigationBarHidden = NO;
    self.title = @"修改密码";
    
    [self createView];
    
    
    self.activityHUD = [[CCActivityHUD alloc] init];
    self.activityHUD.backgroundColor = [UIColor blackColor];
    self.activityHUD.isTheOnlyActiveView = NO;  //唯一的活动视图(有问题，根据情况判断  YES?NO )
    self.activityHUD.appearAnimationType = CCActivityHUDAppearAnimationTypeZoomIn; //变大-出现
    self.activityHUD.disappearAnimationType = CCActivityHUDDisappearAnimationTypeZoomOut; //缩小-消失
    self.activityHUD.overlayType = CCActivityHUDOverlayTypeShadow;  //    阴影
    
}

/**
 *  搭建UI
 */
- (void)createView {
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, KScreenWidth, KScreenHeight)];
    backView.backgroundColor = ColorWithRGBA(18, 33, 62, 1);
    [self.view addSubview:backView];
    
    
    /**
     手机号码输入框
     */
    UIImageView *phoneImg = [[UIImageView alloc] init];
    phoneImg.image = [UIImage imageNamed:@"phone_Num"];
    [backView addSubview:phoneImg];
    phoneImg.sd_layout.topSpaceToView(backView, TOP_LABEL_HEIGHT +2)
    .leftSpaceToView(backView, 20)
    .widthIs(16)
    .heightIs(25);

    
    _changePhoneNumTF = [[UITextField alloc] init];
    _changePhoneNumTF.textColor = TextField_Text_Color;
    NSString *phoneNumStr = @"请输入手机号";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:phoneNumStr];
    [placeholder addAttribute:NSForegroundColorAttributeName
                        value:Placeholder_Color
                        range:NSMakeRange(0, phoneNumStr.length)];
    _changePhoneNumTF.attributedPlaceholder = placeholder;
    _changePhoneNumTF.keyboardType = UIKeyboardTypeNumberPad;
    [backView addSubview:_changePhoneNumTF];
    _changePhoneNumTF.sd_layout.topSpaceToView(backView, TOP_LABEL_HEIGHT)
    .leftSpaceToView(backView, TEXTF_X)
    .widthIs(TEXTF_WIDTH)
    .heightIs(30);
    
    UIView *phoneLineView = [[UIView alloc] init];
    [backView addSubview:phoneLineView];
    phoneLineView.backgroundColor = Line_Color;
    phoneLineView.sd_layout.topSpaceToView(_changePhoneNumTF, TOP_LABEL_HEIGHT)
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
    
    _changeMessageTF = [[UITextField alloc] init];
//    _messageTF.backgroundColor = [UIColor cyanColor];
    _changeMessageTF.textColor = TextField_Text_Color;
    NSString *messageStr = @"请输入验证码";
    NSMutableAttributedString *placeholder2 = [[NSMutableAttributedString alloc]initWithString:messageStr];
    [placeholder2 addAttribute:NSForegroundColorAttributeName
                        value:Placeholder_Color
                        range:NSMakeRange(0, messageStr.length)];
    _changeMessageTF.attributedPlaceholder = placeholder2;
    [backView addSubview:_changeMessageTF];
    _changeMessageTF.sd_layout.topSpaceToView(phoneLineView, TOP_LABEL_HEIGHT)
    .leftSpaceToView(backView, TEXTF_X)
    .widthIs(120)
    .heightIs(30);
#warning 获取验证码
    //  验证码按钮
    _messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_messageBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_messageBtn.titleLabel setFont:[UIFont systemFontOfSize:14 weight:2]];
    [_messageBtn setBackgroundImage:[UIImage imageNamed:@"sendMessage"] forState:UIControlStateNormal];
    [_messageBtn addTarget:self action:@selector(startTime) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:_messageBtn];
    _messageBtn.sd_layout.topSpaceToView(phoneLineView, TOP_LABEL_HEIGHT -6)
    .rightSpaceToView(backView, 20)
    .widthIs(80)
    .heightIs(40);
    
    UIView *messageLineView = [[UIView alloc] init];
    [backView addSubview:messageLineView];
    messageLineView.backgroundColor = Line_Color;
    messageLineView.sd_layout.topSpaceToView(_changeMessageTF, TOP_LABEL_HEIGHT)
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
    
    _changeNewpasswordTF = [[UITextField alloc] init];
//    _newpasswordTF.backgroundColor = [UIColor cyanColor];
    _changeNewpasswordTF.textColor = TextField_Text_Color;
    NSString *newpasswordStr = @"请输入新密码";
    NSMutableAttributedString *placeholder3 = [[NSMutableAttributedString alloc]initWithString:newpasswordStr];
    [placeholder3 addAttribute:NSForegroundColorAttributeName
                         value:Placeholder_Color
                         range:NSMakeRange(0, newpasswordStr.length)];
    _changeNewpasswordTF.attributedPlaceholder = placeholder3;
    [backView addSubview:_changeNewpasswordTF];
    _changeNewpasswordTF.sd_layout.topSpaceToView(messageLineView, TOP_LABEL_HEIGHT)
    .leftSpaceToView(backView, TEXTF_X)
    .widthIs(TEXTF_WIDTH)
    .heightIs(30);
    
    UIView *passwordLineView = [[UIView alloc] init];
    [backView addSubview:passwordLineView];
    passwordLineView.backgroundColor = Line_Color;
    passwordLineView.sd_layout.topSpaceToView(_changeNewpasswordTF, TOP_LABEL_HEIGHT)
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
    
    _changeNewpasswordTwoTF = [[UITextField alloc] init];
//    _phoneNumTF.backgroundColor = [UIColor cyanColor];
    _changeNewpasswordTwoTF.textColor = TextField_Text_Color;
    NSString *newpasswordTwoStr = @"请确认密码";
    NSMutableAttributedString *placeholder4 = [[NSMutableAttributedString alloc]initWithString:newpasswordTwoStr];
    [placeholder4 addAttribute:NSForegroundColorAttributeName
                         value:Placeholder_Color
                         range:NSMakeRange(0, newpasswordTwoStr.length)];
    _changeNewpasswordTwoTF.attributedPlaceholder = placeholder4;
    [backView addSubview:_changeNewpasswordTwoTF];
    _changeNewpasswordTwoTF.sd_layout.topSpaceToView(passwordLineView, TOP_LABEL_HEIGHT)
    .leftSpaceToView(backView, TEXTF_X)
    .widthIs(TEXTF_WIDTH)
    .heightIs(30);
    
    UIView *passwordTwoLineView = [[UIView alloc] init];
    [backView addSubview:passwordTwoLineView];
    passwordTwoLineView.backgroundColor = Line_Color;
    passwordTwoLineView.sd_layout.topSpaceToView(_changeNewpasswordTwoTF, TOP_LABEL_HEIGHT)
    .leftSpaceToView(backView, 10)
    .rightSpaceToView(backView, 10)
    .heightIs(1);
    
    
    /**
     *  确认按钮
     */
    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneBtn setBackgroundImage:[UIImage imageNamed:@"wancheng"] forState:UIControlStateNormal];
    [doneBtn setBackgroundImage:[UIImage imageNamed:@"wancheng-hov"] forState:UIControlStateHighlighted];
    [doneBtn setTitle:@"确定修改" forState:UIControlStateNormal];
    [doneBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [doneBtn addTarget:self action:@selector(changePasswordBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:doneBtn];
    doneBtn.sd_layout.topSpaceToView(passwordTwoLineView, 30)
    .leftSpaceToView(backView, 5)
    .rightSpaceToView(backView, 5)
    .heightIs(40);
    
    
}

/**
 *  修改完毕，跳转登录页面
 */
- (void)changePasswordBtnClick:(UIButton *)button {
    
    if (_changePhoneNumTF.text.length == 0) {
        [self.activityHUD showWithText:@"请输入手机号" shimmering:YES];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.activityHUD dismissNoSecondView];
        });
    } else if (_changeMessageTF.text.length == 0){
        [self.activityHUD showWithText:@"请输入验证码" shimmering:YES];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.activityHUD dismissNoSecondView];
        });
    } else if (_changeNewpasswordTF.text.length == 0){
        [self.activityHUD showWithText:@"请输入密码" shimmering:YES];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.activityHUD dismissNoSecondView];
        });
    } else if (_changeNewpasswordTwoTF.text.length == 0){
        [self.activityHUD showWithText:@"请再次输入密码" shimmering:YES];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.activityHUD dismissNoSecondView];
        });
    } else if (![_changeNewpasswordTwoTF.text isEqualToString:_changeNewpasswordTF.text]) {
        [self.activityHUD showWithText:@"再次输入密码不一致" shimmering:YES];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.activityHUD dismissNoSecondView];
        });
    } else {
        
        self.activityHUD.backgroundColor = [UIColor clearColor];
        
        [self.activityHUD showWithGIFName:@"baymax2.gif"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.activityHUD dismissNoSecondView];
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        });
    }
}



/**
 *  验证码的计时器
 */
- (void)startTime {
    
    BOOL phoneright = [[Regex class] isMobile:_changePhoneNumTF.text];
    if (phoneright == 1) {
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
        
    }else {
        
        [self.activityHUD showWithText:@"手机号输入错误" shimmering:YES];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.activityHUD dismissNoSecondView];
        });
    }
}


/**
 *  键盘响应
 *
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
}


#pragma mark - 屏幕上弹
//-(void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    //键盘高度216
//    
//    //滑动效果（动画）
//    NSTimeInterval animationDuration = 0.30f;
//    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    
//    //将视图的Y坐标向上移动，以使下面腾出地方用于软键盘的显示
//    self.view.frame = CGRectMake(0.0f, -100.0f, self.view.frame.size.width, self.view.frame.size.height);//64-216
//    
//    [UIView commitAnimations];
//}
//
//#pragma mark -屏幕恢复
//-(void)textFieldDidEndEditing:(UITextField *)textField
//{
//  
//    //滑动效果
//    NSTimeInterval animationDuration = 0.30f;
//    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    
//    //恢复屏幕
//    self.view.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);//64-216
//    
//    [UIView commitAnimations];
//}

@end

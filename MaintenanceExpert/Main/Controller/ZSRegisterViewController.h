//
//  ZSRegisterViewController.h
//  MaintenanceExpert
//
//  Created by xpc on 16/10/20.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZSRegisterViewController : UIViewController

//  弹出框
@property (nonatomic,strong) MBProgressHUD  *regHud;

@property(nonatomic,strong)UITextView*  textViewType;
@property(nonatomic,strong)UIButton*    nextStepBtn;

@property(nonatomic,strong)UITextField *registerPhoneNumTF;
@property(nonatomic,strong)UITextField *registerMessageTF;
@property(nonatomic,strong)UITextField *registerPasswordTF;
@property(nonatomic,strong)UITextField *registerPasswordTwoTF;

@end

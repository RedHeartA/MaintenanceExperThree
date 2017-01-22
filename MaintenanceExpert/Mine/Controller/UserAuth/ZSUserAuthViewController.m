//
//  ZSUserAuthViewController.m
//  MaintenanceExpert
//
//  Created by xpc on 16/11/29.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSUserAuthViewController.h"
#import "Cardcommit.h"
#import "MineInfModel.h"

typedef enum{
    ZHProgressModeText = 0,           //文字
    ZHProgressModeLoading,              //加载菊花
    ZHProgressModeGIF,            //加载动画
    ZHProgressModeSuccess               //成功
    
}ZHProgressMode;

@interface ZSUserAuthViewController ()<UITextFieldDelegate, UIAlertViewDelegate>

{
    MineInfModel *_Model;
    UIView *backView;
    UITextField *nameTF;
    UITextField *IDCardNumb;
}

@end

@implementation ZSUserAuthViewController

- (void)viewWillAppear:(BOOL)animated {
    
    //  取值
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSData *data = [user objectForKey:@"USER"];
    MineInfModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    _Model = model;
}


//  提示 弹出框
- (instancetype)shareinstance{
    
    static ZSUserAuthViewController *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ZSUserAuthViewController alloc] init];
    });
    
    return instance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ViewController_Back_Color;

    [self creatAnimation];
    
    [self creatView];
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

- (void)creatView {
    
    backView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, KScreenWidth, 100)];
    backView.backgroundColor = UIView_BackView_color;
    [self.view addSubview:backView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 60, 30)];
    label.text = @"姓名";
    label.textColor = Label_Color;
    [backView addSubview:label];
    
    nameTF = [[UITextField alloc] initWithFrame:CGRectMake(75, 12, 200, 30)];
    nameTF.textColor = TextField_Text_Color;
    NSString *nameStr = @"请输入姓名";
    NSMutableAttributedString *placeholderName = [[NSMutableAttributedString alloc]initWithString:nameStr];
    [placeholderName addAttribute:NSForegroundColorAttributeName
                         value:Placeholder_Color
                         range:NSMakeRange(0, nameStr.length)];
    nameTF.attributedPlaceholder = placeholderName;
    [backView addSubview:nameTF];
    
    
    //  line
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(75, 45, KScreenWidth - 85, 1)];
    lineView.backgroundColor = Line_Color;
    [backView addSubview:lineView];
    
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(15, 55,  60, 30)];
    label2.text = @"身份证";
    label2.textColor = Label_Color;
    [backView addSubview:label2];
    
    IDCardNumb = [[UITextField alloc] initWithFrame:CGRectMake(75, 56, 200, 30)];
    IDCardNumb.textColor = TextField_Text_Color;
    NSString *IDCardNumbStr = @"请输入身份证号";
    NSMutableAttributedString *placeholderIdCard = [[NSMutableAttributedString alloc]initWithString:IDCardNumbStr];
    [placeholderIdCard addAttribute:NSForegroundColorAttributeName
                            value:Placeholder_Color
                            range:NSMakeRange(0, IDCardNumbStr.length)];
    IDCardNumb.attributedPlaceholder = placeholderIdCard;
    IDCardNumb.keyboardType = UIKeyboardTypeNumberPad;
    [backView addSubview:IDCardNumb];
    
    UIButton *OkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    OkBtn.frame = CGRectMake(10, 140, KScreenWidth - 20, 40);
    [OkBtn setBackgroundImage:[UIImage imageNamed:@"wancheng"] forState:UIControlStateNormal];
    [OkBtn setBackgroundImage:[UIImage imageNamed:@"wancheng-hov"] forState:UIControlStateHighlighted];
    [OkBtn setTitle:@"提 交" forState:UIControlStateNormal];
    [OkBtn setTitleColor:TextField_Text_Color forState:UIControlStateNormal];
    [OkBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [OkBtn addTarget:self action:@selector(okButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:OkBtn];
}

#warning keyboard 键盘消失问题
- (void)okButtonClick {
    
    //  判断格式是否正确
    BOOL IDIsRight = [[Regex class] accurateVerifyIDCardNumber:IDCardNumb.text];
    
    if (![IDCardNumb.text isEqual: @""]) {
        
        if (IDIsRight == 1) {
            [IDCardNumb resignFirstResponder];
            
            NSString *result = [Cardcommit ReturnIDCardResultwithname:nameTF.text Andidcard:IDCardNumb.text];
            
            NSLog(@"---------------%@",result);
            
            if ([result isEqualToString:@"一致"]) {
                
                UIAlertView *aler1 = [[UIAlertView alloc]initWithTitle:@"提示" message:@"认证完成" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                aler1.tag = 100;
                
                [aler1 show];
            }else {
                
                UIAlertView *aler2 = [[UIAlertView alloc]initWithTitle:@"提示" message:@"证件不匹配,请重新输入" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                aler2.tag = 101;
                [aler2 show];
            }

        }else {
            
            UIAlertView *aler3 = [[UIAlertView alloc]initWithTitle:@"提示" message:@"身份证号错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            aler3.tag = 102;
            [aler3 show];
            
        }
    }
    
    
    //  判断是否为空
    if ([nameTF.text isEqual: @""]) {
        
        [self showMessage:@"请输入姓名" inView:backView];
    }else if ([IDCardNumb.text isEqual: @""]) {
        
        [self showMessage:@"请输入身份证号" inView:backView];
    }
    
    
    
    NSLog(@"提交，等待验证---%@,%@",nameTF.text, IDCardNumb.text);
    
}


#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag == 100) {
        _Model.userAuthName = nameTF.text;
        /**
         *  先取，改完再存
         */
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_Model];
        NSUserDefaults *users = [NSUserDefaults standardUserDefaults];
        [users setObject:data forKey:@"USER"];
        
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark - 提示弹出框--自动消失[self showMessage: inView:]
- (void)show:(NSString *)msg inView:(UIView *)view mode:(ZHProgressMode *)myMode{
    
    [self shareinstance].mbHud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    [self shareinstance].mbHud.color = [UIColor blackColor];
    [[self shareinstance].mbHud setMargin:10];
    [self shareinstance].mbHud.mode = MBProgressHUDModeText;
    [[self shareinstance].mbHud setRemoveFromSuperViewOnHide:YES];
    [self shareinstance].mbHud.detailsLabel.text = msg;
    [self shareinstance].mbHud.contentColor = [UIColor whiteColor];
    [self shareinstance].mbHud.detailsLabel.font = [UIFont systemFontOfSize:14];
}
//  提示框消失
- (void)hide {
    if ([self shareinstance].mbHud != nil) {
        [[self shareinstance].mbHud hideAnimated:YES];
    }
}
//  提示框显示
- (void)showMessage:(NSString *)msg inView:(UIView *)view {
    [self show:msg inView:view mode:ZHProgressModeText];
    [[self shareinstance].mbHud hideAnimated:YES afterDelay:1];
    //用于关闭当前提示
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hide];
        
    });
}


//  键盘响应事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [nameTF resignFirstResponder];
    [IDCardNumb resignFirstResponder];
    
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

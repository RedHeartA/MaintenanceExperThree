//
//  ZSBankCardADD.m
//  MaintenanceExpert
//
//  Created by koka on 16/12/1.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSBankCardADD.h"
#import "Cardcommit.h"
#import "BankCardModel.h"

#import "SVProgressHUD.h"

@interface ZSBankCardADD ()

{
    NSMutableDictionary *_dic;
}

@end

@implementation ZSBankCardADD


//- (void)viewWillAppear:(BOOL)animated {
//    
//    self.nameTF.text = @"";
//    self.bankcardTF.text = @"";
//    self.idcardTF.text = @"";
//    self.phoneTF.text = @"";
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = ViewController_Back_Color;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(commitClick)];
    
    [self creatAnimation];
    [self createLabelUI];
    
    
}

- (void)createLabelUI {
    NSMutableArray *arraytitle = [[NSMutableArray alloc]initWithObjects:@"姓名:",@"银行卡:",@"身份证号:",@"银行预留手机号:", nil];
    for (int i =0; i < 4; i++) {
        
        UIImageView *titleBackImgV = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20 + 90 * i, 130, 30)];
        titleBackImgV.image = [UIImage imageNamed:@"bilu--bg-"];
        [self.view addSubview:titleBackImgV];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(25, 20 + 90 * i, 130, 30)];
        label.font = [UIFont systemFontOfSize:16];
        label.text = arraytitle[i];
        label.textColor = Label_Color;
        [self.view addSubview:label];
    }
    
    self.nameTF = [[UITextField alloc]initWithFrame:CGRectMake(20, 55, KScreenWidth - 60, 40)];
    self.nameTF.textColor = TextField_Text_Color;
    NSString *nameStr = @" 请输入姓名";
    NSMutableAttributedString *placeholderName = [[NSMutableAttributedString alloc]initWithString:nameStr];
    [placeholderName addAttribute:NSForegroundColorAttributeName
                         value:Placeholder_Color
                         range:NSMakeRange(0, nameStr.length)];
    self.nameTF.attributedPlaceholder = placeholderName;
    self.nameTF.layer.borderColor = [UIColor colorWithRed:52.0/255.0 green:156.0/255.0 blue:214.0/255.0 alpha:1].CGColor;
    self.nameTF.layer.borderWidth = 1.0f;
    self.nameTF.layer.cornerRadius = 3;
    self.nameTF.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.nameTF];
    
    self.bankcardTF = [[UITextField alloc]initWithFrame:CGRectMake(20, 145, KScreenWidth - 60, 40)];
    self.bankcardTF.textColor = TextField_Text_Color;
    NSString *bankcardStr = @" 请输入正确的银行卡号";
    NSMutableAttributedString *placeholderBankcard = [[NSMutableAttributedString alloc]initWithString:bankcardStr];
    [placeholderBankcard addAttribute:NSForegroundColorAttributeName
                            value:Placeholder_Color
                            range:NSMakeRange(0, bankcardStr.length)];
    self.bankcardTF.attributedPlaceholder = placeholderBankcard;
    self.bankcardTF.layer.borderColor= [UIColor colorWithRed:52.0/255.0 green:156.0/255.0 blue:214.0/255.0 alpha:1].CGColor;
    self.bankcardTF.layer.borderWidth= 1.0f;
    self.bankcardTF.layer.cornerRadius = 3;
    self.bankcardTF.clearButtonMode = UITextFieldViewModeAlways;
    self.bankcardTF.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:self.bankcardTF];
    
    self.idcardTF = [[UITextField alloc]initWithFrame:CGRectMake(20, 235, KScreenWidth - 60, 40)];
    self.idcardTF.textColor = TextField_Text_Color;
    NSString *idcardStr = @" 请输入正确的身份证号";
    NSMutableAttributedString *placeholderIdCard = [[NSMutableAttributedString alloc]initWithString:idcardStr];
    [placeholderIdCard addAttribute:NSForegroundColorAttributeName
                         value:Placeholder_Color
                         range:NSMakeRange(0, idcardStr.length)];
    self.idcardTF.attributedPlaceholder = placeholderIdCard;
    self.idcardTF.layer.borderColor= [UIColor colorWithRed:52.0/255.0 green:156.0/255.0 blue:214.0/255.0 alpha:1].CGColor;
    self.idcardTF.layer.borderWidth= 1.0f;
    self.idcardTF.layer.cornerRadius = 3;
    self.idcardTF.clearButtonMode = UITextFieldViewModeAlways;
    self.idcardTF.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:self.idcardTF];
    
    self.phoneTF = [[UITextField alloc]initWithFrame:CGRectMake(20, 325, KScreenWidth - 60, 40)];
    self.phoneTF.textColor = TextField_Text_Color;
    NSString *phoneStr = @" 请输入银行预留手机号";
    NSMutableAttributedString *placeholderPhone = [[NSMutableAttributedString alloc]initWithString:phoneStr];
    [placeholderPhone addAttribute:NSForegroundColorAttributeName
                              value:Placeholder_Color
                              range:NSMakeRange(0, phoneStr.length)];
    self.phoneTF.attributedPlaceholder = placeholderPhone;
    self.phoneTF.layer.borderColor= [UIColor colorWithRed:52.0/255.0 green:156.0/255.0 blue:214.0/255.0 alpha:1].CGColor;
    self.phoneTF.layer.borderWidth= 1.0f;
    self.phoneTF.layer.cornerRadius = 3;
    self.phoneTF.clearButtonMode = UITextFieldViewModeAlways;
    self.phoneTF.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:self.phoneTF];
    
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

- (void)commitClick {
    
    if (self.nameTF.text.length < 2 || self.bankcardTF.text.length != 19 || self.idcardTF.text.length != 18 || self.phoneTF.text.length != 11) {
        
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD showInfoWithStatus:@"请检查输入内容的正确性\n(暂不支持信用卡)"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        
    } else {

        NSString *result = [Cardcommit ReturnBankCardResultwithname:self.nameTF.text Andidcard:self.idcardTF.text Andbankcard:self.bankcardTF.text AndbankPreMobile:self.phoneTF.text];
        NSLog(@"开始验证。。。");
        if ([result isEqualToString:@"验证成功"]) {
            
            [self commitbank];
            
//            self.nameTF.text = @"";
//            self.bankcardTF.text = @"";
//            self.idcardTF.text = @"";
//            self.phoneTF.text = @"";
            
            NSLog(@"验证成功。。。");
            NSLog(@"result：%@",result);
        }else{
            NSLog(@"验证失败。。。");
            NSLog(@"result：%@",result);
        }
    }
}

- (void)commitbank {
    
    _dic = [[NSMutableDictionary alloc]init];
    NSDictionary *dicc = [[NSDictionary alloc]init];
    dicc = [Cardcommit ReturnBankCardResultwithbankcard:self.bankcardTF.text];
    NSInteger length = self.bankcardTF.text.length;
    
    [BankCardModel shareBankCard].CardnumFour = [self.bankcardTF.text substringFromIndex:length - 4];
    [_dic setValue:[dicc objectForKey:@"bankname"] forKey:@"bankname"];
    [_dic setValue:[dicc objectForKey:@"cardtype"] forKey:@"cardtype"];
    [_dic setValue:[self.bankcardTF.text substringFromIndex:length - 4] forKey:@"cardnumfour"];
    
    [BankCardModel shareBankCard].BankCardDic = _dic;
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
    [self.nameTF resignFirstResponder];
    [self.bankcardTF resignFirstResponder];
    [self.idcardTF resignFirstResponder];
    [self.phoneTF resignFirstResponder];
}



@end

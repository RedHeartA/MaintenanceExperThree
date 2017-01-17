//
//  ZSAboutZSYWViewController.m
//  MaintenanceExpert
//
//  Created by xpc on 16/11/25.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSAboutZSYWViewController.h"
#import "ZSAboutIntroduceVc.h"
#import "ZSAboutContactUsVc.h"
#import "ZSAboutJoinUsVc.h"

@interface ZSAboutZSYWViewController ()<UITextViewDelegate>
{
    //UIWebView *_webView;
    UITextView *_textView;
    UIImageView *zsywHeaderImg;
    UIButton *aboutButton;
}

@end

@implementation ZSAboutZSYWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = ViewController_Back_Color;
    self.navigationItem.title = @"中数运维";
    
    [self creatAnimation];
    
    [self creatAboutView];
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

- (void)creatAboutView {
    
    //  Logo
    zsywHeaderImg = [[UIImageView alloc] initWithFrame:CGRectMake(KScreenWidth/2 - 60, 50, 120, 75)];
    zsywHeaderImg.image = [UIImage imageNamed:@"about_zsyw_Header"];
    zsywHeaderImg.layer.cornerRadius = zsywHeaderImg.width/2;
    [self.view addSubview:zsywHeaderImg];
    
    //  中数运维介绍
    aboutButton = [[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth/2 - 60, zsywHeaderImg.height + 120, 120, 30)];
    //  给按钮添加 下划线
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@"中数运维介绍"];
    NSRange titleRange = {0,[title length]};
    [title addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:titleRange];
    [title addAttribute:NSForegroundColorAttributeName value:Label_Color range:titleRange];
    
    [aboutButton setAttributedTitle:title forState:UIControlStateNormal];
    [aboutButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [aboutButton addTarget:self action:@selector(aboutZsywBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:aboutButton];
    
    //  联系我们
    UIButton *callUsBtn = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth/2 - 60, aboutButton.frame.origin.y + 50, 120, 30)];
    
    NSMutableAttributedString *callUsTitle = [[NSMutableAttributedString alloc] initWithString:@"联系我们"];
    NSRange callUsTitleRange = {0,[callUsTitle length]};
    [callUsTitle addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:callUsTitleRange];
    [callUsTitle addAttribute:NSForegroundColorAttributeName value:Label_Color range:callUsTitleRange];
    [callUsBtn setAttributedTitle:callUsTitle forState:UIControlStateNormal];
    [callUsBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [callUsBtn setTitleColor:Label_Color forState:UIControlStateNormal];
    [callUsBtn addTarget:self action:@selector(callUsBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:callUsBtn];
    
    //  加入我们
    UIButton *joinUsBtn = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth/2 - 60, callUsBtn.frame.origin.y + 50, 120, 30)];
    [joinUsBtn.titleLabel setTextAlignment:NSTextAlignmentLeft];
    NSMutableAttributedString *joinUsTitle = [[NSMutableAttributedString alloc] initWithString:@"加入我们"];
    NSRange joinUsTitleRange = {0,[joinUsTitle length]};
    [joinUsTitle addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:joinUsTitleRange];
    [joinUsTitle addAttribute:NSForegroundColorAttributeName value:Label_Color range:joinUsTitleRange];
    [joinUsBtn setAttributedTitle:joinUsTitle forState:UIControlStateNormal];
    [joinUsBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [joinUsBtn setTitleColor:Label_Color forState:UIControlStateNormal];
    [joinUsBtn addTarget:self action:@selector(joinUsBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:joinUsBtn];
    
}

//  介绍按钮
- (void)aboutZsywBtnClick {
    
    ZSAboutIntroduceVc *introduceVc = [[ZSAboutIntroduceVc alloc] init];
    [self.navigationController pushViewController:introduceVc animated:YES];
}

//  联系我们按钮
- (void)callUsBtnClick {
    
    ZSAboutContactUsVc *contactUsVc = [[ZSAboutContactUsVc alloc] init];
    [self.navigationController pushViewController:contactUsVc animated:YES];
}

//  加入我们
- (void)joinUsBtnClick {
    
    ZSAboutJoinUsVc *joinUsVc = [[ZSAboutJoinUsVc alloc] init];
    [self.navigationController pushViewController:joinUsVc animated:YES];
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

//
//  ZSUserGardeAuthVc.m
//  MaintenanceExpert
//
//  Created by 中数 on 16/12/29.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSUserGardeAuthVc.h"

@interface ZSUserGardeAuthVc ()

@end

@implementation ZSUserGardeAuthVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = ViewController_Back_Color;
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = ViewController_Back_Color;
    view.frame = CGRectMake(0, -64, KScreenWidth, 64);
    [self.view addSubview:view];
    
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
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth/2 - 100, KScreenHeight/2 - 100, 200, 30)];
    label.text = @"程序员正在努力中。。。";
    label.textColor = Label_Color;
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
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

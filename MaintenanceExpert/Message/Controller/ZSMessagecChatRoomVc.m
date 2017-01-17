//
//  ZSMessagecChatRoomVc.m
//  MaintenanceExpert
//
//  Created by xpc on 16/12/28.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSMessagecChatRoomVc.h"

@interface ZSMessagecChatRoomVc ()

@end

@implementation ZSMessagecChatRoomVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = ViewController_Back_Color;
    
    [self creatAnimation];
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
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth/2 - 100, KScreenHeight/2 - 100, 200, 30)];
    label.text = @"程序员正在努力中。。。";
    label.textColor = Label_Color;
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
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

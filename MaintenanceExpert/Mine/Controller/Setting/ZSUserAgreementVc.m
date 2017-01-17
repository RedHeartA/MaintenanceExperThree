//
//  ZSUserAgreementVc.m
//  MaintenanceExpert
//
//  Created by xpc on 16/11/25.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSUserAgreementVc.h"

@interface ZSUserAgreementVc ()

@end

@implementation ZSUserAgreementVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = ViewController_Back_Color;
    
    [self creatView];
}

- (void)creatView {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth/2 - 100, KScreenHeight/2 - 100, 200, 30)];
    label.text = @"敬 请 期 待";
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

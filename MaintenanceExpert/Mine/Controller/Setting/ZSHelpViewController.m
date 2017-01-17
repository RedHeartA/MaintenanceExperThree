//
//  ZSHelpViewController.m
//  MaintenanceExpert
//
//  Created by xpc on 16/11/14.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSHelpViewController.h"
#import "ZSUserFeedBackVc.h"

@interface ZSHelpViewController ()

@end

@implementation ZSHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ViewController_Back_Color;
    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,60,30)];
    [rightButton setTitle:@"意见反馈" forState:UIControlStateNormal];
    [rightButton setTitleColor:Label_Color forState:UIControlStateNormal];
    [rightButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [rightButton addTarget:self action:@selector(userFeedBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self creatView];
}

- (void)creatView {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth/2 - 100, KScreenHeight/2 - 100, 200, 30)];
    label.text = @"敬 请 期 待";
    label.textColor = Label_Color;
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
}

- (void)userFeedBtnClick {
    
    ZSUserFeedBackVc *userFeed = [[ZSUserFeedBackVc alloc] init];
    [self.navigationController pushViewController:userFeed animated:YES];
    
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

//
//  Stepsecond.m
//  MaintenanceExpert
//
//  Created by koka on 16/11/3.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "Stepsecond.h"
#import "ZSDetailOrderModel.h"

#import "OrderScrollView.h"


#import "Stepthird.h"

@interface Stepsecond()<UITextFieldDelegate>
{
    NSMutableArray *_detailArray;//维修
    NSMutableArray *_detailArray1;//安装
    
    
    UIImageView *_backimageview;
    OrderScrollView *sce;
}



@property (nonatomic,strong)NSMutableArray *titleArr;
@property (nonatomic,strong)NSArray *kindArr;
@end

@implementation Stepsecond


- (void)viewWillAppear:(BOOL)animated {
    
    self.navigationItem.title = [NSString stringWithFormat:@"%@(2/3)",[ZSDetailOrderModel shareDetailOrder].NavTitle];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    sce = [[OrderScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    sce.contentSize = CGSizeMake(0, 800);
    sce.backgroundColor = ViewController_Back_Color;
    [self.view addSubview:sce];

    
    [self initkind];
    
    [self nextstepbtn];
    
    
    
    _backimageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"OrderBackBig"]];
    _backimageview.frame = CGRectMake(0, KScreenHeight/5 -64, KScreenWidth, KScreenWidth);
    
    CABasicAnimation *basicAnimation1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    basicAnimation1.fromValue = @(2*M_PI);
    basicAnimation1.toValue = @0;
    basicAnimation1.duration = 15;
    basicAnimation1.repeatCount = HUGE_VALF;
    basicAnimation1.removedOnCompletion = NO;
    basicAnimation1.fillMode = kCAFillModeBoth;
    [_backimageview.layer addAnimation:basicAnimation1 forKey:@"rotation"];
    
    [self.view addSubview:_backimageview];
    
}


- (void)initkind {
    
    self.interone = [ZSDetailOrderModel shareDetailOrder].FirstIndex;//1000 1001 1002 1003
    self.intertwo = [ZSDetailOrderModel shareDetailOrder].SecondIndex;//2 3 4 5 6
    self.interkind = [ZSDetailOrderModel shareDetailOrder].KindIndex;//0维修 1安装
    
}


- (void)nextstepbtn {
    
    UIButton *nextbtn = [[UIButton alloc]init];
   
    nextbtn.frame = CGRectMake(15, [ZSDetailOrderModel shareDetailOrder].index * 60, KScreenWidth-30, 40);
    [nextbtn setTitle:@"下 一 步" forState:UIControlStateNormal];
    [nextbtn setTitleColor:ColorWithRGBA(124, 202, 247, 1) forState:UIControlStateNormal];
    [nextbtn setBackgroundImage:[UIImage imageNamed:@"wancheng"] forState:UIControlStateNormal];
    [nextbtn setBackgroundImage:[UIImage imageNamed:@"wancheng-hov"] forState:UIControlStateHighlighted];
    [nextbtn addTarget:self action:@selector(clickToSteptwo) forControlEvents:UIControlEventTouchDown];
    [sce addSubview:nextbtn];
}

- (void)clickToSteptwo {
    
    Stepthird *third = [[Stepthird alloc]init];
    [self.navigationController pushViewController:third animated:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
    self.navigationItem.title = @"上一步";
}

/**
 *  键盘响应时间
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//    [_HostBrand resignFirstResponder];
//    [_BatteryPack resignFirstResponder];
    return YES;
}


@end

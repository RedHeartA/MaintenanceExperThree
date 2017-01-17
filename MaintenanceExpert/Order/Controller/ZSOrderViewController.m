//
//  ZSOrderViewController.m
//  MaintenanceExpert
//
//  Created by xpc on 16/10/27.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSOrderViewController.h"
#import "ZSOrderLeftVc.h"
#import "ZSOrderRightVc.h"

#define kPageCount 2
#define kButton_H 40
#define kTag 100

@interface ZSOrderViewController ()<UIScrollViewDelegate>
{
    UIImageView *zsywHeaderImg;
}

@property (nonatomic, strong)UIScrollView *scroll;
@property (nonatomic, strong)UIButton *selectBtn;
@property (nonatomic, strong)UIView *pageLine;
@property (nonatomic, assign)NSInteger currentPages;
@property (nonatomic, strong)ZSOrderLeftVc *leftVc;
@property (nonatomic, strong)ZSOrderRightVc *rightVc;



@end

@implementation ZSOrderViewController

- (UIView *)pageLine {
    if (_pageLine == nil) {
        self.pageLine = [[UIView alloc]init];
        _pageLine.backgroundColor = ColorWithRGBA(13, 132, 200, 1);
        
    }
    return _pageLine;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = ViewController_Back_Color;
    
    self.navigationController.navigationBarHidden = NO;
    
//    self.title = @"订单列表";
    
    //设置可以左右滑动的ScrollView
    [self setupScrollView];
    
    //设置控制的每一个子控制器
    [self setupChildViewControll];
    
    //设置分页按钮
    [self setupPageButton];
    
}

/**
 *  设置可以左右滑动的ScrollView
 */
- (void)setupScrollView{
    
    self.scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kButton_H, KScreenWidth, KScreenHeight)];
    _scroll.pagingEnabled = YES;
    _scroll.delegate = self;
    _scroll.showsVerticalScrollIndicator = NO;
    //方向锁
    _scroll.directionalLockEnabled = YES;
    //取消自动布局
    self.automaticallyAdjustsScrollViewInsets = NO;
    _scroll.contentSize = CGSizeMake(KScreenWidth * kPageCount, KScreenHeight);
    
    [self.view addSubview:_scroll];
}

/**
 *  设置控制的每一个子控制器
 */
- (void)setupChildViewControll{
    self.leftVc = [[ZSOrderLeftVc alloc]init];
    self.rightVc = [[ZSOrderRightVc alloc]init];
    
    //指定该控制器为其子控制器
    [self addChildViewController:_leftVc];
    [self addChildViewController:_rightVc];
    
    //将视图加入ScrollView上
    [_scroll addSubview:_leftVc.view];
    [_scroll addSubview:_rightVc.view];
    
    //设置两个控制器的尺寸
    _leftVc.view.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight - CGRectGetMinY(self.pageLine.frame));
    _rightVc.view.frame = CGRectMake(KScreenWidth, 0, KScreenWidth, KScreenHeight - CGRectGetMinY(self.pageLine.frame));
}

/**
 *  设置分页按钮
 */
- (void)setupPageButton{
    //button的index值应当从0开始
    UIButton *btn = [self setupButtonWithTitle:@"正在进行的订单" textColor:Home_Order_secendColor Index:0];
    self.selectBtn = btn;
    [btn setBackgroundColor:ColorWithRGBA(20, 70, 110, 1)];       //  left ColorWithRGBA(20, 70, 110, 1)
    [self setupButtonWithTitle:@"已完成的订单" textColor:Home_Order_secendColor Index:1];
}
- (UIButton *)setupButtonWithTitle:(NSString *)title textColor:(UIColor *)textColor Index:(NSInteger)index{
    CGFloat y = 0;
    CGFloat w = KScreenWidth/kPageCount;
    CGFloat h = kButton_H;
    CGFloat x = index * w;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:(UIControlStateNormal)];
    btn.frame = CGRectMake(x, y, w, h);
    [btn setBackgroundColor:ColorWithRGBA(15, 50, 80, 1)];   //  right
    [btn setTitleColor:textColor forState:(UIControlStateNormal)];
    btn.tag = index + kTag;
    
    [btn addTarget:self action:@selector(pageClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
    //按钮下方的线
    self.pageLine.frame = CGRectMake(0, CGRectGetMaxY(btn.frame) - 2, w, 2);
    //    _pageLine.layer.cornerRadius = 1;
    [self.view addSubview:_pageLine];
    return btn;
}
- (void)pageClick:(UIButton *)btn{
    self.currentPages = btn.tag - kTag;
    [self gotoCurrentPage];
}

/**
 *  设置选中button的样式
 */
- (void)setupSelectBtn{
    UIButton *btn = [self.view viewWithTag:self.currentPages + kTag];
    if ([self.selectBtn isEqual:btn]) {
        return;
    }
    [self.selectBtn setBackgroundColor:ColorWithRGBA(15, 50, 80, 1)];    //  right
    self.selectBtn = btn;
    [btn setBackgroundColor:ColorWithRGBA(20, 70, 110, 1)];                 //    left ColorWithRGBA(20, 70, 110, 1)
    self.pageLine.center = CGPointMake(btn.center.x, CGRectGetMaxY(btn.frame));
}

/**
 *  进入当前的选定页面
 */
- (void)gotoCurrentPage{
    CGRect frame;
    frame.origin.x = self.scroll.frame.size.width * self.currentPages;
    frame.origin.y = 0;
    frame.size = _scroll.frame.size;
    [_scroll scrollRectToVisible:frame animated:YES];
}

#pragma mark - ScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = _scroll.frame.size.width;
    self.currentPages = floor((_scroll.contentOffset.x - pageWidth/2)/pageWidth) + 1;
    
    //设置选中button的样式
    [self setupSelectBtn];
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

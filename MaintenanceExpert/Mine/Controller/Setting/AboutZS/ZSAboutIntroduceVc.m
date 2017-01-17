//
//  ZSAboutIntroduceVc.m
//  MaintenanceExpert
//
//  Created by xpc on 16/12/2.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSAboutIntroduceVc.h"

@interface ZSAboutIntroduceVc ()

{
    UITextView *_textView;
}


@end

@implementation ZSAboutIntroduceVc


- (UITextView *)createTextView {
    
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(15, 0, KScreenWidth - 30, KScreenHeight - 80)];
    _textView.editable = NO;
    _textView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_textView];
    _textView.font = [UIFont systemFontOfSize:18];
    _textView.showsHorizontalScrollIndicator = NO;
    _textView.showsVerticalScrollIndicator = NO;
    _textView.text = @"        中数运维（北京）科技有限公司是一家成立于北京市, 服务于全国智能建筑机房行业的互联网企业。公司采用互联网技术建立一个共享的线上售后服务交易平台——中数运维, 通过中数运维将全国各地的维修工程师资源放置于线上, 使全国各地需要售后维修及技术支持服务的客户通过网络找到合适的技术人员和维修工程师, 为客户的工程项目提供优秀及时的本地化维修售后技术服务。\n\n        中数运维提供统一的平台管理, 为客户和维修工程师提供一个交流沟通的网络平台, 交易平台, 解决客户需要远程的技术支持及售后服务时所面临的人力、物力、财力等资源不合理配置问题, 免去客户外派技术人员和维修工程师往返检修的烦恼, 将传统的工程技术服务结合先进的互联网, 构建工程领域互联网+的服务方式， 开启工程行业技术服务线上促成交易, 线下提供及时优质服务的商业模式, 使得项目用户、工程客户、线下工程师多方优势资源得以充分利用, 拓展更为宽广的市场, 多方互惠共赢, 促进工程行业朝着可持续性方向发展。\n\n        中数运维旨在创造一个从单机房单设备的快速响应故障处理维护至广区域多机房系统化的维保循环解决方案， 快速、专业、满足客户需求及研发于一体的互联网崭新架构。";
    _textView.textColor = Label_Color;
    
    return _textView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self createTextView];
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

//
//  ZSOrderStatusVC.m
//  MaintenanceExpert
//
//  Created by koka on 16/12/6.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSOrderStatusVC.h"
#import "ZSOrderStatusView.h"
#import "ZSNavigationController.h"
#import "Basicmapview.h"

@interface ZSOrderStatusVC ()<UIScrollViewDelegate>
{
    UIScrollView *_scrollview;
    NSInteger _viewtag;
    NSMutableArray *_OrderStatusarray;
    NSMutableArray *_OrderSubarray;
    
}

@end

@implementation ZSOrderStatusVC

- (void)viewWillAppear:(BOOL)animated {
    
    [self initinfo];
    
    [self createUI];
    [self createline];
    
}

#warning **5s bug!!!!!!!!!!!!!!!!!!!!!
- (void)viewDidLoad{
    
    [super viewDidLoad];
    self.navigationItem.title = @"订单状态";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]}];        
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tintColor = ColorWithRGBA(44, 137, 152, 1);
    btn.frame = CGRectMake(15, 8, 53.5, 23.5);
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setBackgroundImage:[UIImage imageNamed:@"backbackgroundimage"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(goBackAction) forControlEvents: UIControlEventTouchUpInside];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn setTitleColor:TextField_Text_Color forState:UIControlStateNormal];
    UIBarButtonItem * back = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = back;
    
    self.view.backgroundColor = ColorWithRGBA(20, 31, 63, 1);

    
}

- (void)goBackAction{
    
    // 在这里增加返回按钮的自定义动作
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)initinfo {
    /**
     *  此处后台传入值，确定订单状态
     */
    _viewtag = 104;
    
    NSString *OverTime = @"10-21 11:20";
    NSString *OverTimeDetail = [NSString stringWithFormat:@"超过%@未接单 可享受50%%赔付",OverTime];
    NSString *personTel = @"18695641256";
    NSString *personTelDatail = [NSString stringWithFormat:@"运维人员电话:%@",personTel];
    NSString *OrderNum = @"147854655689545";
    NSString *OrderNumDetail = [NSString stringWithFormat:@"订单号:%@",OrderNum];
    
    _OrderStatusarray = [[NSMutableArray alloc]initWithObjects:@"订单提交成功",@"订单已支付",@"等待工程师接单",@"本订单支持超时赔付",@"工程师已经确认订单",@"工程师在路上",@"工程师已到机房",@"订单已完成", nil];
    _OrderSubarray = [[NSMutableArray alloc]initWithObjects:OrderNumDetail,@"",@"",OverTimeDetail,@"正在为您准备",personTelDatail,personTelDatail,@"任何已经请吐槽，欢迎联系我们",nil];
    
}
- (void)createUI {
    
    _scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - 64 )];
    _scrollview.backgroundColor = ColorWithRGBA(20, 31, 63, 1);
    [self.view addSubview:_scrollview];
    _scrollview.showsVerticalScrollIndicator = YES;
    _scrollview.showsHorizontalScrollIndicator = NO;
    _scrollview.contentSize = CGSizeMake(0, 640 + 160 + 140);
    _scrollview.delegate = self;
    
    for (int i = 0; i < 8; i++) {
        ZSOrderStatusView *view = [[ZSOrderStatusView alloc]init];
        [_scrollview addSubview:view];
        view.Statuslabel.text = [NSString stringWithFormat:@"%@",_OrderStatusarray[i]];
        view.Statuslabel.textColor = TextField_Text_Color;
        
        view.StatusSublabel.text = [NSString stringWithFormat:@"%@",_OrderSubarray[i]];
        view.StatusSublabel.textColor = Label_Color;
        view.backgroundColor = self.view.backgroundColor;
        NSString *str = [NSString stringWithFormat:@"%d",i+1];
        view.Statusimageview.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_1",str]];
//        view.Statusimageview.contentMode = UIViewContentModeScaleAspectFill;
        if (i < 6) {
            view.frame = CGRectMake(0, 80*i, KScreenWidth, 80);
        }else{
            view.frame = CGRectMake(0, 80*(i - 6)+640, KScreenWidth, 80);
        }
        view.tag = i + 100;
        if (view.tag <= _viewtag) {
            NSInteger index = _viewtag - 100;
            for (int i = (int)index; i >= 0; i--) {
                view.backimage = [view.backimage stretchableImageWithLeftCapWidth:view.backimage.size.width * 0.5 topCapHeight:0];
                view.backgroundimageview.image = view.backimage;
                //view.Statuslabel.textColor = [UIColor blackColor];
                view.Statusimageview.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_2",str]];
            }
        }
    }
    
    UIView *mapview = [[UIView alloc]initWithFrame:CGRectMake(64, 480, KScreenWidth - 76, 160)];
    mapview.backgroundColor = ColorWithRGBA(16, 64, 105, 1);
    /*
     此处加载地图
     */
    Basicmapview *basic = [[Basicmapview alloc]initWithFrame:CGRectMake(0,0, KScreenWidth - 76, 160)];
    [mapview addSubview:basic];
    [_scrollview addSubview:mapview];
    
}
- (void)createline {
    
    for (int i = 0; i< 7; i++) {
        UIImageView *line = [[UIImageView alloc]init];
        if (i < 5) {
            line.frame =CGRectMake(20 + 12, 80 * (i+1) - 25+2.5, 1, 50);
        }else if (i == 5) {
            line.frame =CGRectMake(20 + 12, 455+2.5, 1, 210);
        }else{
            line.frame =CGRectMake(20 + 12, 695+2.5, 1, 50);
        }
        [_scrollview addSubview:line];
        line.tag = i + 10;
        if ((line.tag-10) < (_viewtag - 100)) {
            line.backgroundColor = ColorWithRGBA(31, 178, 248, 1);
        }else{
            
            line.backgroundColor = ColorWithRGBA(60, 136, 131, 1);
        }
        
    }
    
    
    
}


@end

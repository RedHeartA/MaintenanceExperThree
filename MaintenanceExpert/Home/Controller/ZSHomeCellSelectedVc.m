//
//  ZSHomeCellSelectedVc.m
//  MaintenanceExpert
//
//  Created by xpc on 16/12/28.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSHomeCellSelectedVc.h"
#import "ZSHomeSelectedFirstCell.h"
#import "ZSHomeSelectedTabCell.h"

@interface ZSHomeCellSelectedVc ()<UITableViewDelegate, UITableViewDataSource>

{
    UITableView *_tableView;
    NSMutableArray *_DetailArray;
}


@end

@implementation ZSHomeCellSelectedVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = ViewController_Back_Color;

    [self creatTableView];
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
    
}


- (void)creatTableView {
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = YES;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;  //  设置分割线
    _tableView.showsVerticalScrollIndicator = YES;
    _tableView.backgroundColor = ViewController_Back_Color;
    [_tableView registerClass:[ZSHomeSelectedFirstCell class] forCellReuseIdentifier:@"homeSelectedFirstCell"];
    [_tableView registerClass:[ZSHomeSelectedTabCell class] forCellReuseIdentifier:@"homeSelectedCell"];
    [self.view addSubview:_tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 14;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        ZSHomeSelectedTabCell *detailcell = [[ZSHomeSelectedTabCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"homeSelectedCell"];
        detailcell = [tableView dequeueReusableCellWithIdentifier:@"homeSelectedCell" forIndexPath:indexPath];
        detailcell.selectionStyle = UITableViewCellSelectionStyleNone;
        return detailcell;
    }else  {
        
        _DetailArray = [[NSMutableArray alloc]initWithObjects:@"服务地址:",@"详细地址:",@"维修时间:",@"联系人:",@"联系电话:",@"是否郊县:",@"服务类型:",@"UPS类型:",@"UPS功率:",@"主机品牌:",@"主机台数:",@"主机除尘:",@"服务名义:",@"维修说明:",nil];
        NSMutableArray *array = [[NSMutableArray alloc]initWithObjects:@"山东省青岛市市北区",@"市北区敦化路325号青岛农业银行",@"10/20 10:00-12:00",@"张",@"15556393810",@"否",@"维护",@"单相",@"1KVA",@"施耐德",@"2台",@"不需要",@"以中数运维名义上门",@"", nil];
        
        ZSHomeSelectedFirstCell *orderinfocell = [[ZSHomeSelectedFirstCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"homeSelectedFirstCell"];
        orderinfocell = [tableView dequeueReusableCellWithIdentifier:@"homeSelectedFirstCell" forIndexPath:indexPath];
        orderinfocell.selectionStyle = UITableViewCellSelectionStyleNone;
        orderinfocell.textLabel.text = [NSString stringWithFormat:@"%@",_DetailArray[indexPath.row - 1]];
        orderinfocell.textLabel.textColor = Label_Color;
        orderinfocell.textLabel.font = [UIFont systemFontOfSize:13];
        orderinfocell.detailTextLabel.text = [NSString stringWithFormat:@"%@",array[indexPath.row - 1]];
        orderinfocell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        orderinfocell.detailTextLabel.textAlignment = NSTextAlignmentLeft;
        orderinfocell.detailTextLabel.textColor = TextField_Text_Color;
        return orderinfocell;
    }
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

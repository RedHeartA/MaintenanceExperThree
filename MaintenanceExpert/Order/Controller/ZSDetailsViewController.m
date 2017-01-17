//
//  ZSDetailsViewController.m
//  MaintenanceExpert
//
//  Created by xpc on 16/11/8.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSDetailsViewController.h"
#import "ZSOrderStatusCell.h"
#import "ZSOrderDetailCell.h"
#import "ZSDetailOrderInfoCell.h"
#import "ZSOrderOtherInfoCell.h"
#import "ZSCostCell.h"
#import "ZSOrderStatusVC.h"

#import "OrderModel.h"

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)  

@interface ZSDetailsViewController ()<UITableViewDataSource,UITableViewDelegate>

{
    UITableView *_tableView;
    NSMutableArray *_DetailArray;
}



@end

@implementation ZSDetailsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = ViewController_Back_Color;
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = YES;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;  //  设置分割线
    _tableView.showsVerticalScrollIndicator = YES;
    _tableView.backgroundColor = ViewController_Back_Color;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [_tableView registerClass:[ZSOrderStatusCell class] forCellReuseIdentifier:@"statuscell"];
    [_tableView registerClass:[ZSOrderDetailCell class] forCellReuseIdentifier:@"detailcell"];
    [_tableView registerClass:[ZSDetailOrderInfoCell class] forCellReuseIdentifier:@"orderinfocell"];
    [_tableView registerClass:[ZSCostCell class] forCellReuseIdentifier:@"costcell"];
    [_tableView registerClass:[ZSOrderOtherInfoCell class] forCellReuseIdentifier:@"othercell"];
    [self.view addSubview:_tableView];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
        view.backgroundColor = UIView_BackView_color;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, 30)];
        label.text = @"订单详情";
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = Label_Color;
        [view addSubview:label];
        return view;
    } else if (section == 1){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
        view.backgroundColor = UIView_BackView_color;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, 30)];
        label.text = @"订单明细";
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = Label_Color;
        [view addSubview:label];
        return view;
    } else {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
        view.backgroundColor = UIView_BackView_color;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, 30)];
        label.text = @"其他信息";
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = Label_Color;
        [view addSubview:label];
        return view;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    } else if (section == 1){
        return 14 + 6;
        //return _DetailArray.count + 7;
    } else {
        return 8;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 44;
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return 44;
        }else if (indexPath.row>0 & indexPath.row<15) {
            return 30;
        }else{
            return 40;
        }
    }else {
        return 44;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        ZSOrderStatusCell *statuscell = [tableView dequeueReusableCellWithIdentifier:@"statuscell" forIndexPath:indexPath];
        statuscell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        statuscell.detailTextLabel.text = @"查看详情";
        statuscell.detailTextLabel.textColor = TextField_Text_Color;
        if (!statuscell) {
            statuscell = [[ZSOrderStatusCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"statuscell"];
            statuscell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
            [statuscell layoutSubviews];
        }
        return statuscell;
        
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            ZSOrderDetailCell *detailcell = [[ZSOrderDetailCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"detailcell"];
            detailcell = [tableView dequeueReusableCellWithIdentifier:@"detailcell" forIndexPath:indexPath];
            detailcell.selectionStyle = UITableViewCellSelectionStyleNone;
            detailcell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return detailcell;
        }else if (indexPath.row >= 1 & indexPath.row <= 14) {
            
            _DetailArray = [[NSMutableArray alloc]initWithObjects:@"服务地址:",@"详细地址:",@"维修时间:",@"联系人:",@"联系电话:",@"是否郊县:",@"服务类型:",@"UPS类型:",@"UPS功率:",@"主机品牌:",@"主机台数:",@"主机除尘:",@"服务名义:",@"维修说明:",nil];
            NSMutableArray *array = [[NSMutableArray alloc]initWithObjects:@"山东省青岛市市北区",@"市北区敦化路325号青岛农业银行",@"10/20 10:00-12:00",@"张",@"15556393810",@"否",@"维护",@"单相",@"1KVA",@"施耐德",@"2台",@"不需要",@"以中数运维名义上门",@"", nil];
            
            ZSDetailOrderInfoCell *orderinfocell = [[ZSDetailOrderInfoCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"orderinfocell"];
            orderinfocell = [tableView dequeueReusableCellWithIdentifier:@"orderinfocell" forIndexPath:indexPath];
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
        else
            {
                NSMutableArray *array = [[NSMutableArray alloc]initWithObjects:@"维护费:",@"主机除尘费:",@"郊县费:", nil];
                
                ZSCostCell *cell = [[ZSCostCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"costcell"];
                cell = [tableView dequeueReusableCellWithIdentifier:@"costcell" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                if (indexPath.row >= 15 & indexPath.row <= 17) {
                    cell.textLabel.text =[NSString stringWithFormat:@"%@",array[indexPath.row -15]];
                    cell.textLabel.textColor = Label_Color;
                    NSMutableArray *array = [[NSMutableArray alloc]initWithObjects:@"￥1000.00",@"￥0.00",@"￥0.00", nil];
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",array[indexPath.row -15]];
                    cell.detailTextLabel.textColor = TextField_Text_Color;
                    return cell;
                }else if(indexPath.row == 18) {
                    cell.textLabel.text = @"立减优惠";
                    cell.textLabel.textColor = Label_Color;
                    cell.detailTextLabel.text = @"￥0.00";
                    cell.detailTextLabel.textColor = TextField_Text_Color;
                    return cell;
                }else {
                    NSString *yuanjia = @"1000.00";
                    NSString *youhui = @"0.00";
                    NSString *ALL = @"1000.00";
                    cell.textLabel.text = [NSString stringWithFormat:@"原价:￥%@ 共优惠:￥%@",yuanjia,youhui];
                    cell.textLabel.textColor = Label_Color;
                    cell.textLabel.font = [UIFont systemFontOfSize:15];
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"总计:￥%@",ALL];
                    cell.detailTextLabel.textColor = TextField_Text_Color;
                    cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
                    return cell;
                }
        }
    }else{
        ZSOrderOtherInfoCell *cell = [[ZSOrderOtherInfoCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"othercell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"othercell" forIndexPath:indexPath];
        NSMutableArray *array = [[NSMutableArray alloc]initWithObjects:@"服务方:",@"运维人员:",@"运维时间:",@"客户信息:",@"订单号:",@"支付方式:",@"备注信息:",@"发票信息:", nil];
        NSMutableArray *arrays = [[NSMutableArray alloc]initWithObjects:@"中数运维",@"贾广超",@"定期巡检",@"张 1121121211",@"147696365964559",@"在线支付",@"无",@"无", nil];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = [NSString stringWithFormat:@"%@",array[indexPath.row]];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",arrays[indexPath.row]];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = Label_Color;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
        cell.detailTextLabel.textColor = TextField_Text_Color;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        ZSOrderStatusVC *statusVC = [[ZSOrderStatusVC alloc]init];
        [self.navigationController pushViewController:statusVC animated:YES];
    }
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        
        NSLog(@"机房信息");
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

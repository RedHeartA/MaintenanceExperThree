//
//  ZSMessageViewController.m
//  MaintenanceExpert
//
//  Created by koka on 16/10/18.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSMessageViewController.h"
#import "ZSMessageViewFirstCell.h"
#import "ZSMessageViewCell.h"
#import "ZSMessagecChatRoomVc.h"

@interface ZSMessageViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@end



@implementation ZSMessageViewController

#warning ***5s tabbar bug!!!!!!!!!!!!!!!!!!!!!!
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    
    self.view.backgroundColor = ViewController_Back_Color;
    
    
    [self creatTableView];
    
}

- (void)creatTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - 67) style:UITableViewStylePlain];
    self.tableView.backgroundColor = ViewController_Back_Color;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.row == 0) {
        
        static NSString *identifier = @"ZSMessageViewFirstCell";
        
        ZSMessageViewFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if(!cell) {
            
            cell = [[ZSMessageViewFirstCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        return cell;
    }
        
    static NSString *identifier = @"ZSMessageViewCell";
    
    ZSMessageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if(!cell) {
        
        cell = [[ZSMessageViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        ZSMessagecChatRoomVc *chatRoomVc = [[ZSMessagecChatRoomVc alloc] init];
        [self.navigationController pushViewController:chatRoomVc animated:YES];
    }else {
        
        ZSMessagecChatRoomVc *chatRoomVc = [[ZSMessagecChatRoomVc alloc] init];
        [self.navigationController pushViewController:chatRoomVc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 90;
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

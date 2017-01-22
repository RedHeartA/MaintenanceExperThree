//
//  ZSSettingViewController.m
//  MaintenanceExpert
//
//  Created by koka on 16/10/26.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSSettingViewController.h"
#import "ZSLoginViewController.h"
#import "ZSMineViewController.h"
#import "ZSNavigationController.h"
#import "MineInfModel.h"

#import "ZSMineInfoViewController.h"
#import "ZSAboutZSYWViewController.h"
#import "ZSHelpViewController.h"
#import "ZYShareView.h"

#import "ZSUserAgreementVc.h"


#define CELL_COUNT 8

@interface ZSSettingViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    NSString *_username;
    UIButton *_btn;
    MineInfModel *_Model;
    UISwitch* mySwitch;
}
@property (nonatomic,strong) UITableView *tableview;;
@property (strong, nonatomic) NSArray *dateListArr;

@end

@implementation ZSSettingViewController


- (void)viewWillAppear:(BOOL)animated {
    _username =  [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
//    NSLog(@"%@",_username);
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSData *data = [user objectForKey:@"USER"];
    MineInfModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    _Model = model;
    NSLog(@"%@",_Model.username);
    
    self.navigationController.navigationBarHidden = NO;
    
}


- (NSArray *)dateList {
    
    if (!_dateListArr) {
        NSMutableDictionary *Working = [NSMutableDictionary dictionary];
        Working[@"title"] = @"工作状态";
        
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        userInfo[@"title"] = @"账户详情";
        userInfo[@"controller"] = [ZSMineInfoViewController class];
        
        NSMutableDictionary *aboutZS = [NSMutableDictionary dictionary];
        aboutZS[@"title"] = @"关于中数运维";
        aboutZS[@"controller"] = [ZSAboutZSYWViewController class];
        
        NSMutableDictionary *CheckForUpdates = [NSMutableDictionary dictionary];
        CheckForUpdates[@"title"] = @"检查更新";
        
        NSMutableDictionary *helpAndFeed = [NSMutableDictionary dictionary];
        helpAndFeed[@"title"] = @"帮助与反馈";
        helpAndFeed[@"controller"] = [ZSHelpViewController class];
        
        NSMutableDictionary *share = [NSMutableDictionary dictionary];
        share[@"title"] = @"分享给朋友";
        
        NSMutableDictionary *userAgreement = [NSMutableDictionary dictionary];
        userAgreement[@"title"] = @"用户使用协议";
        userAgreement[@"controller"] = [ZSUserAgreementVc class];
        
        
        NSArray *section0 = @[Working,userInfo, aboutZS];
        NSArray *section1 = @[CheckForUpdates, helpAndFeed];
        NSArray *section2 = @[share, userAgreement];
        
        _dateListArr = [NSArray arrayWithObjects:section0, section1, section2, nil];
    }
    
    return _dateListArr;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = ViewController_Back_Color;
    view.frame = CGRectMake(0, -64, KScreenWidth, 64);
    [self.view addSubview:view];
    
   //_username =  [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    
    self.view.backgroundColor = ViewController_Back_Color;
    
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(5, 10, KScreenWidth - 10, 44*6 +21*3 +15) style:UITableViewStyleGrouped];

    _tableview.backgroundColor = ViewController_Back_Color;
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.bounces = NO;
    _tableview.showsVerticalScrollIndicator = NO;
    _tableview.showsHorizontalScrollIndicator = NO;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tableview];
    
    //  注册 Cell
    [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    _btn = [[UIButton alloc]initWithFrame:CGRectMake(10, _tableview.frame.size.height + 30, KScreenWidth - 20, Btn_NextAndOutLogin_Height)];
    [_btn setBackgroundImage:[UIImage imageNamed:@"wancheng"] forState:UIControlStateNormal];
    [_btn setBackgroundImage:[UIImage imageNamed:@"wancheng-hov"] forState:UIControlStateHighlighted];
    [_btn setTitle:@"退出登录" forState:UIControlStateNormal];
    _btn.tintColor = TextField_Text_Color;
    _btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_btn addTarget:self action:@selector(outlogin) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_btn];
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
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dateList.count ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.dateList[section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.backgroundColor = ColorWithRGBA(28, 54, 106, 1);
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];

        [self configureCell:cell indexPath:indexPath accessoryType:FLAT_DISCLOSURE_INDICATOR];
    }
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {

            cell.accessoryType = UITableViewCellAccessoryNone;
            mySwitch = [[ UISwitch alloc]initWithFrame:CGRectMake(KScreenWidth - 80 , 10, 0, 0)];
            [cell addSubview:mySwitch];
            [mySwitch setOn:NO animated:YES];
            
            mySwitch.onTintColor = [UIColor cyanColor];
            //  设置按钮的颜色
            mySwitch.thumbTintColor = ColorWithRGBA(50, 100, 190, 1);
            //  开关控件边框的颜色
            mySwitch.tintColor = [UIColor purpleColor];
            
            [mySwitch addTarget: self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];

        }else {
            
            UIImage *accessoryImage = [UIImage imageNamed:@"rightArrows.png"];
            UIImageView *accImageView = [[UIImageView alloc] initWithImage:accessoryImage];
            accImageView.userInteractionEnabled = YES;
            [accImageView setFrame:CGRectMake(0, 0, accessoryImage.size.width, accessoryImage.size.height)];
            cell.accessoryView = accImageView;
        }
    }else {
        
        UIImage *accessoryImage = [UIImage imageNamed:@"rightArrows.png"];
        UIImageView *accImageView = [[UIImageView alloc] initWithImage:accessoryImage];
        accImageView.userInteractionEnabled = YES;
        [accImageView setFrame:CGRectMake(0, 0, accessoryImage.size.width, accessoryImage.size.height)];
        cell.accessoryView = accImageView;
    }
    
    
    NSDictionary *dict = self.dateListArr[indexPath.section][indexPath.row];
    cell.textLabel.text = dict[@"title"];
    cell.textLabel.textColor = Label_Color;
    
    if (indexPath.section == 0) {
        if (indexPath.row != 2) {
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, LineInCell_height, _tableview.frame.size.width, 1)];
            line.backgroundColor = ColorWithRGBA(22, 94, 150, 1);
            [cell addSubview:line];
        }
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, LineInCell_height, _tableview.frame.size.width, 1)];
            line.backgroundColor = ColorWithRGBA(22, 94, 150, 1);
            [cell addSubview:line];
        }
    }else{
        if (indexPath.row == 0) {
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, LineInCell_height, _tableview.frame.size.width, 1)];
            line.backgroundColor = ColorWithRGBA(22, 94, 150, 1);
            [cell addSubview:line];
        }
    }
    
    return cell;
}


- (void)configureCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath accessoryType:(AccessoryType )accessoryType {
    
    if(accessoryType == FLAT_DISCLOSURE_INDICATOR) {
        
        cell.accessoryView = [MSCellAccessory accessoryWithType:accessoryType colors:@[[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0], [UIColor colorWithWhite:0.9 alpha:1.0]]];
    }
}



- (void) switchValueChanged:(id)sender{
    UISwitch* control = (UISwitch*)sender;
    if(control == mySwitch){
        BOOL on = control.on;
        //添加自己要处理的事情代码
    }
}
- (void)didClicksegmentedControlAction:(UISegmentedControl *)Seg{
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (self.dateListArr[indexPath.section][indexPath.row][@"controller"]){
        
        UIViewController *vc = [[self.dateListArr[indexPath.section][indexPath.row][@"controller"] alloc] init];
        
        vc.title = self.dateListArr[indexPath.section][indexPath.row][@"title"];
        
        
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section == 1 && indexPath.row == 0) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已是最新版本" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        NSLog(@"检查更新indexPath.section == 1 && indexPath.row == 0");
    }else if (indexPath.section == 2 && indexPath.row == 0) {
        
        [self shareToFriends];
    }
}


#pragma mark - 分享给朋友
- (void)shareToFriends {
    
    __weak typeof(self) weakSelf = self;
    
    // 创建代表每个按钮的模型
    ZYShareItem *item0 = [ZYShareItem itemWithTitle:@"发送给朋友"
                                               icon:@"Action_Share"
                                            handler:^{ [weakSelf itemAction:@"点击了发送给朋友"]; }];
    
    ZYShareItem *item1 = [ZYShareItem itemWithTitle:@"分享到朋友圈"
                                               icon:@"Action_Moments"
                                            handler:^{ [weakSelf itemAction:@"点击了分享到朋友圈"]; }];
    
    ZYShareItem *item2 = [ZYShareItem itemWithTitle:@"收藏"
                                               icon:@"Action_MyFavAdd"
                                            handler:^{ [weakSelf itemAction:@"点击了收藏"]; }];
    
    ZYShareItem *item3 = [ZYShareItem itemWithTitle:@"QQ空间"
                                               icon:@"Action_qzone"
                                            handler:^{ [weakSelf itemAction:@"点击了QQ空间"]; }];
    
    ZYShareItem *item4 = [ZYShareItem itemWithTitle:@"QQ"
                                               icon:@"Action_QQ"
                                            handler:^{ [weakSelf itemAction:@"点击了QQ"]; }];
    
    ZYShareItem *item5 = [ZYShareItem itemWithTitle:@"Facebook"
                                               icon:@"Action_facebook"
                                            handler:^{ [weakSelf itemAction:@"点击了Facebook"]; }];
    
    ZYShareItem *item6 = [ZYShareItem itemWithTitle:@"查看公众号"
                                               icon:@"Action_Verified"
                                            handler:^{ [weakSelf itemAction:@"点击了查看公众号"]; }];
    
    ZYShareItem *item7 = [ZYShareItem itemWithTitle:@"复制链接"
                                               icon:@"Action_Copy"
                                            handler:^{ [weakSelf itemAction:@"点击了复制链接"]; }];
    
    ZYShareItem *item8 = [ZYShareItem itemWithTitle:@"调整字体"
                                               icon:@"Action_Font"
                                            handler:^{ [weakSelf itemAction:@"点击了调整字体"]; }];
    
    ZYShareItem *item9 = [ZYShareItem itemWithTitle:@"刷新"
                                               icon:@"Action_Refresh"
                                            handler:^{ [weakSelf itemAction:@"点击了刷新"]; }];
    
    NSArray *shareItemsArray = @[item0, item1, item2, item3, item4, item5];
    NSArray *functionItemsArray = @[item6, item7, item8, item9];
    
    // 创建shareView
    ZYShareView *shareView = [ZYShareView shareViewWithShareItems:shareItemsArray
                                                    functionItems:functionItemsArray];
    // 弹出shareView
    [shareView show];
    
    
}

- (void)itemAction:(NSString *)title {
    
    NSLog(@"%@", title);
}


- (void)outlogin {

    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"username"];
        
    //[self.navigationController popViewControllerAnimated:YES];
    //[self.navigationController popToRootViewControllerAnimated:YES];
    
    ZSLoginViewController *login = [[ZSLoginViewController alloc]init];

    [self.navigationController pushViewController:login animated:YES];
    
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

//
//  ZSBalanceAddCardVc.m
//  MaintenanceExpert
//
//  Created by xpc on 16/11/30.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSBalanceAddCardVc.h"
#import "ZSBalanceAddCardTabVCell.h"
#import "ZSBankCardADD.h"
#import "BankCardModel.h"

@interface ZSBalanceAddCardVc ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *_BankCardArr;
}

@property (strong, nonatomic) UITableView *tableView;


@end

@implementation ZSBalanceAddCardVc

- (void)viewWillAppear:(BOOL)animated {
    
    self.BankCardDic = [[NSMutableDictionary alloc]init];
    self.BankCardDic = [BankCardModel shareBankCard].BankCardDic;
    
    if (_BankCardArr == nil) {
        _BankCardArr = [NSMutableArray array];
    }
    
#warning 有问题，添加银行卡后，会重复添加！！！！！！
    if (self.BankCardDic != nil) {
        [_BankCardArr addObject:self.BankCardDic];
    }
    NSLog(@"=======%@",self.BankCardDic);
    [_tableView reloadData];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = ViewController_Back_Color;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(AddCard)];
    
    [self creatTableView];
    [self creatAnimation];
    
    if (_BankCardArr == nil) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth/2 - 130, KScreenHeight/2 - 200, 260, 30)];
        label.text = @"请在右上角添加您的银行卡";
        label.textColor = Label_Color;
        label.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:label];
    }
    
    
    
    
    
}

- (void)AddCard {
    
    ZSBankCardADD *bankadd = [[ZSBankCardADD alloc]init];
    [self.navigationController pushViewController:bankadd animated:YES];
    
}


- (void)creatTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, KScreenWidth, KScreenHeight - 64) style:UITableViewStylePlain];
    self.tableView.backgroundColor = ViewController_Back_Color;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;  //  设置分割线
    [self.view addSubview:self.tableView];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _BankCardArr.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cell";
    
    ZSBalanceAddCardTabVCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];

    
    if (!cell) {
        
        cell = [[ZSBalanceAddCardTabVCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.cardName.text = [_BankCardArr[indexPath.row] objectForKey:@"bankname"];
    cell.cardNumber.text = [NSString stringWithFormat:@"****   ****   ****   %@",[_BankCardArr[indexPath.row] objectForKey:@"cardnumfour"]];
    cell.cardType.text = [_BankCardArr[indexPath.row] objectForKey:@"cardtype"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;    //  点击不变色
    return cell;
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

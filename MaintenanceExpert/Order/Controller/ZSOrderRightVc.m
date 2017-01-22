//
//  ZSOrderRightVc.m
//  MaintenanceExpert
//
//  Created by xpc on 16/12/2.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSOrderRightVc.h"
#import "ZSRightTableViewCell.h"
#import "ZSDetailsViewController.h"
#import "ZSOrderEvaluateVc.h"

@interface ZSOrderRightVc ()<UITableViewDelegate, UITableViewDataSource>

{
    NSInteger page;
}

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) UIButton *TOTopRight;

@property (nonatomic, strong) NSMutableArray *dataList;

@property (nonatomic, strong) NSMutableArray *array;

@property (strong, nonatomic) CCActivityHUD *activityHUD;

@end

@implementation ZSOrderRightVc

- (void)viewWillAppear:(BOOL)animated {
    if (_activityHUD) {
        _activityHUD.hidden = NO;
    }else{
        
    }
    //1. 添加监听
    [_tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = ColorWithRGBA(17, 32, 61, 1);
    
    _dataList = [[NSMutableArray alloc] init];
    
    [self creatTableView];
    /**
     *  添加上下拉刷新
     *
     *  @param  downRefresh upRefresh
     *
     *  @return 调用方法刷新数据
     */
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(downRefresh)];
    
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=39; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%zd", i]];
        [refreshingImages addObject:image];
    }
    // Hide the time
    header.lastUpdatedTimeLabel.hidden = YES;
    // Hide the status
    header.stateLabel.hidden = YES;
    [header setImages:refreshingImages forState:MJRefreshStateIdle];
    [header setImages:refreshingImages forState:MJRefreshStateRefreshing];
    _tableView.mj_header = header;
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upRefresh)];
    
    _dataList = [[NSMutableArray alloc]init];
    
    
    self.activityHUD = [CCActivityHUD new];
    self.activityHUD.isTheOnlyActiveView = YES;
    
    [self.activityHUD showWithGIFName:@"baymax2.gif"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.activityHUD dismissNoSecondView];
        _tableView.userInteractionEnabled = YES;
        
        [self reloaddata];
    });
}

/**
 *  通过定义一个page，每次刷新刷出五组数据
 */
- (void)downRefresh {
    page = 0;
    [self reloaddata];
}

- (void)upRefresh {
    NSInteger page1 = page;
    page1++;
    page = page1;
    [self reloaddata];
}

#pragma mark ---- 刷新数据
- (void)reloaddata{
    
    NSDictionary *dic = [[NSDictionary alloc] init];
    
    dic = @{@"kindImageName":@"home_xiu",
            @"title":@"北京市敦化路325号青岛银行机房建设建设建设建设建设",
            @"price":@"3000.00",
            @"orderStatus":@"紧急维护",
            @"receiveorderTime":@"2016年11月28日",
            @"pushorderTime":@"2016年08月01日"
            };
    _array = [[NSMutableArray alloc]init];
    for (int i = 0; i < 5; i ++) {
        OrderModel *model = [[OrderModel alloc] initWithDictionary:dic];
        
        [_array addObject:model];
    }
    
    //赋值给全局数组
    if (page == 0) {
        //赋值给全局数组
        _dataList = [NSMutableArray arrayWithArray:_array];
        
        //_dataList = _array;
    }else {
        NSArray *array1 = [NSArray arrayWithArray:_array];
        [_dataList addObjectsFromArray:array1];
    }
    //刷新表视图
    [_tableView reloadData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [_tableView.mj_header endRefreshing];
    });
    [_tableView.mj_footer endRefreshing];
}

- (void)totopRight {
    [_tableView setContentOffset:CGPointMake(0, 0) animated:YES];
}
- (void)creatTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - 128) style:UITableViewStylePlain];
    _tableView.backgroundColor = ViewController_Back_Color;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;  //  设置分割线
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _tableView.userInteractionEnabled = NO;
    
    _TOTopRight = [[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth - 60, KScreenHeight - 220, 30, 30)];
    _TOTopRight.hidden = YES;
    [_TOTopRight setImage:[UIImage imageNamed:@"fanhuidingbu"] forState:UIControlStateNormal];
    [self.view addSubview:_TOTopRight];
    [_TOTopRight addTarget:self action:@selector(totopRight) forControlEvents:UIControlEventTouchUpInside];
}

//2.监听的处理

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context

{
    
    if ([keyPath isEqualToString:@"contentOffset"])
    {
        CGPoint offset = [change[NSKeyValueChangeNewKey] CGPointValue];
        NSLog(@"%f",offset.y);
        if (offset.y > KScreenHeight * 2) {
            [_TOTopRight setHidden:NO];
        }else{
            [_TOTopRight setHidden:YES];
        }
        
    }
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *rightIndentifier = @"ZSRightTableViewCell";
    
    ZSRightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:rightIndentifier];
    
    
    if(!cell) {
        cell = [[ZSRightTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rightIndentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.model = _dataList[indexPath.row];
        
        //  去评价
        _appraisal = [[UIButton alloc] init];
        //        _appraisal.backgroundColor = [UIColor cyanColor];
        [_appraisal setBackgroundImage:[UIImage imageNamed:@"chakanpingjia"] forState:UIControlStateNormal];
        _appraisal.frame = CGRectMake(KScreenWidth - 110, 120 - 25, 60, 20);
        [_appraisal setTitle:@"去 评 价" forState:UIControlStateNormal];
        [_appraisal setTitleColor:ColorWithRGBA(37, 174, 192, 1) forState:UIControlStateNormal];
        [_appraisal.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_appraisal addTarget:self action:@selector(appraisalRightButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:_appraisal];

    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZSDetailsViewController *leftDetailsVC = [[ZSDetailsViewController alloc] init];
    [self.navigationController pushViewController:leftDetailsVC animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [ZSRightTableViewCell getHeight] + 10;
}


#pragma mark - AppraisalButtonDelegate
- (void)appraisalRightButtonClick {
    
    ZSOrderEvaluateVc *evaluateVc = [[ZSOrderEvaluateVc alloc] init];
    [self.navigationController pushViewController:evaluateVc animated:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    if (_activityHUD) {
        _activityHUD.hidden = YES;
    }
    
    [_tableView removeObserver:self forKeyPath:@"contentOffset" context:nil];
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

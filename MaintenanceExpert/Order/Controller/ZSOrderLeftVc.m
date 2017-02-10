//
//  ZSOrderLeftVc.m
//  MaintenanceExpert
//
//  Created by xpc on 16/12/2.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSOrderLeftVc.h"
#import "ZSLeftTableViewCell.h"
#import "ZSDetailsViewController.h"

@interface ZSOrderLeftVc ()<UITableViewDelegate, UITableViewDataSource>

{
    NSInteger page;
}
@property (strong, nonatomic) UIButton *TOTop;

@property (strong, nonatomic) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataList;

@property (nonatomic, strong) NSMutableArray *array;

@property (strong, nonatomic) CCActivityHUD *activityHUD;
@end

@implementation ZSOrderLeftVc

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
    self.view.backgroundColor = ViewController_Back_Color;
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
    self.activityHUD.isTheOnlyActiveView = NO;
    
    [self.activityHUD showWithGIFName:@"baymax2.gif"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
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

#pragma mark - 刷新数据
- (void)reloaddata{
    
    NSDictionary *dic = [[NSDictionary alloc] init];
    
    dic = @{@"kindImageName":@"home_xiu",
            @"title":@"青岛市敦化路325号青岛银行机房建设建设建设建设建设",
            @"price":@"5000.00",
            @"orderStatus":@"定期巡检",
            @"receiveorderTime":@"2016年10月28日",
            @"pushorderTime":@"2016年09月01日"
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
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [_tableView.mj_header endRefreshing];
    });
    [_tableView.mj_footer endRefreshing];
}

- (void)totop {
    [_tableView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (void)creatTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - 136) style:UITableViewStylePlain];
    _tableView.backgroundColor = ViewController_Back_Color;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;  //  设置分割线
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _tableView.userInteractionEnabled = NO;
    
    _TOTop = [[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth - 60, KScreenHeight - 220, 50, 50)];
    _TOTop.hidden = YES;
    [_TOTop setImage:[UIImage imageNamed:@"fanhuidingbu"] forState:UIControlStateNormal];
    [self.view addSubview:_TOTop];
    [_TOTop addTarget:self action:@selector(totop) forControlEvents:UIControlEventTouchUpInside];
    
}

//2.监听的处理
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"contentOffset"])
    {
        CGPoint offset = [change[NSKeyValueChangeNewKey] CGPointValue];
        NSLog(@"%f",offset.y);
        if (offset.y > KScreenHeight * 2) {
            [_TOTop setHidden:NO];
        }else{
            [_TOTop setHidden:YES];
        }
    }
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *leftIdentifier = @"ZSLeftTableViewCell";
    
    ZSLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:leftIdentifier];
    
    if(!cell) {
        
        cell = [[ZSLeftTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:leftIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.model = _dataList[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZSDetailsViewController *leftDetailsVC = [[ZSDetailsViewController alloc] init];
    [self.navigationController pushViewController:leftDetailsVC animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [ZSLeftTableViewCell getHeight] + 10;
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

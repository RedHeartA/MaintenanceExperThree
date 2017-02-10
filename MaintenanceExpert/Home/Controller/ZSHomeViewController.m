//
//  ZSHomeViewController.m
//  MaintenanceExpert
//
//  Created by xpc on 16/10/25.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSHomeViewController.h"
#import "XRCarouselView.h"
#import "ZSHomeTableViewCell.h"
#import "ZSMapAroundViewController.h"
#import "ZSHomeCellSelectedVc.h"

#import "Basicmapview.h"

@interface ZSHomeViewController ()<UITableViewDelegate, UITableViewDataSource,XRCarouselViewDelegate>

{
    UIButton *leftTitleBtn;
    UIButton *rightTitltBtn;
    UIBarButtonItem *rightBarBtn;
    
    UIImageView *aroundImgView;  //
    UIButton *refreshBtn;   //  刷新位置
    
    UIImageView *mapBackView;    //  地图 背景图
    Basicmapview *_mapview;
}

@property (strong, nonatomic) XRCarouselView *carouselView;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UILabel *nowAddress;

@end

@implementation ZSHomeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
//    [_tableView setContentOffset:CGPointMake(0, 0) animated:YES];
    
}

//  二级页面 显示 NavigationBar
//- (void)viewWillDisappear:(BOOL)animated {
//
//    [super viewWillDisappear:animated];
//
//    if ( self.navigationController.childViewControllers.count > 1 ) {
//        [self.navigationController setNavigationBarHidden:NO animated:YES];
//    }
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.navigationController.navigationBarHidden = NO;
    
    self.view.backgroundColor = ViewController_Back_Color;
    
    [self creatNavigationView];
    
    [self creatScrollHeaderView];
    
    [self AroundMessage];
    
    [self creatMapView];
    
    [self creatTableView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //获取Documents路径
    //    NSArray*paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    //    NSString*path=[paths objectAtIndex:0];
    //    NSLog(@"path:%@",path);
    
}


//  发现、我的、 搜索按钮
- (void)creatNavigationView {
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth/3, 44)];
    //    titleView.backgroundColor = [UIColor cyanColor];
    
    
    //  发现
    leftTitleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, titleView.frame.size.width/2, 44)];
    [leftTitleBtn setTitle:@"发现" forState:UIControlStateNormal];
    [leftTitleBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    leftTitleBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [leftTitleBtn setTitleColor:ColorWithRGBA(43, 161, 229, 1) forState:UIControlStateNormal];
    [leftTitleBtn addTarget:self action:@selector(leftTitleBtnClick) forControlEvents:UIControlEventTouchDown];
    [titleView addSubview:leftTitleBtn];
    //  我的
    rightTitltBtn = [[UIButton alloc] initWithFrame:CGRectMake(titleView.frame.size.width/2, 0, titleView.frame.size.width/2, 44)];
    [rightTitltBtn setTitle:@"我的" forState:UIControlStateNormal];
    [rightTitltBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [rightTitltBtn setTitleColor:ColorWithRGBA(20, 129, 194, 1) forState:UIControlStateNormal];
    rightTitltBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [rightTitltBtn addTarget:self action:@selector(rightTitltBtnClick) forControlEvents:UIControlEventTouchDown];
    [titleView addSubview:rightTitltBtn];
    self.navigationItem.titleView = titleView;
    
    //  搜索
    rightBarBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"SearchIcon"] style:UIBarButtonItemStylePlain target:self action:@selector(searchButtonClick)];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    
}

//  轮播图
- (void)creatScrollHeaderView {
    
    UIImage *image1 = [UIImage imageNamed:@"APP_banner1"];
    UIImage *image2 = [UIImage imageNamed:@"APP_banner2"];
    UIImage *image3 = [UIImage imageNamed:@"APP_banner3"];
    
    NSArray *imageArr = @[
                          image1,
                          image2,
                          image3
//                          @"http://img2.3lian.com/2014/c7/12/d/77.jpg",
//                          @"http://img2.pconline.com.cn/pconline/0706/19/1038447_34.jpg",
//                          @"http://img3.iqilu.com/data/attachment/forum/201308/21/192654ai88zf6zaa60zddo.jpg",
//                          @"http://img06.tooopen.com/images/20160724/tooopen_sy_171572235394.jpg"
                          ];
    
    //    NSArray *describeArray = @[@"网络图片", @"本地图片", @"网络动态图", @"本地动态图"];
    
    self.carouselView = [[XRCarouselView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight*0.21)];
    
    //  设置占位图，需在设置数组图片之前设置，不设置则为默认占位图
    _carouselView.placeholderImage = [UIImage imageNamed:@"XRPlaceholder"];
    
    //  设置图片数组以及图片描述文字
    _carouselView.imageArray = imageArr;
    //    _carouselView.describeArray = describeArray;
    
    
    //  用代理处理图片点击
    _carouselView.delegate = self;
    
    //  设置图片的停留时间，默认为5s，最少为2s
    _carouselView.time = 2;
    
    //  设置分页控件的图片，不设置则为系统默认的
    [_carouselView setPageImage:[UIImage imageNamed:@"pageControlDot"] andCurrentPageImage:[UIImage imageNamed:@"pageControlCurrentDot"]];
    
    //  设置分页控件的位置，默认为PositionBottomCenter
    _carouselView.pagePosition = PositionBottomCenter;
    
    
    /**
     *  修改图片描述控件的外观，不需要修改的传nil
     *
     *  参数一 字体颜色，默认为白色
     *  参数二 字体，默认为13号字体
     *  参数三 背景颜色，默认为黑色半透明
     */
    //    UIColor *bgColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
    //    UIFont *font = [UIFont systemFontOfSize:15];
    //    UIColor *textColor = [UIColor greenColor];
    [_carouselView setDescribeTextColor:nil font:nil bgColor:nil];
    
    [self.view addSubview:_carouselView];
    
    
}

//  附近的信息
- (void)AroundMessage {
    
    aroundImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, KScreenHeight*0.22, 100, 25)];
    aroundImgView.image = [UIImage imageNamed:@"around_backicon"];
    [self.view addSubview:aroundImgView];
    
    UIImageView *leftLine = [[UIImageView alloc] init];
    leftLine.image = [UIImage imageNamed:@"around_backicon_left"];
    [aroundImgView addSubview:leftLine];
    leftLine.sd_layout.topSpaceToView(aroundImgView, 2)
    .leftSpaceToView(aroundImgView, 5)
    .bottomSpaceToView(aroundImgView, 2)
    .widthIs(5);
    
    
    UILabel *aroundLabel = [[UILabel alloc] init];
    aroundLabel.text = @"附近的信息";
    aroundLabel.textColor = ColorWithRGBA(44, 161, 227, 1);
    [aroundLabel setFont:[UIFont systemFontOfSize:14]];
    [aroundImgView addSubview:aroundLabel];
    aroundLabel.sd_layout.leftSpaceToView(leftLine, 8)
    .topSpaceToView(aroundImgView, 0)
    .widthIs(80)
    .heightIs(25);
    
    //  刷新位置按钮
    refreshBtn = [[UIButton alloc] init];
    [refreshBtn setImage:[UIImage imageNamed:@"home_location_refresh"] forState:UIControlStateNormal];
    [refreshBtn addTarget:self action:@selector(rotationAnimation) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:refreshBtn];
    refreshBtn.sd_layout.topEqualToView(aroundImgView)
    .rightSpaceToView(self.view, 5)
    .widthIs(25)
    .heightIs(25);
    
    
    //  当前位置
    _nowAddress = [[UILabel alloc] init];
    _nowAddress.text = @"敦化路160号丶诺德广场";
    _nowAddress.textColor = ColorWithRGBA(44, 163, 230, 1);
    [_nowAddress setFont:[UIFont systemFontOfSize:13]];
    _nowAddress.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:_nowAddress];
    _nowAddress.sd_layout.topEqualToView(aroundImgView)
    .rightSpaceToView(refreshBtn, 0)
    .widthIs(KScreenWidth / 2)
    .heightIs(25);
    
}

//  加载地图
- (void)creatMapView {
    
    mapBackView = [[UIImageView alloc] init];
    mapBackView.userInteractionEnabled = YES;
    mapBackView.image = [UIImage imageNamed:@"home_map_backicon"];
    mapBackView.contentMode =  UIViewContentModeScaleToFill;
    [self.view addSubview:mapBackView];
    
    if (iPhone5SE) {
        
        mapBackView.sd_layout.topSpaceToView(aroundImgView, 3)
        .leftSpaceToView(self.view, 0)
        .widthIs(KScreenWidth)
        .heightIs(KScreenHeight * 0.25);
    }else {
        
        mapBackView.sd_layout.topSpaceToView(aroundImgView, 3)
        .leftSpaceToView(self.view, 0)
        .widthIs(KScreenWidth)
        .heightIs(KScreenHeight * 0.3);
    }
    
    _mapview = [[Basicmapview alloc]init];
    _mapview.layer.cornerRadius = 3;
    [mapBackView addSubview:_mapview];
    _mapview.sd_layout.spaceToSuperView(UIEdgeInsetsMake(7, 6, 6, 9));
    
}

//  tableView
- (void)creatTableView {
    
    if (iPhone5SE) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, aroundImgView.origin.y +25 +3 +KScreenHeight * 0.25, KScreenWidth, KScreenHeight - KScreenHeight * 0.25 - KScreenHeight*0.21 - 25 - 64 - 40) style:UITableViewStyleGrouped];
    }else if (iPhone6_6s) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, aroundImgView.origin.y +25 +3 +KScreenHeight * 0.3, KScreenWidth, KScreenHeight - KScreenHeight * 0.3 - KScreenHeight*0.21 - 25 - 64 - 40) style:UITableViewStyleGrouped];
    }else if (iPhone6Plus_6sPlus) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, aroundImgView.origin.y +25 +3 +KScreenHeight * 0.3, KScreenWidth, KScreenHeight - KScreenHeight * 0.3 - KScreenHeight*0.21 - 25 - 64 - 47) style:UITableViewStyleGrouped];
    }
    
//    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, aroundImgView.origin.y +25 +3 +KScreenHeight * 0.3, KScreenWidth, KScreenHeight - KScreenHeight * 0.3 - KScreenHeight*0.21 - 25 - 64 - 49) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = ViewController_Back_Color;
    _tableView.showsVerticalScrollIndicator = NO;   //  关闭侧边滚动条
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //    _tableView.bounces = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;  //  设置分割线
    [self.view addSubview:_tableView];
    
//    //  tableFooterView   坐标有问题 -- tabbar 透明
//    UIButton *footerButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    footerButton.frame = CGRectMake(0, 15, KScreenWidth, 30);
//    [footerButton setTitle:@"查看更多请点这里---->>--->" forState:UIControlStateNormal];
//    [footerButton setTitleColor:ColorWithRGBA(44, 163, 230, 1) forState:UIControlStateNormal];
//    [footerButton addTarget:self action:@selector(moreButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    
//    _tableView.tableFooterView = footerButton;
    
    //    NSLog(@"偏移量--%f",_tableView.contentOffset.y);
    
    //  修改偏移量(位置不对)
    //    [_tableView setContentOffset:CGPointMake(0, 0)];
}


//  按钮方法
- (void)leftTitleBtnClick {
    
    [leftTitleBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [rightTitltBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    
    [leftTitleBtn setTitleColor:ColorWithRGBA(43, 161, 229, 1) forState:UIControlStateNormal];
    [rightTitltBtn setTitleColor:ColorWithRGBA(20, 129, 194, 1) forState:UIControlStateNormal];
    
    NSLog(@"发   现----");
}

- (void)rightTitltBtnClick {
    
    [leftTitleBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [rightTitltBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    
    [rightTitltBtn setTitleColor:ColorWithRGBA(43, 161, 229, 1) forState:UIControlStateNormal];
    [leftTitleBtn setTitleColor:ColorWithRGBA(20, 129, 194, 1) forState:UIControlStateNormal];
    
    NSLog(@"我   的----");
}

- (void)searchButtonClick {
    
    ZSMapAroundViewController *mapAroundVC = [[ZSMapAroundViewController alloc] init];
    
    [self.navigationController pushViewController:mapAroundVC animated:YES];
    
    NSLog(@"搜   索----");
}


////  刷新 当前位置     点击开始旋转
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    
//    //    根据animation的key 获取CAAnimation对象
//    CAAnimation *animation = [refreshBtn.layer animationForKey:@"rotation"];
//    
//    if (animation) {
//        
//        if(refreshBtn.layer.speed == 0){
//            [self resume];
//        }else{
//            [self pause];
//        }
//    }else{
//        
//        [self rotationAnimation];
//    }
//}

//  刷新按钮 动画
-(void)rotationAnimation{
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    basicAnimation.fromValue = @0;
    basicAnimation.toValue = @(2*M_PI);
    basicAnimation.duration = 1;
    basicAnimation.repeatCount = 3;
    basicAnimation.removedOnCompletion = NO;
    basicAnimation.fillMode = kCAFillModeBoth;
    [refreshBtn.layer addAnimation:basicAnimation forKey:@"rotation"];
}


//  数据请求结束  动画停止
#pragma mark - 暂停动画

-(void)pause{
    
    //设置timeOffset  将动画保持到 某一个时间点的位置
    CFTimeInterval time = [refreshBtn.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    refreshBtn.layer.timeOffset = time;
    
    refreshBtn.layer.speed = 0;
    
}

-(void)resume{
    
    CALayer *layer = refreshBtn.layer;
    
    CFTimeInterval pausedTime = layer.timeOffset; // 1. 让CALayer的时间继续⾏行⾛走
    layer.speed = 1.0;
    // 2. 取消上次记录的停留时刻
    layer.timeOffset = 0.0; // 3. 取消上次设置的时间
    layer.beginTime = 0.0;
    // 4. 计算暂停的时间(这里也可以用CACurrentMediaTime()-pausedTime)
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime; // 5. 设置相对于父坐标系的开始时间(往后退timeSincePause)
    layer.beginTime = timeSincePause;
    
}



#pragma mark - 代理方法
//动画开始
- (void)animationDidStart:(CAAnimation *)anim{
    
    NSLog(@"开始%@",anim);
    
}
//动画结束
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    NSLog(@"结束%@",anim);
}


//  查看更多
- (void)moreButtonClick {
    
    ZSMapAroundViewController *mapAroundVC = [[ZSMapAroundViewController alloc] init];
    [self.navigationController pushViewController:mapAroundVC animated:YES];
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZSHomeCellSelectedVc *selectedVc = [[ZSHomeCellSelectedVc alloc] init];
    [self.navigationController pushViewController:selectedVc animated:YES];
    
    NSLog(@"cell 被点击");
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return KScreenHeight * 0.09 +7;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 70.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"查看更多请点这里---->>--->" forState:UIControlStateNormal];
    [button setTitleColor:ColorWithRGBA(44, 163, 230, 1) forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [button addTarget:self action:@selector(moreButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"TableVieCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;        
        
        if (indexPath.row < 5){
            
            
            cell = [[ZSHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //  查看更多
        }
    }
    
    return cell;
}


#pragma mark - XRCarouselViewDelegate

- (void)carouselView:(XRCarouselView *)carouselView clickImageAtIndex:(NSInteger)index {
    
    NSLog(@"点击了第%ld张图",index);
}

//the freezing problem happens only when run from Xcode 8.0
- (void)dealloc
{
#if DEBUG
    // Xcode8/iOS10 MKMapView bug workaround
    static NSMutableArray* unusedObjects;
    if (!unusedObjects)
        unusedObjects = [NSMutableArray new];
    [unusedObjects addObject:_mapview];
#endif
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

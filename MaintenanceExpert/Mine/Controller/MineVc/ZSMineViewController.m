//
//  ZSMineViewController.m
//  MaintenanceExpert
//
//  Created by koka on 16/10/18.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSMineViewController.h"
#import "ZSLoginViewController.h"
#import "UIView+ZSExtension.h"
#import "ZSSettingViewController.h"
#import "ZSMineInfoViewController.h"
#import "MineInfModel.h"
#import "ZSBalanceViewController.h"
#import "ZSUserInformationVc.h"
#import "ZSUserGardeAuthVc.h"

#import "ZYShareView.h"

#import "SVProgressHUD.h"

#define XLColor(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

@interface ZSMineViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UIView *_HeaderView;
    MineInfModel *_Model;
    
    NSString *_userAuthName;
    NSString *_mymoney;
    
    NSString *fileSize; //  缓存大小
}

@property (nonatomic, strong) UITableView *tableView;

/** 数据数组 */
@property (nonatomic, strong) NSArray *dataList;

/** 记录清空缓存的index */
@property (nonatomic, strong) NSIndexPath *path;
/** 赚了多少钱 */
//@property (nonatomic, assign) UILabel *moneyLabel;
/** 去分享 */
@property (nonatomic, strong) UILabel *shareLabel;

@property (nonatomic, strong) UIButton *Loginbtn;

/** leftbtn  */
/**
 *  客户：收藏
    工程师：综合测评
 */
@property (nonatomic, strong) UILabel *leftlabel;
@property (nonatomic, strong) UILabel *leftlabelnum;

/** rightbtn */
/**
 *  客户：待评价（0）
    工程师：粉丝数
 */
@property (nonatomic, strong) UILabel *rightlabel;
@property (nonatomic, strong) UILabel *rightlabelnum;

@property (nonatomic,strong) NSString *userkind;

@property (nonatomic,strong) UIView *topLineView;
@property (nonatomic,strong) UIView *bottomLineView;

@end

@implementation ZSMineViewController


- (NSArray *)dataList{
    if (!_dataList) {
        NSMutableDictionary *dengji = [NSMutableDictionary dictionary];
        dengji[@"title"] = nil;
        dengji[@"icon"] = nil;
        
        NSMutableDictionary *yue = [NSMutableDictionary dictionary];
        yue[@"title"] = @"我的余额";
        yue[@"icon"] = @"balance";
        yue[@"controller"] = [ZSBalanceViewController class];
        
        NSMutableDictionary *UserInformation = [NSMutableDictionary dictionary];
        UserInformation[@"title"] = @"身份认证";
        UserInformation[@"icon"] = @"userAuth";
        UserInformation[@"controller"] = [ZSUserInformationVc class];
        
        NSMutableDictionary *cleanCache = [NSMutableDictionary dictionary];
        cleanCache[@"title"] = @"清空缓存";
        cleanCache[@"icon"] = @"cleanCache";
        
        NSMutableDictionary *setting = [NSMutableDictionary dictionary];
        setting[@"title"] = @"设置";
        setting[@"icon"] = @"setting";
        setting[@"controller"] = [ZSSettingViewController class];
        NSArray *section0 = @[dengji];
        NSArray *section1 = @[yue];
        NSArray *section2 = @[UserInformation];
        NSArray *section3 = @[cleanCache];
        NSArray *section4 = @[setting];
        
        _dataList = [NSArray arrayWithObjects:section0,section1, section2, section3, section4, nil];
    }
    return _dataList;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth , KScreenHeight +20) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = ViewController_Back_Color;
        _tableView.y = -20;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.bounces = NO;
//        _tableView.separatorColor = ColorWithRGBA(66, 248, 243, 1);//分割线颜色
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = _HeaderView;
        _tableView.tableHeaderView.userInteractionEnabled = YES;
        [self.view addSubview:_tableView];
    }
    
    return _tableView;
}

//  刷新tableview
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
    _username =  [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    
    if (_username == nil) {
        self.Loginbtn.hidden = NO;
        
    }else {
        self.Loginbtn.hidden = YES;
        
    }
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSData *data = [user objectForKey:@"USER"];
    MineInfModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    _Model = model;
    
    [self userinfor];
    [self.tableView reloadData];
    
    //  头像动画
    if (!_headerRing) {
        
    }else{
        
        CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        basicAnimation.fromValue = @0;
        basicAnimation.toValue = @(2*M_PI);
        basicAnimation.duration = 10;
        basicAnimation.repeatCount = 100;
        basicAnimation.removedOnCompletion = NO;
        basicAnimation.fillMode = kCAFillModeBoth;
        [_headerRing.layer addAnimation:basicAnimation forKey:@"rotation"];
    }
}


#pragma mark - life cycle...



- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = ViewController_Back_Color;
    
    [self setupHeaderView];
    
    NSLog(@"-----%@", [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]);
    
}

#warning 进入设置页面之后，侧滑一半再滑回设置页面之后，进入子页面，导航按钮失效

//  HeaderView 数据
/**
 *  此处加载网络数据，显示用户种类区分显示的两个按钮，读取粉丝/综合测评、收藏/待评价
 */
- (void)userinfor {
    
    if (_username != nil) {
        _moneyLabel.text = [NSString stringWithFormat:@"赚了%@元",_Model.moneynum];
        _icon.image = _Model.usericon;
        _nameLabel.text = _Model.username;
        _userAuthName = _Model.userAuthName;
        _userkind = _Model.userkind;
        _leftlabelnum.text = _Model.leftlabelnum;
        _rightlabelnum.text = _Model.rightlabelnum;
        _mymoney = _Model.Mymoney;
    } else {
        _icon.image = [UIImage imageNamed:@"defult_header_icon"];
        _nameLabel.text = @"";
        _moneyLabel.text = @"赚了0.00元";
        _icon = nil;
        _userkind = @"engineer";
        //_leftlabelnum.text = @"0";
        //_rightlabelnum.text = @"0";
        _userAuthName = @"";
        _mymoney = @"0";
    }
    [self commituserkind];
    /**
     *  信息、数据的更新
     */
    [self changeinformation];
}


/**
 *  信息、数据的更新
 */
- (void)changeinformation {
    
    _leftlabelnum.text = @"8";
    
    
}

- (void)setupHeaderView {
    _HeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 200)];
    _HeaderView.userInteractionEnabled = YES;
    _HeaderView.backgroundColor = ColorWithRGBA(23, 42, 79, 1);
//    _HeaderView.contentMode = UIViewContentModeScaleAspectFill;
    
//    _tableView.tableHeaderView = _HeaderView;
    [self createsubview];
}

- (void)createsubview {
    
    [self createnamelabel];
    [self createmoneylabel];
    [self createicon];
    
    [self createsharelabel];
    
    [self createTopLine];
    
    
    [self createleftbtn];
    [self createrightbtn];

    [self createBottomLine];
    
}

- (void)commituserkind {
    if ([_userkind isEqualToString:@"personal"] || [_userkind isEqualToString:@"company"]) {
        _leftlabel.text = @"收藏:";
        _rightlabel.text = @"待评价:";
    }else if ([_userkind isEqualToString:@"engineer"]){
        _leftlabel.text = @"粉丝:";
        _rightlabel.text = @"综合评分:";
    }
    _leftlabelnum.text = _Model.leftlabelnum;
    _rightlabelnum.text = _Model.rightlabelnum;
}

- (void)createleftbtn{
    _leftlabel = [[UILabel alloc]init];
    [_HeaderView addSubview:_leftlabel];
    _leftlabel.textAlignment = NSTextAlignmentCenter;
    _leftlabel.textColor = ColorWithRGBA(30, 124, 193, 1);
    _leftlabel.font = [UIFont systemFontOfSize:16];
    _leftlabel.sd_layout.topSpaceToView(_topLineView,0)
                        .leftSpaceToView(_HeaderView,0)
                        .heightIs(58)
                        .widthIs(KScreenWidth / 3);
    _leftlabelnum = [[UILabel alloc]init];
    [_HeaderView addSubview:_leftlabelnum];
    _leftlabelnum.textColor = ColorWithRGBA(51, 162, 243, 1);
    _leftlabelnum.font = [UIFont systemFontOfSize:15];
    _leftlabelnum.sd_layout.topSpaceToView(_topLineView,0)
    .leftSpaceToView(_leftlabel,0)
    .heightIs(58)
    .widthIs(KScreenWidth / 6);
    //_leftlabelnum.backgroundColor = [UIColor blueColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftTapGesture:)];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftTapGesture:)];
    [_leftlabel addGestureRecognizer:tap];
    [_leftlabelnum addGestureRecognizer:tap1];
    _leftlabel.userInteractionEnabled = YES;
    _leftlabelnum.userInteractionEnabled = YES;
    
    
    UIView *view = [[UIView alloc]init];
    [_HeaderView addSubview:view];
    view.sd_layout.topSpaceToView(_topLineView,0)
    .leftSpaceToView(_leftlabelnum,0)
    .heightIs(58)
    .widthIs(1);
    view.backgroundColor = ColorWithRGBA(46, 100, 152, 1);
    
}
- (void)createrightbtn{
    _rightlabel = [[UILabel alloc]init];
    [_HeaderView addSubview:_rightlabel];
    _rightlabel.textColor = ColorWithRGBA(30, 124, 193, 1);
    _rightlabel.font = [UIFont systemFontOfSize:16];
    _rightlabel.textAlignment = NSTextAlignmentCenter;
    _rightlabel.sd_layout.topSpaceToView(_topLineView,0)
    .leftSpaceToView(_leftlabelnum,1)
    .heightIs(58)
    .widthIs(KScreenWidth / 3);
    //_rightlabel.backgroundColor = [UIColor yellowColor];
    
    _rightlabelnum = [[UILabel alloc]init];
    [_HeaderView addSubview:_rightlabelnum];
    _rightlabelnum.textColor = ColorWithRGBA(51, 162, 243, 1);
    _rightlabelnum.font = [UIFont systemFontOfSize:15];
    _rightlabelnum.sd_layout.topSpaceToView(_topLineView,0)
    .leftSpaceToView(_rightlabel,0)
    .heightIs(58)
    .widthIs(KScreenWidth / 6);
    //_rightlabelnum.backgroundColor = [UIColor blueColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(rightTapGesture:)];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(rightTapGesture:)];
    [_rightlabel addGestureRecognizer:tap];
    [_rightlabelnum addGestureRecognizer:tap1];
    _rightlabel.userInteractionEnabled = YES;
    _rightlabelnum.userInteractionEnabled = YES;
}
/**
 *
 * 个人信息控件   姓名/昵称
 */
- (void)createnamelabel {
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.numberOfLines = 0;
    _nameLabel.textColor = ColorWithRGBA(48, 158, 234, 1);
    [_HeaderView addSubview:_nameLabel];
    _nameLabel.sd_layout.leftSpaceToView(_HeaderView,KScreenWidth / 10)
    .topSpaceToView(_HeaderView,44)
    .heightIs(40)
    .widthIs(200);
    _nameLabel.font = [UIFont systemFontOfSize:30];
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    _nameLabel.userInteractionEnabled = YES;
    
    //    _Loginbtn = [[UIButton alloc]initWithFrame:CGRectMake( KScreenWidth / 10, 44, 100, 40)];
    //
    //    [_Loginbtn setTitle:@"登 录" forState:UIControlStateNormal];
    //    _Loginbtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    //    [_Loginbtn.titleLabel setFont:[UIFont systemFontOfSize:30 weight:5]];
    //    [_Loginbtn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchDown];
    //    _Loginbtn.backgroundColor = [UIColor clearColor];
    //    [_HeaderView addSubview:_Loginbtn];
    
}

//  赚了多少钱
- (void)createmoneylabel {
    _moneyLabel = [[UILabel alloc]init];
    _moneyLabel.textAlignment = NSTextAlignmentLeft;
    _moneyLabel.numberOfLines = 0;
    
    _moneyLabel.textColor = ColorWithRGBA(21, 126, 205, 1);
    [_HeaderView addSubview:_moneyLabel];
    
    _moneyLabel.sd_layout.leftSpaceToView(_HeaderView,KScreenWidth / 10)
    .topSpaceToView(_HeaderView, 84)
    .heightIs(30)
    .widthIs(90);
    _moneyLabel.font = [UIFont systemFontOfSize:15];
}

//  头像
- (void)createicon {
    
    UIView *headerImageV = [[UIView alloc] init];
    headerImageV.backgroundColor = [UIColor clearColor];
    [_HeaderView addSubview:headerImageV];
    headerImageV.sd_layout.topSpaceToView(_HeaderView, 28)
    .rightSpaceToView(_HeaderView, KScreenWidth/10)
    .widthIs(KScreenWidth/4)
    .heightIs(KScreenWidth/4);
    
    //  -----
    _headerRing = [[UIImageView alloc] init];
    _headerRing.image = [UIImage imageNamed:@"header_ring_icon"];
    [_HeaderView addSubview:_headerRing];
    _headerRing.sd_layout.topSpaceToView(_HeaderView, 28)
    .rightSpaceToView(_HeaderView, KScreenWidth/10)
    .widthIs(KScreenWidth/4)
    .heightIs(KScreenWidth/4);
    
    
#warning 这里头像圆角有问题
    _icon = [[UIImageView alloc] init];
    _icon.height = _icon.width = KScreenWidth/5;
    _icon.layer.cornerRadius = _icon.width / 2;
    _icon.layer.masksToBounds = YES;
    _icon.contentMode = UIViewContentModeScaleAspectFill;
    _icon.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconTapGesture:)];
    [_icon addGestureRecognizer:tapGesture];
    
    [headerImageV addSubview:_icon];
    _icon.sd_layout.spaceToSuperView(UIEdgeInsetsMake(12, 12, 12, 12));
    
}


//  去炫耀
- (void)createsharelabel {
    
    _shareLabel = [[UILabel alloc] init];
    _shareLabel.text = @"去炫耀";
    _shareLabel.textColor = ColorWithRGBA(21, 126, 205, 1);
    _shareLabel.font = [UIFont systemFontOfSize:15];
    
    [_HeaderView addSubview:_shareLabel];
    _shareLabel.sd_layout.leftSpaceToView(_moneyLabel, 0)
    .topSpaceToView(_HeaderView, 84)
    .heightIs(30)
    .widthIs(50);
    
    UIButton *button = [[UIButton alloc] init];
    [button setBackgroundImage:[UIImage imageNamed:@"home_share"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"home_share"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(mineShareToFriends) forControlEvents:UIControlEventTouchUpInside];
    [_HeaderView addSubview:button];
    button.sd_layout.topSpaceToView(_HeaderView, 91)
    .leftSpaceToView(_shareLabel, 0)
    .widthIs(15)
    .heightIs(15);
    
}


//  line
- (void)createTopLine {
    
    _topLineView = [[UIView alloc]init];
    _topLineView.backgroundColor = ColorWithRGBA(46, 100, 152, 1);
    [_HeaderView addSubview:_topLineView];
    _topLineView.sd_layout.topSpaceToView(_headerRing, 20)
    .leftSpaceToView(_HeaderView, 0)
    .rightSpaceToView(_HeaderView, 0)
    .heightIs(1);
}


- (void)createBottomLine {
    
    _bottomLineView = [[UIView alloc]init];
    _bottomLineView.backgroundColor = ColorWithRGBA(46, 100, 152, 1);
    [_HeaderView addSubview:_bottomLineView];
    _bottomLineView.sd_layout.topSpaceToView(_leftlabel, -1)
    .leftSpaceToView(_HeaderView, 0)
    .rightSpaceToView(_HeaderView, 0)
    .heightIs(1);
}


#pragma mark - 分享给朋友
- (void)mineShareToFriends {
    
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

/**
 *  被赞数、关注数、粉丝数   触摸方法
 *
 *  @return
 */
- (void)leftTapGesture:(UIGestureRecognizer *)tapGesture {
    
    NSLog(@"左边的Label");
}

- (void)rightTapGesture:(UIGestureRecognizer *)tapGesture {
    
    NSLog(@"右边的Label");
}





/**
 *
 *  @param taps 点击头像按钮的时间
 */


- (void)iconTapGesture:(UIGestureRecognizer *)tapGesture {
    
    ZSMineInfoViewController *userCenter = [[ZSMineInfoViewController alloc] init];
    
    [self.navigationController pushViewController:userCenter animated:YES];
}


//- (void)click {
//
//    ZSLoginViewController *zslogin = [[ZSLoginViewController alloc]init];
//    [self.tabBarController addChildViewController:zslogin];
//    //[self presentViewController:zslogin animated:YES completion:nil];
//    //self.hidesBottomBarWhenPushed=YES;
//    [self.navigationController pushViewController:zslogin animated:YES];
//    //self.hidesBottomBarWhenPushed=NO;
//
//
//
//}

#pragma mark - 清理缓存

//  清理缓存
- (void)clearFile {
    NSString * cachPath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    
    NSArray * files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
    
    NSLog (@"cachpath = %@", cachPath);
    
    for (NSString *p in files) {
        
        NSError *error = nil ;
        
        NSString *path = [cachPath stringByAppendingPathComponent:p];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            
            [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
            
        }
    }
}

//  显示缓存大小
- (float)showFilePath {
    
    NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    
    return [self folderSizeAtPath:cachPath];
}

//  1.计算单个文件的大小
- (long long)fileSizeAtPath:(NSString *)filePath {
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:filePath]) {
        
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
//  2.遍历文件夹获得文件夹的大小
- (float)folderSizeAtPath:(NSString *)folderPath {
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    if (![manager fileExistsAtPath:folderPath]) return 0;
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator ];
    
    NSString * fileName;
    
    long long folderSize = 0;
    
    
    while ((fileName = [childFilesEnumerator nextObject ]) != nil ) {
        
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
        
    }
    
    return folderSize/(1024.0 * 1024.0);
}


//  认证工程师等级 方法
- (void)userGardeAuthButtonClick {
    
    ZSUserGardeAuthVc *userGardeAuth = [[ZSUserGardeAuthVc alloc] init];
    [self.navigationController pushViewController:userGardeAuth animated:YES];
    
    NSLog(@"认证工程师等级");
    
}


#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataList.count ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        return KScreenHeight *0.12;
    }else {
        return KScreenHeight *0.09;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataList[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *ID = @"mineCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.detailTextLabel.textColor = ColorWithRGBA(53, 189, 189, 1);
    }
    
    NSDictionary *dict = self.dataList[indexPath.section][indexPath.row];
    cell.textLabel.text = dict[@"title"];
    cell.textLabel.textColor = ColorWithRGBA(56, 160, 236, 1);
    cell.imageView.image = [UIImage imageNamed:dict[@"icon"]];
    
    if (indexPath.section == 0) {
        
        UIImageView *userGardeImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight *0.12)];
        userGardeImage.image = [UIImage imageNamed:@"mine_user_garde"];
        //        im.contentMode = UIViewContentModeScaleAspectFill;
        userGardeImage.userInteractionEnabled = YES;
        
        UIButton *button = [[UIButton alloc] init];
        [button setBackgroundImage:[UIImage imageNamed:@"mine_userGarde"] forState:UIControlStateNormal];
        [button setTitle:@"开通" forState:UIControlStateNormal];
        [button setTitleColor:ColorWithRGBA(59, 164, 240, 1) forState:UIControlStateNormal];
        [button addTarget:self action:@selector(userGardeAuthButtonClick) forControlEvents:UIControlEventTouchUpInside];
//        [button.layer setBorderWidth:1];//设置边框的宽度
//        //设置按钮的边框颜色
//        CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
//        CGColorRef color = CGColorCreate(colorSpaceRef, (CGFloat[]){0,1,1,0.6});
//        [button.layer setBorderColor:color];//边框颜色
        [userGardeImage addSubview:button];
        button.sd_layout.rightSpaceToView(userGardeImage, 30)
        .topSpaceToView(userGardeImage, KScreenHeight *0.12 /2 - 15)
        .widthIs(80)
        .heightIs(30);
        
        [cell addSubview:userGardeImage];
    } else {
        
        UIImageView *cellBackImg = [[UIImageView alloc] initWithFrame:cell.frame];
        cellBackImg.image = [UIImage imageNamed:@"mine_cell_backImg"];
        cellBackImg.contentMode = UIViewContentModeScaleToFill;
        
        cell.backgroundView = cellBackImg;
        NSDictionary *dict = self.dataList[indexPath.section][indexPath.row];
        cell.textLabel.text = dict[@"title"];
        cell.textLabel.textColor = ColorWithRGBA(56, 160, 236, 1);
        cell.imageView.image = [UIImage imageNamed:dict[@"icon"]];
    }
    
    switch (indexPath.section) {
        case 1:
            
//            if (indexPath.row == 0) {
                cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%@",_mymoney];
                cell.detailTextLabel.textColor = ColorWithRGBA(56, 160, 236, 1);
//            }
            //  身份认证
//            if (indexPath.row == 1) {
            
//                if (![_userAuthName isEqualToString:@"未认证"]) {
//                    
//                    cell.detailTextLabel.text = @"已认证";
//                    cell.detailTextLabel.textColor = ColorWithRGBA(56, 160, 236, 1);
//                }else {
//                    
//                    cell.detailTextLabel.text = @"未认证";
//                    cell.detailTextLabel.textColor = ColorWithRGBA(56, 160, 236, 1);
//                }
//            }
            break;
        case 2:
            //  身份认证
            if (indexPath.row == 0) {
                
                if (![_userAuthName isEqualToString:@"未认证"]) {

                    cell.detailTextLabel.text = @"已认证";
                    cell.detailTextLabel.textColor = ColorWithRGBA(56, 160, 236, 1);
                }else {

                    cell.detailTextLabel.text = @"未认证";
                    cell.detailTextLabel.textColor = ColorWithRGBA(56, 160, 236, 1);
                }
            }
            break;
        case 3:
            //  清理缓存
            if (indexPath.row == 0) {
                
                cell.textLabel.text = @"清除缓存";
                cell.textLabel.textColor = ColorWithRGBA(56, 160, 236, 1);
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f M", [self showFilePath]];
                cell.detailTextLabel.textColor = ColorWithRGBA(56, 160, 236, 1);
                
            }
            break;
            
        default:
            break;
    }
    
    cell.selected = YES;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.dataList[indexPath.section][indexPath.row][@"controller"]){
        
        UIViewController *vc = [[self.dataList[indexPath.section][indexPath.row][@"controller"] alloc] init];
        
        vc.title = self.dataList[indexPath.section][indexPath.row][@"title"];
        
        
        [self.navigationController pushViewController:vc animated:YES];
        
        //  清理缓存
    }else if (indexPath.section == 2 && indexPath.row == 0) {
        
        fileSize = [NSString stringWithFormat:@"%.2f M", [self showFilePath]];
                    
        if ([fileSize isEqualToString:@"0.00 M"]) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"暂无缓存" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            
        }else {
            
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"确定清除缓存吗?" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            //  创建一个取消和一个确定按钮
            UIAlertAction *actionCancle=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            //  因为需要点击确定按钮后改变文字的值，所以需要在确定按钮这个block里面进行相应的操作
            UIAlertAction *actionOk=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                
                //  清除缓存
                [self clearFile];
                
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
                [SVProgressHUD showSuccessWithStatus:@"清除成功"];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
                
            }];
            //将取消和确定按钮添加进弹框控制器
            [alert addAction:actionCancle];
            [alert addAction:actionOk];
            
            //显示弹框控制器
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
}


//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return !section ? 1 : CGFLOAT_MIN;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return 0.1;
    }else if (section == 1) {
        
        return 0.1f;
    }else {
        
        return 10.0f;
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

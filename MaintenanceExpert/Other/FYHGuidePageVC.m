//
//  FYHGuidePageVC.m
//  FYHScroViewLogDemo
//
//  Created by cyberzone on 16/4/27.
//  Copyright © 2016年 FYH. All rights reserved.
//

/*
    在此 VC 中,
        picArr 设置启动图样式,
        titleArr 设置 Btn 名字样式;
 */

#import "FYHGuidePageVC.h"
#import "ZSLoginLabelView.h"
#import "ZSLoginViewController.h"
#import "AppDelegate.h"

#define FRAME_SIZE self.view.frame.size



@interface FYHGuidePageVC () <UIScrollViewDelegate>
{
    UIButton *_btn;
    CAAnimationGroup *_groupAnimaL;
    CAAnimationGroup *_groupAnimaR;
    CAAnimationGroup *_groupAnimaS;
    ZSLoginLabelView *_label1;
    ZSLoginLabelView *_label2;

    UIImageView *_imagev;
}
@property (nonatomic, strong) UIScrollView      *scView;
@property (nonatomic, strong) UIImageView       *imgViewPic;
@property (nonatomic, strong) UIPageControl     *pageCon;

@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) NSString *pageType;



@end

@implementation FYHGuidePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.pageType = @"fyh";
    
    CABasicAnimation *actionL = [CABasicAnimation animation];
    actionL.keyPath = @"transform.translation.x";
    actionL.toValue = @(FRAME_SIZE.width);
    
    _groupAnimaL = [CAAnimationGroup animation];
    _groupAnimaL.animations = @[actionL];
    
    _groupAnimaL.duration = 0.3;
    _groupAnimaL.fillMode = kCAFillModeForwards;
    _groupAnimaL.removedOnCompletion = NO;
    _groupAnimaL.delegate = self;
    
    CABasicAnimation *actionR = [CABasicAnimation animation];
    actionR.keyPath = @"transform.translation.x";
    actionR.toValue = @(-FRAME_SIZE.width);
    
    _groupAnimaR = [CAAnimationGroup animation];
    _groupAnimaR.animations = @[actionR];
    
    _groupAnimaR.duration = 0.3;
    _groupAnimaR.fillMode = kCAFillModeForwards;
    _groupAnimaR.removedOnCompletion = NO;
    _groupAnimaR.delegate = self;
    
    CABasicAnimation *actionS = [CABasicAnimation animation];
    actionS.keyPath = @"opacity";
    actionS.autoreverses = YES;
    actionS.fromValue = [NSNumber numberWithFloat:1.0f];
    actionS.toValue = [NSNumber numberWithFloat:0.0f];
    actionS.removedOnCompletion = NO;

    _groupAnimaS = [CAAnimationGroup animation];
    _groupAnimaS.animations = @[actionS];
    
    _groupAnimaS.duration = 1.3;
    _groupAnimaS.fillMode = kCAFillModeForwards;
    _groupAnimaS.removedOnCompletion = NO;
    _groupAnimaS.delegate = self;
    _groupAnimaS.repeatCount = 50;
    //self.view.backgroundColor = [UIColor yellowColor];
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"loading1-bg"]];
   // self.view.contentMode = UIViewContentModeScaleAspectFill;
    UIImageView *imagev = [[UIImageView alloc]initWithFrame:self.view.frame];
    imagev.image =[UIImage imageNamed:@"loading1-bg"];
    [self.view addSubview:imagev];
    [self createScrollerView];
    [self createbl];
    [self createStar];
    
    [self createPageControl];
    NSLog(@"%f", FRAME_SIZE.width);
    NSLog(@"%f", FRAME_SIZE.height);
}

- (void)createbl {
    _btn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width / 4,KScreenHeight*0.6,self.view.frame.size.width / 2,40)];
    [_btn setBackgroundImage:[UIImage imageNamed:@"first_login_button"] forState:UIControlStateNormal];
    [_btn setTitle:@"立即体验" forState:UIControlStateNormal];
    [self.view addSubview:_btn];
    _btn.hidden = YES;
    [_btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addlabel1:@"专注于第三方服务" withlabel2:@"代表客户获得及时优质的服务质量\n代表工程师获得技能价值的回报"];
}
- (void)createStar {
    _imagev = [[UIImageView alloc]initWithFrame:CGRectMake(FRAME_SIZE.width *3 / 4 +20, 100, 20, 20)];
    _imagev.image = [UIImage imageNamed:@"star-1"];
    [self.view addSubview:_imagev];
    [_imagev.layer addAnimation:_groupAnimaS forKey:nil];
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(FRAME_SIZE.width / 2 - 20, 50, 10, 10)];
    image.image = [UIImage imageNamed:@"star-4"];
    [self.view addSubview:image];
    _groupAnimaS.duration = 1.7;
    [image.layer addAnimation:_groupAnimaS forKey:nil];
    
    UIImageView *image1 = [[UIImageView alloc]initWithFrame:CGRectMake( 50, 150, 5, 5)];
    image1.image = [UIImage imageNamed:@"star-4"];
    [self.view addSubview:image1];
    _groupAnimaS.duration = 1;
    [image1.layer addAnimation:_groupAnimaS forKey:nil];
    
    UIImageView *image2 = [[UIImageView alloc]initWithFrame:CGRectMake( FRAME_SIZE.width *3 / 4 , 400, 15, 15)];
    // _imagev.backgroundColor = [UIColor whiteColor];
    image2.image = [UIImage imageNamed:@"star-4"];
    [self.view addSubview:image2];
    _groupAnimaS.duration = 1;
    [image2.layer addAnimation:_groupAnimaS forKey:nil];
}

- (void)addlabel1:(NSString *)string1 withlabel2:(NSString *)string2{
    
    _label1 = [[ZSLoginLabelView alloc]initWithFrame:CGRectMake(-FRAME_SIZE.width, KScreenHeight*0.71, FRAME_SIZE.width, 50)];
    [_label1.layer addAnimation:_groupAnimaL forKey:nil];
    [self.view addSubview:_label1];
    _label1.text = string1;
    _label1.font = [UIFont fontWithName:@"PingFangSC-Light" size:25];
    _label2 = [[ZSLoginLabelView alloc]initWithFrame:CGRectMake(FRAME_SIZE.width, KScreenHeight*0.78, FRAME_SIZE.width, 100)];
    [_label2.layer addAnimation:_groupAnimaR forKey:nil];
    [self.view addSubview:_label2];
    _label2.text = string2;
    // 调整行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineSpacing = 6;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont fontWithName:@"BodoniOrnamentsITCTT" size:25], NSParagraphStyleAttributeName:paragraphStyle};
    _label2.attributedText = [[NSAttributedString alloc]initWithString:_label2.text attributes:attributes];
    _label2.numberOfLines = 3;
    _label2.font = [UIFont fontWithName:@"Symbol" size:14];

    
}


#pragma mark - 外部设置启动图 Arr 对应方法
- (void)fyhGuidePageWithPicArr:(NSMutableArray *)picArr {
    self.picArr = picArr;
}

#pragma mark - 创建 VC
+ (instancetype)sharedGuideVC {
    static FYHGuidePageVC *guidePageVC = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        guidePageVC = [[FYHGuidePageVC alloc] init];
    });
    return guidePageVC;
}
#pragma mark - ScrollerViewSomethings
- (void)createScrollerView {
    
    //self.scView = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.scView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.scView.delegate = self;//Delegate
    [self.view addSubview:self.scView];
    self.scView.contentSize = CGSizeMake(3 * FRAME_SIZE.width, FRAME_SIZE.width);
    self.scView.alpha = 1.0f;
    self.scView.pagingEnabled = YES;
    self.scView.bounces = NO;
    self.scView.showsHorizontalScrollIndicator = NO;
    
    //创建 imageView
    for (int i = 1; i <= self.picArr.count; i++) {
        self.imgViewPic = [[UIImageView alloc] initWithFrame:CGRectMake(FRAME_SIZE.width * (i - 1), 0, FRAME_SIZE.width, FRAME_SIZE.height)];
        self.imgViewPic.image = [self.picArr objectAtIndex:i - 1];//pic
        self.imgViewPic.tag = 100 + i;//tag
        self.imgViewPic.contentMode = UIViewContentModeScaleAspectFill;
        [self.scView addSubview:self.imgViewPic];
        
    }
    
    
}
#pragma mark - PageControl
- (void)createPageControl {
    self.pageCon = [[UIPageControl alloc] initWithFrame:CGRectMake((FRAME_SIZE.width - 40) / 2, FRAME_SIZE.height - 50, 40, 20)];
    self.pageCon.numberOfPages = 3;
    self.pageCon.currentPageIndicatorTintColor = [UIColor colorWithRed:51.0/255.0 green:101.0/255.0 blue:226.0/255.0 alpha:1];//IndexBgColor
    self.pageCon.pageIndicatorTintColor = [UIColor whiteColor];//BgColor
    [self.view addSubview:self.pageCon];
}
#pragma mark - 相关方法
/** ScrollView 协议方法相关*/
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    

    self.pageCon.currentPage = self.scView.contentOffset.x / FRAME_SIZE.width;\
    //NSLog(@"pageCon.currentPage --- %d", self.pageCon.currentPage);
    
    
    //NSTimer *myTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(scrollTimer) userInfo:nil repeats:YES];
    
    if (self.pageCon.currentPage == 2){
        _btn.hidden = NO;
        _label1.hidden = YES;
        _label2.hidden = YES;
        [self addlabel1:@"快捷 专业" withlabel2:@"弱电智能化维修安装平台\n在线下单轻松跨省市维修安装"];
    }else if (self.pageCon.currentPage == 1){
        _label1.hidden = YES;
        _label2.hidden = YES;
        [self addlabel1:@"异地下单 方便快捷" withlabel2:@"抛开拆了烦恼\n节省交通费用\n摆脱地域限制"];
        _btn.hidden = YES;
    }else{
        _btn.hidden = YES;
        _label1.hidden = YES;
        _label2.hidden = YES;
        [self addlabel1:@"专注于第三方服务" withlabel2:@"代表客户获得及时优质的服务质量\n代表工程师获得技能价值的回报"];
    }
    

    // NSTimer *myTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(scrollTimer:) userInfo:nil repeats:NO];
 
}


///** Btn 点击事件*/
- (void)btnClick {
    
    [self presentViewController:[[ZSLoginViewController alloc]init] animated:YES completion:^{
               
    }];
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

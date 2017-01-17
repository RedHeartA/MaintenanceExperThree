//
//  OneViewController.m
//  XWPopMenuVCDemo
//
//  Created by koka on 16/10/18.
//  Copyright © 2016年 ZSYW. All rights reserved.
//
/**
 *  这是详细下单页面
 *
 */

#import "OneViewController.h"
#import "myimgeview.h"
#import "Stepfirst.h"
#import "ZSDetailOrderModel.h"
#import "CLRotationView.h"

@interface OneViewController ()<OrderButtonClickDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_detailArray;
    NSMutableArray *_textArray;
    NSMutableArray *_IIArray;
    UIImageView *_backimageview;
    UIImageView *_imageview;
    UITableView *_tableview;
    NSMutableArray *_detailarray;
    
    UIButton *_cancelBtn;
    
    NSMutableArray *_ILabelarray;
    UILabel *_label;
    
}

@property (nonatomic , strong) UIButton *button;
@property (nonatomic , strong) CLRotationView *romate ;
@property (nonatomic , strong) NSMutableArray *datasource ;
@end


@implementation OneViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    self.view.backgroundColor = ViewController_Back_Color;
    
    _textArray = [NSMutableArray array];
    _textArray = [ZSDetailOrderModel shareDetailOrder].FirstMU;
    
    _IIArray = [NSMutableArray array];
    _IIArray = [ZSDetailOrderModel shareDetailOrder].SecondMu;
    
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
   // 自定义返回按钮
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(Clickup:) forControlEvents:UIControlEventTouchUpInside];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    /**
     初始化数组二级数据
     */
    
    
#warning 加载网络问题先判断数组为nil

    
    _backimageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"OrderBackBig"]];
    _backimageview.frame = CGRectMake(0, KScreenHeight/5, KScreenWidth, KScreenWidth);
    
    CABasicAnimation *basicAnimation1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    basicAnimation1.fromValue = @(2*M_PI);
    basicAnimation1.toValue = @0;
    basicAnimation1.duration = 15;
    basicAnimation1.repeatCount = 20;
    basicAnimation1.removedOnCompletion = NO;
    basicAnimation1.fillMode = kCAFillModeBoth;
    [_backimageview.layer addAnimation:basicAnimation1 forKey:@"rotation"];
    
    [self.view addSubview:_backimageview];
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth/2, KScreenHeight*2/3, KScreenWidth/2,  KScreenHeight/3)];
    image.image = [UIImage imageNamed:@"anbao_dabai"];
    [self.view addSubview:image];
    
    
       //添加取消按钮->
    [self addCancelBtn];
    [self setNeedsStatusBarAppearanceUpdate];
    [self createyuanpan];
    
}

- (void)createyuanpan {
    _imageview = [[UIImageView alloc]initWithFrame:CGRectMake(250,70, KScreenWidth/4, 177)];
    _imageview.image = [UIImage imageNamed:@"anfang"];
    
    
    [self.view addSubview:_imageview];
    
    // 自定义的转盘视图
    CLRotationView *romate = [[CLRotationView alloc]initWithFrame:CGRectMake(0 , 55, 200, 200)];
    // romate.center = self.view.center;
    self.romate = romate;
    //romate.layer.contents = (__bridge id)[UIImage imageNamed:@"anbao_yuan-"].CGImage;
    romate.delegate = self;
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0 , 40, 220, 220)];
    imageview.image = [UIImage imageNamed:@"anbao_yuan-"];
    [self.view addSubview:imageview];
    NSMutableArray *titleArray = [NSMutableArray new];
    
    //_ILabelarray = _textArray;
    _ILabelarray = [NSMutableArray arrayWithObjects:@"安防系统",@"UPS系统",@"音视频系统",@"LED系统",@"敬请期待",nil];
    _label = [[UILabel alloc]initWithFrame:CGRectMake(10, 80+55, 200, 40)];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.textColor = ColorWithRGBA(133, 201, 246, 1);
    _label.text =[NSString stringWithFormat:@"%@",_ILabelarray[0]];
    [self.view addSubview:_label];
    NSMutableArray *imageArray = [NSMutableArray arrayWithObjects:@"yuan-anfnag",@"yuan-ups",@"yuan-yinpin",@"yuan_LED",@"daiding", nil];
    
    
    
    titleArray = [NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"",nil];
    [romate BtnType:CL_RoundviewTypeCustom BtnWidth:80 adjustsFontSizesTowidth:YES masksToBounds:YES conrenrRadius:40 image:imageArray TitileArray:titleArray titileColor:[UIColor blackColor]];
    
    [self.view addSubview:romate];
    [self createtableview];
}
- (void)changeIlevelbtntag:(NSInteger *)tag{
    NSLog(@"%ld",(long)tag);
//    switch ((long)tag) {
//        case 0:
//            _imageview.image = [UIImage imageNamed:@"anfang"];
//            _detailarray = [NSMutableArray arrayWithArray:_IIArray[0]];
//            break;
//        case 1:
//            _imageview.image = [UIImage imageNamed:@"UPS"];
//            _detailarray = [NSMutableArray arrayWithArray:_IIArray[1]];
//            break;
//        case 2:
//            _imageview.image = [UIImage imageNamed:@"yinpin"];
//            _detailarray = [NSMutableArray arrayWithArray:_IIArray[2]];
//            break;
//        case 3:
//            _imageview.image = [UIImage imageNamed:@"LEd"];
//            _detailarray = [NSMutableArray arrayWithArray:_IIArray[3]];
//            break;
//        case 4:
//            _imageview.image = [UIImage imageNamed:@"UPS"];
//            _detailarray = [NSMutableArray arrayWithArray:_IIArray[4]];
//            break;
//        default:
//            break;
//    }
    NSMutableArray *array0 = [[NSMutableArray alloc]initWithObjects:@"闭门监控系统",@"防盗报警系统",@"门禁管理系统",@"停车场管理系统",@"电子巡更系统", nil];
    NSMutableArray *array1 = [[NSMutableArray alloc]initWithObjects:@"UPS主机电池安装",@"UPS更换电池",@"UPS系统维护", nil];
    NSMutableArray *array2 = [[NSMutableArray alloc]initWithObjects:@"音视频系统",@"多媒体投影系统",@"会议系统",@"舞台幕布系统",@"智能灯光系统", nil];
    NSMutableArray *array3 = [[NSMutableArray alloc]initWithObjects:@"立柱屏安装维护",@"室外挂墙屏安装维护",@"室内挂墙屏安装维护", nil];
    NSMutableArray *array4 = [[NSMutableArray alloc]initWithObjects:@"敬请期待", nil];
    switch ((long)tag) {
        case 0:
            _imageview.image = [UIImage imageNamed:@"anfang"];
            _detailarray = [NSMutableArray arrayWithArray:array0];
            break;
        case 1:
            _imageview.image = [UIImage imageNamed:@"UPS"];
            _detailarray = [NSMutableArray arrayWithArray:array1];
            break;
        case 2:
            _imageview.image = [UIImage imageNamed:@"yinpin"];
            _detailarray = [NSMutableArray arrayWithArray:array2];
            break;
        case 3:
            _imageview.image = [UIImage imageNamed:@"LEd"];
            _detailarray = [NSMutableArray arrayWithArray:array3];
            break;
        case 4:
            _imageview.image = [UIImage imageNamed:@"qidai"];
            _detailarray = [NSMutableArray arrayWithArray:array4];
            break;
        default:
            break;
    }

    _label.text =[NSString stringWithFormat:@"%@",_ILabelarray[(long)tag]];
    [_tableview reloadData];

    [self adddonghua];
}
- (void)adddonghua{
    
    CABasicAnimation *a1 = [CABasicAnimation animation];
    a1.keyPath = @"transform.translation.x";
    a1.fromValue = @(KScreenWidth/3 -50 + KScreenWidth*2/3);
    a1.toValue = @(0);
    CAAnimationGroup *groupAnima = [CAAnimationGroup animation];
    groupAnima.animations = @[a1];
    groupAnima.duration = 0.8;
    groupAnima.fillMode = kCAFillModeForwards;
    groupAnima.removedOnCompletion = NO;
    groupAnima.delegate = self;
    [_tableview.layer addAnimation:groupAnima forKey:nil];

}
- (void)createtableview{
    
    _detailarray = [[NSMutableArray alloc]initWithObjects:@"闭门监控系统",@"防盗报警系统",@"门禁管理系统",@"停车场管理系统",@"电子巡更系统", nil];
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(KScreenWidth/3 -50, 300, KScreenWidth*2/3, 300) style:UITableViewStyleGrouped];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.bounces = NO;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableview];
    [self adddonghua];
    [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _detailarray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 7.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",_detailarray[indexPath.section]];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.textColor = ColorWithRGBA(131, 199, 245, 1);
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:cell.frame];
    imageview.image = [UIImage imageNamed:@"bilu-list"];
    cell.backgroundView = imageview;
    
    UIImageView *imageview1 = [[UIImageView alloc]initWithFrame:cell.frame];
    imageview1.image = [UIImage imageNamed:@"bilu-next-"];
    
    cell.selectedBackgroundView = imageview1;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];// 取消选中
    //其他代码
    [ZSDetailOrderModel shareDetailOrder].NavTitle = _detailarray[indexPath.section];
    
    NSString *urlstring = @OrderChangedKeyURL;
    NSDictionary *dict =@{
                          @"catid":@"2",
                          };
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manage POST:urlstring parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        
        
        //NSLog(@"====%@",dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //NSLog(@"%@",error);
    }];

   
    [self pushToView];
}

- (void)initArray {
    
    NSLog(@"%@",_IIArray);
    NSMutableArray *arrII = [NSMutableArray array];
    for (int i =0; i<_IIArray.count; i++) {
        NSMutableArray *arraa = [NSMutableArray array];
        for (NSDictionary *dicc in _IIArray[i]) {
            NSString *string = [dicc objectForKey:@"name"];
            [arraa addObject:string];
        }
        [arrII addObject:arraa];
    }
//    NSLog(@"=%@",arrII);
    _detailArray = [NSMutableArray array];
    
    for (int i =0; i<_IIArray.count; i++) {
        
        NSMutableArray *array = [NSMutableArray arrayWithArray:arrII[i]];
        [_detailArray addObject:array];
    }
   // NSLog(@"_detailArray=%@",_detailArray);
//    NSMutableArray *array0 = [[NSMutableArray alloc]initWithObjects:@"闭门监控系统",@"防盗报警系统",@"门禁管理系统",@"停车场管理系统",@"电子巡更系统", nil];
//    NSMutableArray *array1 = [[NSMutableArray alloc]initWithObjects:@"UPS主机电池安装",@"UPS更换电池",@"UPS系统维护", nil];
//    NSMutableArray *array2 = [[NSMutableArray alloc]initWithObjects:@"音视频系统",@"多媒体投影系统",@"会议系统",@"舞台幕布系统",@"智能灯光系统", nil];
//    NSMutableArray *array3 = [[NSMutableArray alloc]initWithObjects:@"立柱屏安装维护",@"室外挂墙屏安装维护",@"室内挂墙屏安装维护", nil];
//    
//    _detailArray = [[NSMutableArray alloc]initWithObjects:array0,array1,array2,array3, nil];
}

/**
 *   根据1级按钮的tag值判定二级选项
 *   一级按钮tag 1000 1001 1002 1003 1004
 *   二级按钮tag 2 3 4 。。。取消按钮为0
 *  @param tag
 **/

- (void)pushToView {
    
    Stepfirst *first = [[Stepfirst alloc]init];
    [self.navigationController pushViewController:first animated:YES];

}




//添加取消按钮->
-(void)addCancelBtn{
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_cancelBtn setFrame:CGRectMake(KScreenWidth / 3 -50, KScreenHeight - 50 , KScreenWidth*2/3, 50)];
    [_cancelBtn setTitle:@"取   消" forState:UIControlStateNormal];
    //_cancelBtn.titleLabel.textColor = ColorWithRGBA(131, 199, 245, 1);
    _cancelBtn.tintColor = ColorWithRGBA(131, 199, 245, 1);
    [_cancelBtn setBackgroundImage:[UIImage imageNamed:@"bilu-list"] forState:UIControlStateNormal];
    [_cancelBtn setBackgroundImage:[UIImage imageNamed:@"bilu-next-"] forState:UIControlStateSelected];
    _cancelBtn.layer.cornerRadius = 10;
    [self.view addSubview:_cancelBtn];
    
    [_cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
}

//取消按钮点击方法
-(void)cancelClick{
    [self finishPublish];
}


#pragma mark - 完成发布
//完成发布
-(void)finishPublish{
    //2.block传值
    if (self.mDismissBlock != nil) {
        self.mDismissBlock();
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
//block声明方法
-(void)toDissmissSelf:(dismissBlock)block{
    self.mDismissBlock = block;
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

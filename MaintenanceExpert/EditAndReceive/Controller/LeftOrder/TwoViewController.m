//
//  TwoViewController.m
//  XWPopMenuVCDemo
//
//  Created by xpc on 16/10/18.
//  Copyright © 2016年 ZSYW. All rights reserved.
//
/*
 这是快捷下单页面
 */
#import "TwoViewController.h"
#import "TZTestCell.h"
#import "TwoDetailsViewController.h"

#import "ZSDetailOrderModel.h"

#import "TZImagePickerController.h"
#import "UIView+Layout.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "LxGridViewFlowLayout.h"
#import "TZImageManager.h"
#import "TZVideoPlayerController.h"


#import "TwoPayTypeViewController.h"


#define HEADERIMG_HEIGHT 64
#define SHOW_IMAGE_COUNT 4


typedef enum{
    ZHProgressModeText = 0,           //文字
    ZHProgressModeLoading,              //加载菊花
    ZHProgressModeGIF,            //加载动画
    ZHProgressModeSuccess               //成功
    
}ZHProgressMode;

@interface TwoViewController ()<TZImagePickerControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIAlertViewDelegate, UIActionSheetDelegate, UITextViewDelegate,UITextFieldDelegate>

{
    UIImageView *headerImg; //  NavigationView
    UIView *upView;
    UIView *midUpView;
    UIView *midDownView;
    UIView *downView;       //
    UILabel *_descriptLabel; //  描述
    UIView *_slideBackView;  //  滑动按钮View
    UILabel *_prace;         //  价格 Cell
    
    BOOL _isSelectOriginalPhoto;
    
    CGFloat _itemWH;
    CGFloat _margin;
    
    UIImageView *_animationBackImage;
    UIImageView *_priceBackImage;
    
}

//字数的限制
//@property (nonatomic, strong)UILabel *wordCountLabel;

@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property (nonatomic, strong) UICollectionView *collectionView;

// 6个设置开关
// UISwitch *showTakePhotoBtnSwitch;  ///< 在内部显示拍照按钮
// UISwitch *sortAscendingSwitch;     ///< 照片排列按修改时间升序
// UISwitch *allowPickingVideoSwitch; ///< 允许选择视频
// UISwitch *allowPickingImageSwitch; ///< 允许选择图片
// UISwitch *allowPickingOriginalPhotoSwitch; ///< 允许选择原图
// UISwitch *showSheetSwitch; ///< 显示一个sheet,把拍照按钮放在外
// UITextField *maxCountTF; ///< 照片最大可选张数，设置为1即为单选
// UITextField *columnNumberTF;

@end

@implementation TwoViewController


- (void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    self.navigationController.navigationBarHidden = YES;
}

//  提示 弹出框
- (instancetype)shareinstance{
    
    static TwoViewController *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[TwoViewController alloc] init];
    });
    
    return instance;
    
}

//  懒加载 (选择照片)
- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        _imagePickerVc.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        _imagePickerVc.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (iOS9Later) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
#pragma clang diagnostic pop
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    return _imagePickerVc;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ColorWithRGBA(23, 53, 86, 1);
    
    //  点击任意地方收起键盘 1/3
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    self.title = @"拍照下单";
    
    _selectedPhotos = [NSMutableArray array];
    _selectedAssets = [NSMutableArray array];
    
    
    [self creatBakeWhiteColor];
    
    [self creatUpView];             //  自定义的NavigationView
    [self creatPosition];           //  添加地理位置
    [self configCollectionView];    //  添加图片、视频
    [self creatSlider];             //  添加滑动条
    [self creatPrice];              //  添加价格
    [self creatMaintain];           //  添加维修按钮(分类)
    [self creatButton];             //  添加确定下单按钮
    
    _animationBackImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"OrderBackBig"]];
    _animationBackImage.frame = CGRectMake(0, KScreenHeight/5 -64, KScreenWidth, KScreenWidth);
    
    CABasicAnimation *basicAnimation1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    basicAnimation1.fromValue = @(2*M_PI);
    basicAnimation1.toValue = @0;
    basicAnimation1.duration = 15;
    basicAnimation1.repeatCount = 20;
    basicAnimation1.removedOnCompletion = NO;
    basicAnimation1.fillMode = kCAFillModeBoth;
    [_animationBackImage.layer addAnimation:basicAnimation1 forKey:@"rotation"];
    
    [self.view addSubview:_animationBackImage];
    
    //  添加取消按钮->更改原生leftBarButtonItem
    [self addCancelBtn];
    
    /**
     http://blog.csdn.net/xuejunrong/article/details/50038999
     */
#pragma mark - 点击任意地方收起键盘 2/3   和选择照片 有冲突
    //    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBG:)];
    //    [self.view addGestureRecognizer:tapGesture];
    
}

//  隐藏状态栏
- (BOOL)prefersStatusBarHidden {
    return NO;
}


#pragma mark - 添加控件

//  上、中、下 三块白色的背景
- (void)creatBakeWhiteColor {
    
    //  标题、描述、地址
    upView = [[UIView alloc] init];
    upView.backgroundColor = ViewController_Back_Color;
    [self.view addSubview:upView];
    upView.sd_layout.leftSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .heightIs(KScreenHeight * 0.3);
    
    //  图片、视频
    midUpView = [[UIView alloc] init];
    midUpView.backgroundColor = ViewController_Back_Color;
    [self.view addSubview:midUpView];
    midUpView.sd_layout.leftSpaceToView(self.view, 0)
    .topSpaceToView(upView, 10)
    .rightSpaceToView(self.view, 0)
    .heightIs(KScreenHeight * 0.17);
    
    //  slider、价格、类型
    midDownView = [[UIView alloc] init];
    midDownView.backgroundColor = ViewController_Back_Color;
    [self.view addSubview:midDownView];
    midDownView.sd_layout.leftEqualToView(upView)
    .topSpaceToView(midUpView, 10)
    .rightEqualToView(upView)
    .heightIs(KScreenHeight * 0.27);
    
    //  确定发布按钮
    downView = [[UIView alloc] init];
    downView.backgroundColor = ViewController_Back_Color;
    [self.view addSubview:downView];
    downView.sd_layout.leftEqualToView(midDownView)
    .rightEqualToView(midDownView)
    .bottomSpaceToView(self.view, 0)
    .topSpaceToView(midDownView, 0);
    
}

//  Navigation、标题、描述
- (void)creatUpView {
    
    //  标题
    _titleTF = [[UITextField alloc] init];
    _titleTF.textColor = TextField_Text_Color;
    NSString *titleStr = @"请输入标题";
    NSMutableAttributedString *placeholderTitle = [[NSMutableAttributedString alloc]initWithString:titleStr];
    [placeholderTitle addAttribute:NSForegroundColorAttributeName
                         value:Placeholder_Color
                         range:NSMakeRange(0, titleStr.length)];
    _titleTF.attributedPlaceholder = placeholderTitle;
    _titleTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_titleTF setFont:[UIFont systemFontOfSize:15]];
    _titleTF.returnKeyType = UIReturnKeyDone;
    _titleTF.delegate = self;
    [upView addSubview:_titleTF];
    _titleTF.sd_layout.leftSpaceToView(upView, 10)
    .topSpaceToView(upView, 3)
    .rightSpaceToView(upView, 20)
    .heightIs(upView.frame.size.height * 0.19);
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = Line_Color;
    [upView addSubview:lineView];
    lineView.sd_layout.leftEqualToView(_titleTF)
    .topSpaceToView(_titleTF, 3)
    .rightSpaceToView(upView, 0)
    .heightIs(1);
    
    //  描 述
    _descriptTV = [[UITextView alloc] init];
    _descriptTV.textColor = TextField_Text_Color;
    _descriptTV.backgroundColor = ViewController_Back_Color;
    _descriptTV.returnKeyType = UIReturnKeyDone;
    _descriptTV.delegate = self;
    _descriptTV.editable = YES;
    _descriptTV.layer.cornerRadius = 4.0f;
    _descriptTV.layer.borderColor = Label_Color.CGColor;
    _descriptTV.layer.borderWidth = 0.5;
    [_descriptTV setFont:[UIFont systemFontOfSize:15]];
    [upView addSubview:_descriptTV];
    _descriptTV.sd_layout.leftSpaceToView(upView, 9)
    .topSpaceToView(lineView, 5)
    .rightSpaceToView (upView, 10)
    .heightIs(upView.frame.size.height * 0.53);
    
    _descriptLabel = [[UILabel alloc] init];
    _descriptLabel.text = @" 请详细描述一下您的需求";
    _descriptLabel.textColor = Placeholder_Color;
    _descriptLabel.font = [UIFont systemFontOfSize:15];
    [_descriptTV addSubview:_descriptLabel];
    _descriptLabel.sd_layout.leftSpaceToView(_descriptTV, 5)
    .topSpaceToView(_descriptTV, 2)
    .rightSpaceToView(_descriptTV, 5)
    .heightIs(30);
    
}

//  添加 地理位置
- (void)creatPosition {
    
    _addressTF = [[UITextField alloc] init];
    _addressTF.textColor = TextField_Text_Color;
    NSString *addressStr = @"请输入省市区街道，以及具体位置";
    NSMutableAttributedString *placeholderAddress = [[NSMutableAttributedString alloc]initWithString:addressStr];
    [placeholderAddress addAttribute:NSForegroundColorAttributeName
                               value:Placeholder_Color
                               range:NSMakeRange(0, addressStr.length)];
    _addressTF.attributedPlaceholder = placeholderAddress;
    _addressTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_addressTF setFont:[UIFont systemFontOfSize:14]];
    _addressTF.returnKeyType = UIReturnKeyDone;
    _addressTF.delegate = self;
    [upView addSubview:_addressTF];
    _addressTF.sd_layout.leftEqualToView(_titleTF)
    .bottomSpaceToView(upView, 5)
    .rightEqualToView(_titleTF)
    .heightIs(upView.frame.size.height * 0.2);
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = Line_Color;
    [upView addSubview:lineView];
    lineView.sd_layout.leftEqualToView(_titleTF)
    .rightSpaceToView(upView, 0)
    .bottomSpaceToView(upView, 5)
    .heightIs(1);
}
//  添加 图片、视频
- (void)configCollectionView {
    
    // 如不需要长按排序效果，将LxGridViewFlowLayout类改成UICollectionViewFlowLayout即可
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //  横向滚动
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    _margin = 10;
    _itemWH = (KScreenWidth - 2 * _margin - 10)/4 - _margin;
    layout.itemSize = CGSizeMake(_itemWH, _itemWH);
    layout.minimumInteritemSpacing = _margin;
    layout.minimumLineSpacing = _margin;
    
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, _itemWH + _margin * 2) collectionViewLayout:layout];
    _collectionView.alwaysBounceVertical = NO;     //  垂直的弹跳
    _collectionView.backgroundColor = ViewController_Back_Color;
    _collectionView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    //    _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [midUpView addSubview:_collectionView];
    
    [_collectionView registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];
    
    //  选择照片 提示
    UILabel *label = [[UILabel alloc] init];
    label.text = @"请选择上传的图片或者视频(选填)";
    label.textColor = ColorWithRGBA(49, 180, 220, 1);
    label.font = [UIFont systemFontOfSize:12];
    [midUpView addSubview:label];
    label.sd_layout.leftEqualToView(_titleTF)
    .rightEqualToView(_titleTF)
    .topSpaceToView(_collectionView, 0)
    .heightIs(15);
    
}

//  slider 横线
- (void)creatSlider {
    
    _slideBackView = [[UIView alloc] init];
    [midDownView addSubview:_slideBackView];
    _slideBackView.sd_layout.leftEqualToView(_titleTF)
    .topSpaceToView(midDownView, 10)
    .rightEqualToView(_titleTF)
    .heightRatioToView(midDownView, 0.45);
    
    CGRect fram = CGRectMake(20, 5, KScreenWidth - 80, self.view.frame.size.height);
    NSArray *array = [NSArray arrayWithObjects:@"一口价",@"待技术勘察",@"待协商", nil];
    
    _filter = [[ZSFitterControl alloc] initWithFrame:fram Titles:array];
    //    _filter.centerY = slideBackView.centerY;
    [_filter addTarget:self action:@selector(filterValueChanged:) forControlEvents:UIControlEventTouchUpInside];
    [_filter setProgressColor:ColorWithRGBA(48, 158, 220, 1)];   //设置滑杆的颜色
    [_filter setTopTitlesColor:ColorWithRGBA(80, 150, 260, 1)];  //设置滑块上方字体颜色
    [_filter setSelectedIndex:0];   //设置当前选中
    [_slideBackView addSubview:_filter];
    
//    UIView *line = [[UIView alloc] init];
//    line.backgroundColor = ColorWithRGBA(40, 140, 190, 1);
//    [midDownView addSubview:line];
//    line.sd_layout.leftSpaceToView(midDownView, 0)
//    .topSpaceToView(slideBackView, 0)
//    .rightSpaceToView(midDownView, 0)
//    .heightIs(1);
}

//  价格 横线
- (void)creatPrice {
    
    _priceBackImage = [[UIImageView alloc] init];
    _priceBackImage.userInteractionEnabled = YES;
    _priceBackImage.contentMode = UIViewContentModeScaleAspectFit;
    _priceBackImage.image = [UIImage imageNamed:@"price_back_img"];
    [midDownView addSubview:_priceBackImage];
    _priceBackImage.sd_layout.leftSpaceToView(midDownView, 0)
    .topSpaceToView(_slideBackView, 0)
    .rightSpaceToView(midDownView, 0)
    .heightRatioToView(midDownView, 0.25);
    
    _prace = [[UILabel alloc] init];
    _prace.text = @"价格";
    [_prace setFont:[UIFont systemFontOfSize:15]];
    _prace.textColor = Label_Color;
    [_priceBackImage addSubview:_prace];
    _prace.sd_layout.leftSpaceToView(_priceBackImage, 10)
    .topSpaceToView(_priceBackImage, 0)
    .widthRatioToView(midDownView, 0.2)
    .heightRatioToView(midDownView, 0.25);
    
    _priceTF = [[UITextField alloc] init];
    _priceTF.returnKeyType = UIReturnKeyDone;
    _priceTF.delegate = self;
    NSString *priceStr = @"请输入价格";
    NSMutableAttributedString *placeholderPrice = [[NSMutableAttributedString alloc]initWithString:priceStr];
    [placeholderPrice addAttribute:NSForegroundColorAttributeName
                               value:Placeholder_Color
                               range:NSMakeRange(0, priceStr.length)];
    _priceTF.attributedPlaceholder = placeholderPrice;
//    _priceTF.keyboardType = UIKeyboardTypeNumberPad;
    _priceTF.returnKeyType = UIReturnKeyDone;
    [_priceTF setFont:[UIFont systemFontOfSize:15]];
    _priceTF.textColor = TextField_Text_Color;
    [_priceBackImage addSubview:_priceTF];
    _priceTF.sd_layout.rightSpaceToView(_priceBackImage, 10)
    .topSpaceToView(_priceBackImage, 0)
    .widthIs(130)
    .heightRatioToView(midDownView, 0.25);
    
}

//  分类（ 维护Maintain、安装Install ）
//  维护 按钮
- (void)creatMaintain {
    
    UIImageView *typeBackImage = [[UIImageView alloc] init];
    typeBackImage.userInteractionEnabled = YES;
    typeBackImage.contentMode = UIViewContentModeScaleAspectFit;
    typeBackImage.image = [UIImage imageNamed:@"price_back_img"];
    [midDownView addSubview:typeBackImage];
    typeBackImage.sd_layout.leftSpaceToView(midDownView, 0)
    .bottomSpaceToView(midDownView, 0)
    .rightSpaceToView(midDownView, 0)
    .heightRatioToView(midDownView, 0.25);
    
    UILabel *type = [[UILabel alloc] init];
    type.text = @"分类";
    [type setFont:[UIFont systemFontOfSize:15]];
    type.textColor = Label_Color;
    [typeBackImage addSubview:type];
    type.sd_layout.leftSpaceToView(typeBackImage, 10)
    .topSpaceToView(typeBackImage, 0)
    .widthRatioToView(midDownView, 0.2)
    .heightRatioToView(midDownView, 0.25);
    
    
    NSArray *array = [[NSArray alloc]initWithObjects:@"维修",@"安装", nil];
    UISegmentedControl *segmentcontrol = [[UISegmentedControl alloc]initWithItems:array];
    segmentcontrol.backgroundColor = [UIColor clearColor];
    segmentcontrol.layer.cornerRadius = 3;
    segmentcontrol.selectedSegmentIndex = 0;
    segmentcontrol.tintColor = ColorWithRGBA(69, 173, 232, 1);
    
    //        // 在指定索引插入一个选项并设置图片
    //        [segmentcontrol insertSegmentWithImage:[UIImage imageNamed:@"mei.png"] atIndex:0 animated:NO];
    //        // 在指定索引插入一个选项并设置题目
    //        [segmentcontrol insertSegmentWithTitle:@"insert" atIndex:1 animated:NO];
    // 设置在点击后是否恢复原样
    segmentcontrol.momentary = NO;
    [segmentcontrol setTitle:@"维修" forSegmentAtIndex:0];//设置指定索引的题目
    [segmentcontrol setTitle:@"安装" forSegmentAtIndex:1];
    // 设置指定索引选项的宽度
    [segmentcontrol setWidth:50.0 forSegmentAtIndex:0];
    [segmentcontrol addTarget:self action:@selector(segmentedControlAction:) forControlEvents:UIControlEventValueChanged];
    [typeBackImage addSubview:segmentcontrol];
    
    segmentcontrol.sd_layout.rightSpaceToView(typeBackImage, 40)
    .topSpaceToView(typeBackImage, 9)
    .widthIs(100)
    .bottomSpaceToView(typeBackImage, 9);
}

//  确认下单 按钮
- (void)creatButton {
    
    UIButton *confirmatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmatBtn = [[UIButton alloc] init];
    UIImageView *btnImage = [[UIImageView alloc] init];
    btnImage.contentMode = UIViewContentModeScaleAspectFill;
    btnImage.image = [UIImage imageNamed:@"next_btn_nomal"];
    [confirmatBtn setBackgroundImage:btnImage.image forState:UIControlStateNormal];
//    confirmatBtn.backgroundColor = [UIColor colorWithRed:253.0/255.0 green:217.0/255.0 blue:85.0/255.0 alpha:1];
    [confirmatBtn setTitle:@"确定发布" forState:UIControlStateNormal];
    [confirmatBtn.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [confirmatBtn addTarget:self action:@selector(confirmatButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [downView addSubview:confirmatBtn];
    confirmatBtn.sd_layout.leftSpaceToView(downView, 12)
    .topSpaceToView(downView, 20)
    .rightSpaceToView(downView, 12)
    .bottomSpaceToView(downView, 20);
    
}

- (void)segmentedControlAction:(UISegmentedControl *)Seg {
    
    [ZSDetailOrderModel shareDetailOrder].KindIndex = Seg.selectedSegmentIndex;
    
}


//  改变键盘右下角 按钮
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    //    [_addressTF resignFirstResponder];
    return YES;
}

//  维护的 点击事件
- (void)maintaBtnClick:(UIButton *)button {
    
    NSLog(@"已选择维护");
}

//  安装的 点击事件
- (void)installBtnClick:(UIButton *)button {
    
    NSLog(@"已选择安装");
}

- (void)changeTextFieldColor:(UITextField *)TextField AndSliderTag:(NSInteger)sliderTag{
    
    
    NSString *priceStr;
    
    if (sliderTag == 0) {
        priceStr = @"请输入价格";
    }else if (sliderTag == 1) {
        priceStr = @"待技术勘察";
    }else {
        priceStr = @"待协商";
    }
    NSMutableAttributedString *placeholderPrice = [[NSMutableAttributedString alloc]initWithString:priceStr];
    [placeholderPrice addAttribute:NSForegroundColorAttributeName
                             value:Placeholder_Color
                             range:NSMakeRange(0, priceStr.length)];
    TextField.attributedPlaceholder = placeholderPrice;
    
}


#warning 如果 slider 没有选择，则弹出一个提示框！或者默认就是 0 ---------------------------
#pragma mark - 滑动按钮点击 响应事件
-(void)filterValueChanged:(ZSFitterControl *)sender
{
    NSLog(@"当前滑块位置%d",_filter.SelectedIndex);
    switch (sender.SelectedIndex) {
        case 0:
            NSLog(@"一口价");
            _prace.text = @"价格";
            [_prace setFont:[UIFont systemFontOfSize:15]];
            [self changeTextFieldColor:_priceTF AndSliderTag:0];
            _priceTF.userInteractionEnabled = YES;
            break;
        case 1:
            
#warning mark - 这里的placeholder是不可输入，要设置中划线吗？
            NSLog(@"待技术勘察");
            _priceTF.text = @"";
            [self changeTextFieldColor:_priceTF AndSliderTag:1];
            _priceTF.userInteractionEnabled = NO;
            break;
        case 2:
            NSLog(@"待协商");
            _priceTF.text = @"";
            [self changeTextFieldColor:_priceTF AndSliderTag:2];
            _priceTF.userInteractionEnabled = NO;
            break;
        default:
            break;
    }
}

#pragma mark - 确定下单按钮
- (void)confirmatButtonClick {
    
    NSLog(@"确定发布----");
    
#warning 这里加 发布非空判定
    
    if ([_titleTF.text isEqual: @""]) {
        
        [self showMessage:@"请输入标题" inView:midUpView];
        
    }else if ([_descriptTV.text isEqual: @""]) {
        
        [self showMessage:@"请描述一下您的需求" inView:midUpView];
        
    }else if ([_addressTF.text isEqual: @""]) {
        
        [self showMessage:@"请输入详细地址" inView:midUpView];
        
    }else if ([_priceTF.text isEqual: @""] && (_filter.SelectedIndex == 0)) {
        
        [self showMessage:@"请输入价格" inView:midUpView];
        
    }else {
        
        NSString *title = @"确认订单";
        NSString *message = @"下单后1小时内未成功支付，订单将自动取消，请尽快完成支付";
        NSString *cancelButtonTitle = NSLocalizedString(@"检查订单", nil);
        NSString *otherButtonTitle = NSLocalizedString(@"前往支付", nil);
        
        UIAlertController *alertContr = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        //    __weak typeof(alert) wAlert = alert; [alert ...];
        
        // Create the actions.
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
            NSLog(@"继续支付---");
        }];
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            NSLog(@"确认取消---");
            
            
            TwoPayTypeViewController *payVc = [[TwoPayTypeViewController alloc] init];
            [self.navigationController pushViewController:payVc animated:YES];
            
        }];
        
        // Add the actions.
        [alertContr addAction:cancelAction];
        [alertContr addAction:otherAction];
        
        [self presentViewController:alertContr animated:YES completion:nil];
        
        
        
//        TwoDetailsViewController *detailsVC = [[TwoDetailsViewController alloc] init];
//        [self.navigationController pushViewController:detailsVC animated:YES];
    }
}

#pragma mark - 提示弹出框--自动消失[self showMessage: inView:]
- (void)show:(NSString *)msg inView:(UIView *)view mode:(ZHProgressMode *)myMode{
    
    [self shareinstance].hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    [self shareinstance].hud.color = [UIColor whiteColor];
    [[self shareinstance].hud setMargin:10];
    [self shareinstance].hud.mode = MBProgressHUDModeText;
    [[self shareinstance].hud setRemoveFromSuperViewOnHide:YES];
    [self shareinstance].hud.detailsLabel.text = msg;
    [self shareinstance].hud.contentColor = Placeholder_Color;
    [self shareinstance].hud.detailsLabel.font = [UIFont systemFontOfSize:14];
}
//  提示框消失
- (void)hide {
    if ([self shareinstance].hud != nil) {
        [[self shareinstance].hud hideAnimated:YES];
    }
}
//  提示框显示
- (void)showMessage:(NSString *)msg inView:(UIView *)view {
    [self show:msg inView:view mode:ZHProgressModeText];
    [[self shareinstance].hud hideAnimated:YES afterDelay:1];
    //用于关闭当前提示
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hide];
        
    });
}

#pragma mark - 键盘响应
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_titleTF resignFirstResponder];
    [_descriptTV resignFirstResponder];
    [_addressTF resignFirstResponder];
    [_priceTF resignFirstResponder];
    
    [self.view endEditing:YES];
}

#pragma mark - UITextViewDelegate收回键盘
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


#pragma mark - 点击任意地方收起键盘 3/3
//- (void)tapBG:(UITapGestureRecognizer *)gesture {
//
//    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
//}




#pragma mark - 取消下单按钮  < 按钮
//添加取消按钮->
- (void)addCancelBtn {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tintColor = ColorWithRGBA(44, 137, 152, 1);
    btn.frame = CGRectMake(15, 8, 53.5, 23.5);
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setBackgroundImage:[UIImage imageNamed:@"backbackgroundimage"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(cancelTwoClick) forControlEvents: UIControlEventTouchUpInside];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn setTitleColor:TextField_Text_Color forState:UIControlStateNormal];
    UIBarButtonItem * back=[[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = back;

    
}

//取消按钮点击方法
- (void)cancelTwoClick {
    
    [self twoFinishPublish];
}

#pragma mark - 完成发布
//返回
-(void)twoFinishPublish{
    //2.block传值
    if (self.mDismissBlock != nil) {
        self.mDismissBlock();
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    //[self popoverPresentationController];
}

//block声明方法
-(void)toDissmissSelf:(dismissBlock)block{
    self.mDismissBlock = block;
}


#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView {
    
    if ([textView.text length] == 0) {
        [_descriptLabel setHidden:NO];
    }else {
        [_descriptLabel setHidden:YES];
    }
}

//#pragma mark - UITextViewDelegate  字数限制
//
////  在这个地方计算输入的字数
//- (void)textViewDidChange:(UITextView *)textView {
//
//    if ([textView.text length] == 0) {
//        [descriptLabel setHidden:NO];
//    }else {
//        [descriptLabel setHidden:YES];
//    }
//
//    NSInteger wordCount = textView.text.length;
//    self.wordCountLabel.text = [NSString stringWithFormat:@"%ld/300",(long)wordCount];
//    [self wordLimit:textView];
//}


//#pragma mark - 超过300字不能输入
//-(BOOL)wordLimit:(UITextView *)text {
//    if (text.text.length < 300) {
//        NSLog(@"text.text.length:%ld",text.text.length);
//        _descriptTV.editable = YES;
//
//    }else {
//        _descriptTV.editable = NO;
//    }
//    return nil;
//}


#pragma mark UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _selectedPhotos.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZTestCell" forIndexPath:indexPath];
    cell.videoImageView.hidden = YES;
    if (indexPath.row == _selectedPhotos.count) {
        cell.imageView.image = [UIImage imageNamed:@"AlbumAddBtn.png"];
        cell.deleteBtn.hidden = YES;
    }else {
        cell.imageView.image = _selectedPhotos[indexPath.row];
        cell.asset = _selectedAssets[indexPath.row];
        cell.deleteBtn.hidden = NO;
    }
    cell.deleteBtn.tag = indexPath.row;
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == _selectedPhotos.count) {
        BOOL showSheet = YES;
        if (showSheet) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"去相册选择", nil];
#pragma clang diagnostic pop
            [sheet showInView:self.view];
        } else {
            [self pushImagePickerController];
        }
    } else { // 预览照片或者视频
        id asset = _selectedAssets[indexPath.row];
        BOOL isVideo = NO;
        if ([asset isKindOfClass:[PHAsset class]]) {
            PHAsset *phAsset = asset;
            isVideo = phAsset.mediaType == PHAssetMediaTypeVideo;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        } else if ([asset isKindOfClass:[ALAsset class]]) {
            ALAsset *alAsset = asset;
            isVideo = [[alAsset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypeVideo];
#pragma clang diagnostic pop
        }
        if (isVideo) { // 预览视频
            TZVideoPlayerController *vc = [[TZVideoPlayerController alloc] init];
            TZAssetModel *model = [TZAssetModel modelWithAsset:asset type:TZAssetModelMediaTypeVideo timeLength:@""];
            vc.model = model;
            [self presentViewController:vc animated:YES completion:nil];
        } else { // 预览照片
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithSelectedAssets:_selectedAssets selectedPhotos:_selectedPhotos index:indexPath.row];
            imagePickerVc.maxImagesCount = SHOW_IMAGE_COUNT;
            imagePickerVc.allowPickingOriginalPhoto = YES;
            imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
                _selectedPhotos = [NSMutableArray arrayWithArray:photos];
                _selectedAssets = [NSMutableArray arrayWithArray:assets];
                _isSelectOriginalPhoto = isSelectOriginalPhoto;
                [_collectionView reloadData];
                _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
            }];
            [self presentViewController:imagePickerVc animated:YES completion:nil];
        }
    }
}

#pragma mark - TZImagePickerController

- (void)pushImagePickerController {
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:SHOW_IMAGE_COUNT columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    
    
#pragma mark - 四类个性化设置，这些参数都可以不传，此时会走默认设置
    imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
    
    // 1.设置目前已经选中的图片数组
    imagePickerVc.selectedAssets = _selectedAssets; // 目前已经选中的图片数组
    
    imagePickerVc.allowTakePicture = NO; // 在内部显示拍照按钮
    
    // 2. 在这里设置imagePickerVc的外观
    // imagePickerVc.navigationBar.barTintColor = [UIColor greenColor];
    // imagePickerVc.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
    // imagePickerVc.oKButtonTitleColorNormal = [UIColor greenColor];
    
    // 3. 设置是否可以选择视频/图片/原图
    imagePickerVc.allowPickingVideo = YES;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowPickingOriginalPhoto = YES;
    
    // 4. 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = YES;
    
    // imagePickerVc.minImagesCount = 3;
    // imagePickerVc.alwaysEnableDoneBtn = YES;
    
    // imagePickerVc.minPhotoWidthSelectable = 3000;
    // imagePickerVc.minPhotoHeightSelectable = 2000;
#pragma mark - 到这里为止
    
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark - UIImagePickerController

- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) && iOS7Later) {
        // 无相机权限 做一个友好的提示
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alert show];
#define push @#clang diagnostic pop
        // 拍照之前还需要检查相册权限
    } else if ([[TZImageManager manager] authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        alert.tag = 1;
        [alert show];
    } else if ([[TZImageManager manager] authorizationStatus] == 0) { // 正在弹框询问用户是否允许访问相册，监听权限状态
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            return [self takePhoto];
        });
    } else { // 调用相机
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            self.imagePickerVc.sourceType = sourceType;
            if(iOS8Later) {
                _imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            }
            [self presentViewController:_imagePickerVc animated:YES completion:nil];
        } else {
            NSLog(@"模拟器中无法打开照相机,请在真机中使用");
        }
    }
}

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
        tzImagePickerVc.sortAscendingByModificationDate = YES;
        [tzImagePickerVc showProgressHUD];
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        // save photo and get asset / 保存图片，获取到asset
        [[TZImageManager manager] savePhotoWithImage:image completion:^(NSError *error){
            if (error) {
                [tzImagePickerVc hideProgressHUD];
                NSLog(@"图片保存失败 %@",error);
            } else {
                [[TZImageManager manager] getCameraRollAlbum:NO allowPickingImage:YES completion:^(TZAlbumModel *model) {
                    [[TZImageManager manager] getAssetsFromFetchResult:model.result allowPickingVideo:NO allowPickingImage:YES completion:^(NSArray<TZAssetModel *> *models) {
                        [tzImagePickerVc hideProgressHUD];
                        TZAssetModel *assetModel = [models firstObject];
                        if (tzImagePickerVc.sortAscendingByModificationDate) {
                            assetModel = [models lastObject];
                        }
                        [_selectedAssets addObject:assetModel.asset];
                        [_selectedPhotos addObject:image];
                        [_collectionView reloadData];
                    }];
                }];
            }
        }];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([picker isKindOfClass:[UIImagePickerController class]]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - UIActionSheetDelegate

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
#pragma clang diagnostic pop
    if (buttonIndex == 0) { // take photo / 去拍照
        [self takePhoto];
    } else if (buttonIndex == 1) {
        [self pushImagePickerController];
    }
}

#pragma mark - UIAlertViewDelegate

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
#pragma clang diagnostic pop
    if (buttonIndex == 1) { // 去设置界面，开启相机访问权限
        if (iOS8Later) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        } else {
            NSURL *privacyUrl;
            if (alertView.tag == 1) {
                privacyUrl = [NSURL URLWithString:@"prefs:root=Privacy&path=PHOTOS"];
            } else {
                privacyUrl = [NSURL URLWithString:@"prefs:root=Privacy&path=CAMERA"];
            }
            if ([[UIApplication sharedApplication] canOpenURL:privacyUrl]) {
                [[UIApplication sharedApplication] openURL:privacyUrl];
            } else {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"抱歉" message:@"无法跳转到隐私设置页面，请手动前往设置页面，谢谢" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
            }
        }
    }
}

#pragma mark - TZImagePickerControllerDelegate


/// 用户点击了取消
- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker {
    // NSLog(@"cancel");
}

// 这个照片选择器会自己dismiss，当选择器dismiss的时候，会执行下面的代理方法
// 如果isSelectOriginalPhoto为YES，表明用户选择了原图
// 你可以通过一个asset获得原图，通过这个方法：[[TZImageManager manager] getOriginalPhotoWithAsset:completion:]
// photos数组里的UIImage对象，默认是828像素宽，你可以通过设置photoWidth属性的值来改变它
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    _selectedAssets = [NSMutableArray arrayWithArray:assets];
    _isSelectOriginalPhoto = isSelectOriginalPhoto;
    [_collectionView reloadData];
    
    // 1.打印图片名字
    [self printAssetsName:assets];
}

// 如果用户选择了一个视频，下面的handle会被执行
// 如果系统版本大于iOS8，asset是PHAsset类的对象，否则是ALAsset类的对象
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(id)asset {
    _selectedPhotos = [NSMutableArray arrayWithArray:@[coverImage]];
    _selectedAssets = [NSMutableArray arrayWithArray:@[asset]];
    // 打开这段代码发送视频
    // [[TZImageManager manager] getVideoOutputPathWithAsset:asset completion:^(NSString *outputPath) {
    // NSLog(@"视频导出到本地完成,沙盒路径为:%@",outputPath);
    // 导出完成，在这里写上传代码，通过路径或者通过NSData上传
    
    // }];
    [_collectionView reloadData];
    
}

#pragma mark - Click Event

- (void)deleteBtnClik:(UIButton *)sender {
    [_selectedPhotos removeObjectAtIndex:sender.tag];
    [_selectedAssets removeObjectAtIndex:sender.tag];
    
    [_collectionView performBatchUpdates:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag inSection:0];
        [_collectionView deleteItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [_collectionView reloadData];
    }];
}


#pragma mark - Private

/// 打印图片名字
- (void)printAssetsName:(NSArray *)assets {
    NSString *fileName;
    for (id asset in assets) {
        if ([asset isKindOfClass:[PHAsset class]]) {
            PHAsset *phAsset = (PHAsset *)asset;
            fileName = [phAsset valueForKey:@"filename"];
        } else if ([asset isKindOfClass:[ALAsset class]]) {
            ALAsset *alAsset = (ALAsset *)asset;
            fileName = alAsset.defaultRepresentation.filename;;
        }
        NSLog(@"图片名字:%@",fileName);
    }
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}


@end

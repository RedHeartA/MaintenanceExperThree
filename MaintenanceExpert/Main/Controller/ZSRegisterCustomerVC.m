//
//  ZSRegisterCustomerVC.m
//  MaintenanceExpert
//
//  Created by xpc on 16/10/20.
//  Copyright © 2016年 ZSYW. All rights reserved.
//
//  客户、工程师 注册界面

#import "ZSRegisterCustomerVC.h"
#import "ZHBtnSelectView.h"
#import "ZHCustomBtn.h"
#import "STPickerDate.h"
#import "STPickerArea.h"
#import "UIViewController+SelectPhotoIcon.h"
#import "ZSDetailRegisterModel.h"
#import "AFNetworking.h"

@interface ZSRegisterCustomerVC () <UITextFieldDelegate,ZHBtnSelectViewDelegate,STPickerAreaDelegate,STPickerDateDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UIScrollView *_scrollview;
    UILabel *_titlelabel;
    NSMutableArray *_titlearray;
    
    UITableView *_tableview;
    NSMutableArray *_kehutitle;
    NSInteger _kehuKind;
    
    UITextField *_nametextfield;
    UITextField *_phonetextfield;
    UITextField *_emailtextfield;
    UITextField *_companytextfield;
    UITextField *_workchangjiatextfield;
    
    
    UITextField *_textArea;
    UITextField *_textDetailArea;
    UITextField *_date;
    
    UIImageView *_identitycard;
    UIImage *_identitycardimage;
    
    NSInteger _indexX;
    NSInteger _indexY;
    
    NSInteger _indeyY;
    
    UITextField *_textContactName;
    UITextField *_textContactPhone;
    
    UITextField *_CompanyName;
    UITextField *_Businesslicense;
    
    UIImageView *_BusinesslicenseImageview;
    UIImage *_BusinesslicenseImage;
    
    UIImageView *_yesview;
    UIButton *_commitbtngeren;
    UIButton *_commitbtngongsi;
    
}
@property (nonatomic,assign)NSInteger registerkind;
/**
 *  工程师
 */
@property (nonatomic,weak)ZHCustomBtn *currentGenderBtn;
@property (nonatomic,weak)ZHBtnSelectView *btnGenderView;

@property (nonatomic,weak)ZHCustomBtn *currentcompletealoneBtn;
@property (nonatomic,weak)ZHBtnSelectView *btncompletealoneView;

@property (nonatomic,weak)ZHCustomBtn *currentworkmodeBtn;
@property (nonatomic,weak)ZHBtnSelectView *btnworkmodeView;

@property (nonatomic,weak)ZHCustomBtn *currentservicemodeBtn;
@property (nonatomic,weak)ZHBtnSelectView *btnservicemodeView;

@property (nonatomic,weak)ZHCustomBtn *currentskillBtn;
@property (nonatomic,weak)ZHBtnSelectView *btnskillmodeView;

@property (nonatomic,strong)NSMutableArray *titleArr;
@property (nonatomic,strong)NSArray *kindArr;

/**
 *  客户
 */
@property (nonatomic,weak)ZHCustomBtn *currentKindBtn;
@property (nonatomic,weak)ZHBtnSelectView *btnKindView;




@end

@implementation ZSRegisterCustomerVC

- (void)viewWillAppear:(BOOL)animated {
    
    [self createidentitycard];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ViewController_Back_Color;
    
    [ZSDetailRegisterModel shareRegist].type = @"personal";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBG:)];
    [self.view addGestureRecognizer:tapGesture];
    
    self.registerkind = [ZSDetailRegisterModel shareRegist].RegisterIndex;
    if (self.registerkind == 111) {
        self.navigationItem.title = @"工程师";
        [self createEngineerScrollview];//工程师
    }else if(self.registerkind == 110) {
        self.navigationItem.title = @"客户";
        _indeyY = 20;
        _kehuKind = 1001;
        [self createClienteleTableview];//客户
    }

}

- (void)tapBG:(UITapGestureRecognizer *)gesture {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    
}

#pragma mark - 工程师注册界面
- (void)createEngineerScrollview {
    /**
     scrollview初始化
     */
    _scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - 64 )];
    _scrollview.backgroundColor = ViewController_Back_Color;
    [self.view addSubview:_scrollview];
    _scrollview.showsVerticalScrollIndicator = YES;
    _scrollview.showsHorizontalScrollIndicator = YES;
    _scrollview.contentSize = CGSizeMake(0, 940);
    
    _titlearray = [[NSMutableArray alloc]initWithObjects:@"姓    名:",@"性    别:",@"出生日期:",@"现居住地:",@"手    机:",@"电子邮件:",@"能否独立完成:",@"工作模式:",@"服务模式:\n(用户需求)",@"你的专业:",@"目前工作单位:",@"是否是厂家工程师:",@"相关技能证书:",@"手持身份证照片:", nil];
    self.titleArr = @[].mutableCopy;
    [self createtitlelabel];
    [self createsubview];
}
/**
 *  项目，label
 */
- (void)createtitlelabel {
    
    
    for (int i = 0; i < 14; i++) {
        _titlelabel = [[UILabel alloc]init];
        
        if (i < 8) {
            
            _titlelabel.frame = CGRectMake(10, i * 44, 100, 40);
            if (i == 6) {
                _titlelabel.frame = CGRectMake(10, 6 * 44, 200, 40);
            }
            
        }else if ( i == 8 ){
            
            _titlelabel.frame = CGRectMake(10, 8 * 44, 120, 33 * 2 - 2);
        
        }else if (i == 9) {
            
            _titlelabel.frame = CGRectMake(10, 8 * 44 + 33 * 2, 100, 33 * 5 - 2);
            
        }else if (i < 12 && i > 9) {
            
            _titlelabel.frame = CGRectMake(10, 8 * 44 + 33 * 7 + (i - 10) * 44, 150, 40);
            
        }else if (i < 14 && i > 11) {
                
                _titlelabel.frame = CGRectMake(10, 10 * 44 + 33 * 7 + (i - 12) * 80 , 150, 80 - 2);
            
        }
    
        
        _titlelabel.text = [NSString stringWithFormat:@"%@",_titlearray[i]];
        _titlelabel.textColor = Label_Color;
        _titlelabel.numberOfLines = 2;
        _titlelabel.backgroundColor = ViewController_Back_Color;
        UIImageView *lineview = [[UIImageView alloc]initWithFrame:CGRectMake(10, _titlelabel.frame.origin.y + _titlelabel.frame.size.height, KScreenWidth - 20, 1)];
        lineview.backgroundColor = Line_Color;
        [_scrollview addSubview:lineview];
        
        [_scrollview addSubview:_titlelabel];
    }
    
}

- (void)createsubview {
    
    [self createnameTF];
    [self createGender];
    [self createdate];
    _indexY = 136;
    _indexX = KScreenWidth / 3 ;
    [self createarea];
    [_scrollview addSubview:_textArea];
    [self createphone];
    [self createmail];
    [self createcompletealone];
    [self createworkmode];
    [self createservicemode];
    [self createprofession];
    
    [self createcompany];
    [self createifengineer];
    [self createskillcertificate];

    [self createcommitbtn];
    
}

/**
 *  各个控件
 */
//姓名
- (void)createnameTF {
    _nametextfield = [[UITextField alloc]initWithFrame:CGRectMake(KScreenWidth / 2 , 6, KScreenWidth / 2 - 15, 30)];
    _nametextfield.textColor = TextField_Text_Color;
    NSString *nameStr = @"请输入姓名";
    NSMutableAttributedString *placeholder1 = [[NSMutableAttributedString alloc]initWithString:nameStr];
    [placeholder1 addAttribute:NSForegroundColorAttributeName
                        value:Placeholder_Color
                        range:NSMakeRange(0, nameStr.length)];
    _nametextfield.attributedPlaceholder = placeholder1;
    _nametextfield.returnKeyType = UIReturnKeyDone;
    _nametextfield.delegate = self;
    [_scrollview addSubview:_nametextfield];
    _nametextfield.textAlignment = NSTextAlignmentRight;
}
//性别
- (void)createGender {
    
    self.kindArr = [[NSArray alloc]initWithObjects:@"男",@"女", nil];
    // 自动计算view的高度
    ZHBtnSelectView *btnView = [[ZHBtnSelectView alloc] initWithFrame:CGRectMake(KScreenWidth / 2  , 48, KScreenWidth / 2 , 0)
                                                               titles:self.kindArr column:2];
    [_scrollview addSubview:btnView];
    btnView.verticalMargin = 10;
    btnView.delegate = self;
    btnView.tag  = 1;
    self.btnGenderView.tag = btnView.tag;
    self.btnGenderView = btnView;
}
//出生日期
- (void)createdate {
    
    _date = [[UITextField alloc]initWithFrame:CGRectMake(KScreenWidth / 2  , 88 + 4, KScreenWidth / 2 - 15 , 30)];
    _date.textColor = TextField_Text_Color;
    NSString *date = @"请选择时间";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:date];
    [placeholder addAttribute:NSForegroundColorAttributeName
                        value:Placeholder_Color
                        range:NSMakeRange(0, date.length)];
    _date.attributedPlaceholder = placeholder;
    _date.delegate  = self;
    _date.textAlignment = NSTextAlignmentRight;
    [_scrollview addSubview:_date];
    
}
//现居住地
- (void)createarea {
    //_textArea = [[UITextField alloc]initWithFrame:CGRectMake(_indexX  , _indexY + 2 + _indeyY, KScreenWidth - _indexX , 30)];
    _textArea = [[UITextField alloc]initWithFrame:CGRectMake(_indexX  , _indexY + 2 + _indeyY, KScreenWidth * 2 / 3 - 15 , 30)];
    _textArea.textColor = TextField_Text_Color;
    NSString *textArea = @"请选择地址";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:textArea];
    [placeholder addAttribute:NSForegroundColorAttributeName
                         value:Placeholder_Color
                         range:NSMakeRange(0, textArea.length)];
    _textArea.attributedPlaceholder = placeholder;
    _textArea.textAlignment = NSTextAlignmentRight;
    _textArea.delegate = self;
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField == _date) {
        [_date resignFirstResponder];
        
        STPickerDate *pickerDate = [[STPickerDate alloc]init];
        [pickerDate setDelegate:self];
        [pickerDate show];
    }else  if (textField == _textArea) {
        [_textArea resignFirstResponder];
        STPickerArea *pickerArea = [[STPickerArea alloc]init];
        [pickerArea setDelegate:self];
        [pickerArea setContentMode:STPickerContentModeBottom];
        [pickerArea show];
    }
}

- (void)pickerDate:(STPickerDate *)pickerDate year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    NSString *text = [NSString stringWithFormat:@"%ld年%ld月%ld日", year, month, day];
    _date.text = text;
}
- (void)pickerArea:(STPickerArea *)pickerArea province:(NSString *)province city:(NSString *)city area:(NSString *)area
{
    NSString *text = [NSString stringWithFormat:@"%@ %@ %@", province, city, area];
    _textArea.text = text;
}
//手机
- (void)createphone {
    _phonetextfield = [[UITextField alloc]initWithFrame:CGRectMake(KScreenWidth / 2 , 6 + 176, KScreenWidth / 2 - 15, 30)];
    _phonetextfield.textColor = TextField_Text_Color;
    NSString *phone = @"请输入手机号";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:phone];
    [placeholder addAttribute:NSForegroundColorAttributeName
                        value:Placeholder_Color
                        range:NSMakeRange(0, phone.length)];
    _phonetextfield.attributedPlaceholder = placeholder;
    _phonetextfield.returnKeyType = UIReturnKeyDone;
    _phonetextfield.delegate = self;
    [_scrollview addSubview:_phonetextfield];
    _phonetextfield.textAlignment = NSTextAlignmentRight;
    _phonetextfield.keyboardType = UIKeyboardTypeNumberPad;
}

//电子邮件
- (void)createmail {
    _emailtextfield = [[UITextField alloc]initWithFrame:CGRectMake(KScreenWidth / 2 , 6 + 220, KScreenWidth / 2 - 15, 30)];
    _emailtextfield.textColor = TextField_Text_Color;
    NSString *email = @"请输入邮箱";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:email];
    [placeholder addAttribute:NSForegroundColorAttributeName
                        value:Placeholder_Color
                        range:NSMakeRange(0, email.length)];
    _emailtextfield.attributedPlaceholder = placeholder;
    _emailtextfield.returnKeyType = UIReturnKeyDone;
    _emailtextfield.delegate = self;
    _emailtextfield.keyboardType = UIKeyboardTypeEmailAddress;
    [_scrollview addSubview:_emailtextfield];
    _emailtextfield.textAlignment = NSTextAlignmentRight;

}

//能否独立完成你专业的维保服务
- (void)createcompletealone {
    self.kindArr = [[NSArray alloc]initWithObjects:@"是",@"否", nil];
    // 自动计算view的高度
    ZHBtnSelectView *btnView = [[ZHBtnSelectView alloc] initWithFrame:CGRectMake(KScreenWidth / 2 , 268, KScreenWidth / 2, 0)
                                                               titles:self.kindArr column:2];
    [_scrollview addSubview:btnView];
    btnView.verticalMargin = 10;
    btnView.delegate = self;
    btnView.tag  = 2;
    self.btncompletealoneView.tag = btnView.tag;
    self.btncompletealoneView = btnView;
    
}
//工作模式
- (void)createworkmode {
    
    self.kindArr = [[NSArray alloc]initWithObjects:@"兼职",@"全职", nil];
    // 自动计算view的高度
    ZHBtnSelectView *btnView = [[ZHBtnSelectView alloc] initWithFrame:CGRectMake(KScreenWidth / 2 , 4 + 308, KScreenWidth / 2, 0)
                                                               titles:self.kindArr column:2];
    [_scrollview addSubview:btnView];
    btnView.verticalMargin = 10;
    btnView.delegate = self;
    btnView.tag  = 3;
    self.btnworkmodeView.tag = btnView.tag;
    self.btnworkmodeView = btnView;

}

#warning 按钮文字的frame需要调整
//服务模式（用户需求）
- (void)createservicemode {
    self.kindArr = [[NSArray alloc]initWithObjects:@"现场值守",@"定期巡检",@"即时上门", nil];
    // 自动计算view的高度
    ZHBtnSelectView *btnView = [[ZHBtnSelectView alloc] initWithFrame:CGRectMake(KScreenWidth  / 2 - 40, 4 + 352, KScreenWidth / 2, 0)
                                                               titles:self.kindArr column:2];
    [_scrollview addSubview:btnView];
    btnView.verticalMargin = 10;
    btnView.delegate = self;
    self.btnservicemodeView = btnView;
    btnView.tag  = 4;
    self.btnservicemodeView.tag = btnView.tag;
    
}
//你的专业
- (void)createprofession {
    self.kindArr = [[NSArray alloc]initWithObjects:@"UPS",@"机房配电",@"电力工程师",@"发电机",@"机房空调",@"门禁",@"视频监控",@"动力环境监控",@"机房网络",@"消防", nil];
    // 自动计算view的高度
    ZHBtnSelectView *btnView = [[ZHBtnSelectView alloc] initWithFrame:CGRectMake(KScreenWidth  / 2  - 40, 8 + 418, KScreenWidth / 2, 0)
                                                               titles:self.kindArr column:2];
    [_scrollview addSubview:btnView];
    btnView.verticalMargin = 10;
    btnView.delegate = self;
    self.btnskillmodeView = btnView;
    btnView.tag  = 5;
    self.btnskillmodeView.tag = btnView.tag;

}
//当前从事的工作单位名称
- (void)createcompany {
    _companytextfield = [[UITextField alloc]initWithFrame:CGRectMake(KScreenWidth / 2 , 6 + 583, KScreenWidth / 2 - 15, 30)];
    _companytextfield.textColor = TextField_Text_Color;
    NSString *company = @"请输入单位名称";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:company];
    [placeholder addAttribute:NSForegroundColorAttributeName
                        value:Placeholder_Color
                        range:NSMakeRange(0, company.length)];
    _companytextfield.attributedPlaceholder = placeholder;
    _companytextfield.returnKeyType = UIReturnKeyDone;
    _companytextfield.delegate = self;
    [_scrollview addSubview:_companytextfield];
    _companytextfield.textAlignment = NSTextAlignmentRight;
}
//是否是厂家工程师
- (void)createifengineer {
    _workchangjiatextfield = [[UITextField alloc]initWithFrame:CGRectMake(KScreenWidth / 2 , 6 + 627, KScreenWidth / 2 - 15, 30)];
    _workchangjiatextfield.textColor = TextField_Text_Color;
    NSString *work = @"是的话请填写厂家";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:work];
    [placeholder addAttribute:NSForegroundColorAttributeName
                        value:Placeholder_Color
                        range:NSMakeRange(0, work.length)];
    _workchangjiatextfield.attributedPlaceholder = placeholder;
    _workchangjiatextfield.returnKeyType = UIReturnKeyDone;
    _workchangjiatextfield.delegate = self;
    [_scrollview addSubview:_workchangjiatextfield];
    _workchangjiatextfield.textAlignment = NSTextAlignmentRight;
}
//相关技能证书
- (void)createskillcertificate {
    
#warning 技能相关证书
    
}
//手持身份证照片
- (void)createidentitycard {
    _identitycard = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth - 15 - 80, 751 + 5, 70, 70)];

    _identitycard.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"add.jpg"]];
    _identitycard.image = _identitycardimage;
    [_scrollview addSubview:_identitycard];
    
    UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addIDcard)];
    _identitycard.userInteractionEnabled = YES;
    [_identitycard addGestureRecognizer:gest];
}

- (void)addIDcard {
    
    [self showActionSheet];
    
}
//完成按钮
- (void)createcommitbtn {
    
    UIButton *commitbtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 840, KScreenWidth - 40, 40)];
    [commitbtn setBackgroundImage:[UIImage imageNamed:@"wancheng"] forState:UIControlStateNormal];
    [commitbtn setBackgroundImage:[UIImage imageNamed:@"wancheng-hov"] forState:UIControlStateSelected];
    [commitbtn setTitle:@"完    成" forState:UIControlStateNormal];
    [commitbtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    commitbtn.layer.cornerRadius = 10;
    [_scrollview addSubview:commitbtn];
    [commitbtn addTarget:self action:@selector(btncommit) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)btncommit {
    [ZSDetailRegisterModel shareRegist].address = _textDetailArea.text;
    [ZSDetailRegisterModel shareRegist].contact = _textContactName.text;
    //[ZSDetailRegisterModel shareRegist].mobile = _textContactPhone.text;
    
    [ZSDetailRegisterModel shareRegist].company_name =_CompanyName.text;
    [ZSDetailRegisterModel shareRegist].license_id = _Businesslicense.text;
    
    
    [self sendPostRequest];
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)sendPostRequest{
    
    NSDictionary *dict = [NSDictionary dictionary];
    NSString *urlstring = @RegisterURL;
    if ([[ZSDetailRegisterModel shareRegist].type isEqualToString:@"personal"]) {
        dict =@{
                              @"contact":[ZSDetailRegisterModel shareRegist].contact,
                              @"password":[ZSDetailRegisterModel shareRegist].password,
                              @"mobile":[ZSDetailRegisterModel shareRegist].mobile,
                              @"type":[ZSDetailRegisterModel shareRegist].type,
                              @"prov_id":[ZSDetailRegisterModel shareRegist].prov_id,
                              @"city_id":[ZSDetailRegisterModel shareRegist].city_id,
                              @"dist_id":[ZSDetailRegisterModel shareRegist].dist_id,
                              @"address":[ZSDetailRegisterModel shareRegist].address,
                            };

    }else{
        dict =@{
                              @"contact":[ZSDetailRegisterModel shareRegist].contact,
                              @"password":[ZSDetailRegisterModel shareRegist].password,
                              @"mobile":[ZSDetailRegisterModel shareRegist].mobile,
                              @"type":[ZSDetailRegisterModel shareRegist].type,
                              @"prov_id":[ZSDetailRegisterModel shareRegist].prov_id,
                              @"city_id":[ZSDetailRegisterModel shareRegist].city_id,
                              @"dist_id":[ZSDetailRegisterModel shareRegist].dist_id,
                              @"address":[ZSDetailRegisterModel shareRegist].address,
                              @"company_name":[ZSDetailRegisterModel shareRegist].company_name,
                              @"license_id":[ZSDetailRegisterModel shareRegist].license_id,
                            };
    }
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manage POST:urlstring parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@",dic);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    
}


//TODO:身份证照片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info;{
    
    //获得编辑后的图片
    UIImage *editedImage = (UIImage *)info[UIImagePickerControllerEditedImage];
    _identitycardimage= editedImage;    
    _BusinesslicenseImage = editedImage;
    [picker dismissViewControllerAnimated:NO completion:nil];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:2 inSection:0];
    [_tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
}

// view的代理方法
- (void)btnSelectView:(ZHBtnSelectView *)btnSelectView selectedBtn:(ZHCustomBtn *)btn {
    btnSelectView.selectType = BtnSelectTypeMultiChoose;
    
    if ((btnSelectView.tag == 1)) {
        self.btnGenderView.selectType = BtnSelectTypeSingleChoose;
        self.currentGenderBtn.btnSelected = NO;
        self.currentGenderBtn = btn;
        btn.btnSelected = YES;
    }if ((btnSelectView.tag == 2)) {
        self.btncompletealoneView.selectType = BtnSelectTypeSingleChoose;
        self.currentcompletealoneBtn.btnSelected = NO;
        self.currentcompletealoneBtn = btn;
        btn.btnSelected = YES;
    }if ((btnSelectView.tag == 3)) {
        self.btnworkmodeView.selectType = BtnSelectTypeSingleChoose;
        self.currentworkmodeBtn.btnSelected = NO;
        self.currentworkmodeBtn = btn;
        btn.btnSelected = YES;
    }if ((btnSelectView.tag == 4)) {
        self.btnservicemodeView.selectType = BtnSelectTypeMultiChoose;
        btn.btnSelected = !btn.btnSelected;
        if (btn.btnSelected) {
            [self.titleArr addObject:btn.titleLabel.text];
        } else {
            [self.titleArr removeObject:btn.titleLabel.text];
        }
    }if ((btnSelectView.tag == 5)) {
        self.btnskillmodeView.selectType = BtnSelectTypeMultiChoose;
        btn.btnSelected = !btn.btnSelected;
        if (btn.btnSelected) {
            [self.titleArr addObject:btn.titleLabel.text];
        } else {
            [self.titleArr removeObject:btn.titleLabel.text];
        }
    }if ((btnSelectView.tag == 11)) {
        self.btnKindView.selectType = BtnSelectTypeSingleChoose;
        self.currentKindBtn.btnSelected = NO;
        self.currentKindBtn = btn;
        btn.btnSelected = YES;
        if ([self.currentKindBtn.titleLabel.text isEqualToString:@"公司"]) {
            _kehuKind = 1002;
            _indeyY = 10;
            [ZSDetailRegisterModel shareRegist].type = @"company";
            _yesview.hidden = YES;
            _commitbtngeren.hidden = YES;
            _commitbtngongsi.hidden = NO;
            [_tableview reloadData];
        }else {
            _kehuKind = 1001;
            _indeyY = 20;
            [_tableview reloadData];
            [ZSDetailRegisterModel shareRegist].type = @"personal";
            _commitbtngeren.hidden = NO;
            _commitbtngongsi.hidden = YES;
        }
    }
    
}


#pragma mark - 客户注册界面
- (void)createClienteleTableview {
    UILabel *Kindlabel = [[UILabel alloc]initWithFrame:CGRectMake(33, 5, 140, 50)];
    Kindlabel.text = @"账户类型:";
    Kindlabel.textColor = Label_Color;
    Kindlabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:Kindlabel];
    self.kindArr = [[NSArray alloc]initWithObjects:@"个人",@"公司", nil];
    // 自动计算view的高度
    ZHBtnSelectView *btnView = [[ZHBtnSelectView alloc] initWithFrame:CGRectMake(KScreenWidth / 3 + 10  , 13, KScreenWidth / 2 , 0)
                                                               titles:self.kindArr column:2];
    [self.view addSubview:btnView];
    btnView.verticalMargin = 10;
    btnView.delegate = self;
    btnView.tag  = 11;
    self.btnKindView.tag = btnView.tag;
    self.btnKindView = btnView;
    
    _yesview = [[UIImageView alloc]initWithFrame:CGRectMake(9, 9, 17, 17)];
    _yesview.image = [UIImage imageNamed:@"Y"];
    _yesview.backgroundColor = self.view.backgroundColor;
    _yesview.contentMode = UIViewContentModeScaleAspectFill;
    [btnView addSubview:_yesview];
    
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(10, 60, KScreenWidth - 20, KScreenHeight - 64 - 50 ) style:UITableViewStylePlain];
    _tableview.backgroundColor = ViewController_Back_Color;
    [self.view addSubview:_tableview];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.showsVerticalScrollIndicator = NO;
    _tableview.bounces = YES;
    _tableview.backgroundColor = self.view.backgroundColor;
    [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Tcell"];
    
    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(20, 60, KScreenWidth - 40, 1)];
    line.backgroundColor = Line_Color;
    [self.view addSubview:line];
    [self createbtncommit];
    
}

- (void)createbtncommit{
    _commitbtngeren = [[UIButton alloc]initWithFrame:CGRectMake(5, 80 * 4 + 20 , KScreenWidth-30, 40)];
    [_commitbtngeren setBackgroundImage:[UIImage imageNamed:@"wancheng"] forState:UIControlStateNormal];
    [_commitbtngeren setBackgroundImage:[UIImage imageNamed:@"wancheng-hov"] forState:UIControlStateSelected];
    [_commitbtngeren setTitle:@"完    成" forState:UIControlStateNormal];
    [_commitbtngeren.titleLabel setFont:[UIFont systemFontOfSize:16]];
    _commitbtngeren.layer.cornerRadius = 10;
    [_tableview addSubview:_commitbtngeren];
    [_commitbtngeren addTarget:self action:@selector(btncommit) forControlEvents:UIControlEventTouchUpInside];
    
    _commitbtngongsi = [[UIButton alloc]initWithFrame:CGRectMake(5, 60 * 7+20+20 , KScreenWidth-30, 40)];
    [_commitbtngongsi setBackgroundImage:[UIImage imageNamed:@"wancheng"] forState:UIControlStateNormal];
    [_commitbtngongsi setBackgroundImage:[UIImage imageNamed:@"wancheng-hov"] forState:UIControlStateSelected];
    [_commitbtngongsi setTitle:@"完    成" forState:UIControlStateNormal];
    [_commitbtngongsi.titleLabel setFont:[UIFont systemFontOfSize:16]];
    _commitbtngongsi.layer.cornerRadius = 10;
    [_tableview addSubview:_commitbtngongsi];
    [_commitbtngongsi addTarget:self action:@selector(btncommit) forControlEvents:UIControlEventTouchUpInside];
    _commitbtngongsi.hidden = YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_kehuKind == 1001) {
        return 4;
    }else{
        return 9;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_kehuKind == 1001) {
        return 80;
    }else{
        if (indexPath.row == 2) {
            return 80;
        }else {
            return 60;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Tcell"];
    //cell.backgroundColor = self.view.backgroundColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIView *tempView = [[UIView alloc] init];
    [cell setBackgroundView:tempView];
    cell.backgroundColor = [UIColor clearColor];

    
    
    //去掉分割线
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    if (_kehuKind == 1001) {
        _kehutitle = [[NSMutableArray alloc]initWithObjects:@"地        址:",@"详细地址:",@"联  系  人:",@"联系电话:", nil];
        UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(10, 80, KScreenWidth - 40, 1)];
        line.backgroundColor = Line_Color;
        [cell addSubview:line];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",_kehutitle[indexPath.row]];
        cell.textLabel.textColor = Label_Color;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
        switch (indexPath.row) {
            case 0:
                _indexY = 4;
                _indexX = KScreenWidth / 3;
                [self createarea];
                _textArea.textAlignment = NSTextAlignmentLeft;
                [cell addSubview:_textArea];
                break;
            case 1:
                [self createDetailArea];
                [cell addSubview:_textDetailArea];
                break;
            case 2:
                [self createContactName];
                [cell addSubview:_textContactName];
                break;
            case 3:
                [self createContactPhone];
                [cell addSubview:_textContactPhone];
                break;
            default:
                break;
        }
    }else{
        _kehutitle = [[NSMutableArray alloc]initWithObjects:@"公司名称:",@"营业执照:",@"营业执照\n    (照片):",@"地        址:",@"详细地址:",@"联  系  人:",@"联系电话:",@"",@"", nil];
        cell.textLabel.numberOfLines = 2;
        UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(10, 60, KScreenWidth - 40, 1)];
        line.backgroundColor = Line_Color;
        [cell addSubview:line];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",_kehutitle[indexPath.row]];
        cell.textLabel.textColor = Label_Color;
        switch (indexPath.row) {
            case 0:
                [self createCompanyName];
                [cell addSubview:_CompanyName];
                break;
            case 1:
                [self createBuLi];
                [cell addSubview:_Businesslicense];
                break;
            case 2:
                line.frame = CGRectMake(10, 80, KScreenWidth - 40, 1);
                [self createBusinesslicenseImage];
                [cell addSubview:_BusinesslicenseImageview];
                break;
            case 3:
                _indexY = 4;
                _indexX = KScreenWidth / 3;
                [self createarea];
                _textArea.textAlignment = NSTextAlignmentLeft;
                [cell addSubview:_textArea];
                break;
            case 4:
                [self createDetailArea];
                [cell addSubview:_textDetailArea];
                break;
            case 5:
                [self createContactName];
                [cell addSubview:_textContactName];
                break;
            case 6:
                [self createContactPhone];
                [cell addSubview:_textContactPhone];
                break;
            case 7:
                line.backgroundColor = ViewController_Back_Color;
                break;
            case 8:
                line.backgroundColor = ViewController_Back_Color;
                break;
            default:
                break;
        }
    }
   
    return cell;
}

- (void)createDetailArea {
    _textDetailArea = [[UITextField alloc]initWithFrame:CGRectMake(KScreenWidth / 3,  _indeyY, KScreenWidth * 2 / 3, 40)];
    _textDetailArea.textColor = TextField_Text_Color;
    NSString *DetailArea = @"详细地址";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:DetailArea];
    [placeholder addAttribute:NSForegroundColorAttributeName
                        value:Placeholder_Color
                        range:NSMakeRange(0, DetailArea.length)];
    _textDetailArea.attributedPlaceholder = placeholder;
    _textDetailArea.textAlignment = NSTextAlignmentLeft;
}
- (void)createContactName {
    _textContactName = [[UITextField alloc]initWithFrame:CGRectMake(KScreenWidth / 3, _indeyY, KScreenWidth * 2 / 3, 40)];
    _textContactName.textColor = TextField_Text_Color;
    NSString *ContactName = @"联系人";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:ContactName];
    [placeholder addAttribute:NSForegroundColorAttributeName
                        value:Placeholder_Color
                        range:NSMakeRange(0, ContactName.length)];
    _textContactName.attributedPlaceholder = placeholder;
    _textContactName.textAlignment = NSTextAlignmentLeft;
}
- (void)createContactPhone {
    _textContactPhone = [[UITextField alloc]initWithFrame:CGRectMake(KScreenWidth / 3, _indeyY, KScreenWidth * 2 / 3, 40)];
    _textContactPhone.textColor = TextField_Text_Color;
    NSString *ContactPhone = @"联系电话";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:ContactPhone];
    [placeholder addAttribute:NSForegroundColorAttributeName
                        value:Placeholder_Color
                        range:NSMakeRange(0, ContactPhone.length)];
    _textContactPhone.attributedPlaceholder = placeholder;
    _textContactPhone.keyboardType = UIKeyboardTypeNumberPad;
    _textContactPhone.textAlignment = NSTextAlignmentLeft;
}

- (void)createCompanyName {
    _CompanyName = [[UITextField alloc]initWithFrame:CGRectMake(KScreenWidth / 3, 10, KScreenWidth * 2 / 3, 40)];
    _CompanyName.textColor = TextField_Text_Color;
    NSString *CompanyName = @"公司名称";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:CompanyName];
    [placeholder addAttribute:NSForegroundColorAttributeName
                        value:Placeholder_Color
                        range:NSMakeRange(0, CompanyName.length)];
    _CompanyName.attributedPlaceholder = placeholder;
    _CompanyName.textAlignment = NSTextAlignmentLeft;
}

- (void)createBuLi {
    _Businesslicense = [[UITextField alloc]initWithFrame:CGRectMake(KScreenWidth / 3, 10, KScreenWidth * 2 / 3, 40)];
    _Businesslicense.textColor = TextField_Text_Color;
    NSString *license = @"营业执照编号";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:license];
    [placeholder addAttribute:NSForegroundColorAttributeName
                        value:Placeholder_Color
                        range:NSMakeRange(0, license.length)];
    _Businesslicense.attributedPlaceholder = placeholder;
    _Businesslicense.keyboardType = UIKeyboardTypeNumberPad;
    _Businesslicense.textAlignment = NSTextAlignmentLeft;
}

- (void)createBusinesslicenseImage {
    _BusinesslicenseImageview = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth / 3, 5, 70, 70)];
    
    _BusinesslicenseImageview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"add.jpg"]];
    _BusinesslicenseImageview.image = _BusinesslicenseImage;
    
    UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addIDcard)];
    _BusinesslicenseImageview.userInteractionEnabled = YES;
    [_BusinesslicenseImageview addGestureRecognizer:gest];
}

/**
 *  键盘响应
 *
 */
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    BOOL phoneright = [[Regex class] isMobile:_phonetextfield.text];
    if (textField == _phonetextfield) {
        if (phoneright == 1) {
            
        }else {
            UIAlertView *aler = [[UIAlertView alloc]initWithTitle:@"提示" message:@"手机号码格式输入错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            aler.alertViewStyle = UIAlertViewStyleDefault;
            [aler show];
        }
    }else if (textField == _emailtextfield) {
        BOOL emailright = [[Regex class] isAvailableEmail:_emailtextfield.text];
        
        if (emailright == 1) {
            
        }else {
            UIAlertView *aler = [[UIAlertView alloc]initWithTitle:@"提示" message:@"邮箱格式输入错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            aler.alertViewStyle = UIAlertViewStyleDefault;
            [aler show];
        }
    }
    [textField resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
 
    [textField resignFirstResponder];
    
    return YES;
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

//
//  ZSRegisterHardwareTwoVc.m
//  MaintenanceExpert
//
//  Created by xpc on 16/12/14.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSRegisterHardwareTwoVc.h"
#import "UIViewController+SelectPhotoIcon.h"
#import "STPickerArea.h"
#import "ZSDetailRegisterModel.h"


#define CELL_COUNT 6
#define CELL_HEIGHT 70

#define CELL_TextField_Frame CGRectMake(KScreenWidth / 3, 17, KScreenWidth - KScreenWidth/3 - 15, 40)

@interface ZSRegisterHardwareTwoVc ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, STPickerAreaDelegate>

{
    UITextField *_Businesslicense;      //  营业执照编号
    UIImageView *_BusinesslicenseImageview; //  营业执照-照片
    UIImage *_BusinesslicenseImage;         //  营业执照-照片
    UITextField *_textArea;         //  地址选择器
    UITextField *_textDetailArea;   //  详细地址
    UITextField *_textContactName;      //  联系人
    UITextField *_textContactPhone;     //  联系人电话
    
    NSInteger _indexX;  //  地址X
    NSInteger _indexY;  //  地址Y
}

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *dataArr;


@end

@implementation ZSRegisterHardwareTwoVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = ViewController_Back_Color;
    
    self.title = @"硬件商";
    
    [self creatTableView];
    [self creatHardwareTwoButton];
}

- (UIButton *)creatHardwareTwoButton {
    
    UIButton *hardwareTwoButton = [[UIButton alloc] initWithFrame:CGRectMake(30, CELL_HEIGHT * CELL_COUNT + 30 +50, KScreenWidth - 60, Btn_NextAndOutLogin_Height)];
    [hardwareTwoButton setBackgroundImage:[UIImage imageNamed:@"wancheng"] forState:UIControlStateNormal];
    [hardwareTwoButton setBackgroundImage:[UIImage imageNamed:@"wancheng-hov"] forState:UIControlStateSelected];
    [hardwareTwoButton setTitle:@"提 交" forState:UIControlStateNormal];
    [hardwareTwoButton addTarget:self action:@selector(hardwareTwoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:hardwareTwoButton];
    
    return hardwareTwoButton;
}

- (void)hardwareTwoButtonClick {
    
    [ZSDetailRegisterModel shareRegist].address = _textDetailArea.text;
    [ZSDetailRegisterModel shareRegist].contact = _textContactName.text;
    [ZSDetailRegisterModel shareRegist].license_id = _Businesslicense.text;
    [ZSDetailRegisterModel shareRegist].landline_num = _textContactPhone.text;
    NSString *urlstring = @RegisterURL;
    NSDictionary *dict =@{
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
                          @"landline_num":[ZSDetailRegisterModel shareRegist].landline_num,
                          @"compang_type":[ZSDetailRegisterModel shareRegist].compang_type,
                          @"company_info":[ZSDetailRegisterModel shareRegist].company_info,
                          @"company_service":[ZSDetailRegisterModel shareRegist].company_service,
                          };
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manage POST:urlstring parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@",dic);
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];

    
}

- (UITableView *)creatTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStylePlain];
    self.tableView.backgroundColor = ViewController_Back_Color;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    return self.tableView;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == _textArea) {
        [_textArea resignFirstResponder];
        STPickerArea *pickerArea = [[STPickerArea alloc]init];
        [pickerArea setDelegate:self];
        [pickerArea setContentMode:STPickerContentModeBottom];
        [pickerArea show];
    }
}

- (void)pickerArea:(STPickerArea *)pickerArea province:(NSString *)province city:(NSString *)city area:(NSString *)area
{
    NSString *text = [NSString stringWithFormat:@"%@ %@ %@", province, city, area];
    _textArea.text = text;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row != 5) {
        
        return CELL_HEIGHT;
    }
    
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return CELL_COUNT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = ViewController_Back_Color;
    }
    
    self.dataArr = [[NSArray alloc]initWithObjects:@"地   址:",@"详细地址:",@"联系人:",@"联系电话:",@"营业执照:",@"营业执照:", nil];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",_dataArr[indexPath.row]];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.textColor = Label_Color;
    
    
    if (indexPath.row == 0) {                             //地址选择器
        
        _indexY = 20;
        _indexX = KScreenWidth / 3;
        [self createarea];
        _textArea.textAlignment = NSTextAlignmentLeft;
        [cell addSubview:_textArea];
    } else if (indexPath.row == 1) {                      //详细地址
        
        [self createDetailArea];
        [cell addSubview:_textDetailArea];
    } else if (indexPath.row == 2) {                      //联系人
        
        [self createContactName];
        [cell addSubview:_textContactName];
    } else if (indexPath.row == 3) {                      //联系人-电话
        
        [self createContactPhone];
        [cell addSubview:_textContactPhone];
    } else if (indexPath.row == 4) {                      //营业执照-编号
        
        [self createBuLi];
        [cell addSubview:_Businesslicense];
    } else if (indexPath.row == 5) {                      //营业执照-照片
        
        [self createBusinesslicenseImage];
        [cell addSubview:_BusinesslicenseImageview];
    } else {
        
    }
    
    if (indexPath.row != 5) {
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, cell.frame.size.height+20, KScreenWidth - 30, 1)];
        lineView.backgroundColor = ViewController_Back_Color;
        [cell addSubview:lineView];
    }else {
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, cell.frame.size.height+50, KScreenWidth - 30, 1)];
        lineView.backgroundColor = Line_Color;
        [cell addSubview:lineView];
    }
    
    return cell;
}

- (void)createBuLi {
    _Businesslicense = [[UITextField alloc]initWithFrame:CELL_TextField_Frame];
    _Businesslicense.delegate = self;
    _Businesslicense.textColor = TextField_Text_Color;
    NSString *placeholderStr = @"营业执照编号";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:placeholderStr];
    [placeholder addAttribute:NSForegroundColorAttributeName
                        value:Placeholder_Color
                        range:NSMakeRange(0, placeholderStr.length)];
    _Businesslicense.attributedPlaceholder = placeholder;
    _Businesslicense.font = [UIFont systemFontOfSize:16];
    _Businesslicense.textAlignment = NSTextAlignmentLeft;
    _Businesslicense.returnKeyType = UIReturnKeyDone;
}

- (void)createBusinesslicenseImage {
    _BusinesslicenseImageview = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth / 3, 15, 100, 80)];
    
    _BusinesslicenseImageview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"add.jpg"]];
    _BusinesslicenseImageview.image = _BusinesslicenseImage;
    
    UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addIDcard)];
    _BusinesslicenseImageview.userInteractionEnabled = YES;
    [_BusinesslicenseImageview addGestureRecognizer:gest];
}

- (void)createDetailArea {
    _textDetailArea = [[UITextField alloc]initWithFrame:CELL_TextField_Frame];
    _textDetailArea.delegate = self;
    _textDetailArea.textColor = TextField_Text_Color;
    NSString *placeholderStr = @"详细地址";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:placeholderStr];
    [placeholder addAttribute:NSForegroundColorAttributeName
                        value:Placeholder_Color
                        range:NSMakeRange(0, placeholderStr.length)];
    _textDetailArea.attributedPlaceholder = placeholder;
    _textDetailArea.font = [UIFont systemFontOfSize:16];
    _textDetailArea.textAlignment = NSTextAlignmentLeft;
    _textDetailArea.returnKeyType = UIReturnKeyDone;
}
- (void)createContactName {
    _textContactName = [[UITextField alloc]initWithFrame:CELL_TextField_Frame];
    _textContactName.delegate = self;
    _textContactName.textColor = TextField_Text_Color;
    NSString *placeholderStr = @"联系人";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:placeholderStr];
    [placeholder addAttribute:NSForegroundColorAttributeName
                        value:Placeholder_Color
                        range:NSMakeRange(0, placeholderStr.length)];
    _textContactName.attributedPlaceholder = placeholder;
    _textContactName.font = [UIFont systemFontOfSize:16];
    _textContactName.textAlignment = NSTextAlignmentLeft;
    _textContactName.returnKeyType = UIReturnKeyDone;
}
- (void)createContactPhone {
    _textContactPhone = [[UITextField alloc]initWithFrame:CELL_TextField_Frame];
    _textContactPhone.delegate = self;
    _textContactPhone.textColor = TextField_Text_Color;
    NSString *placeholderStr = @"联系电话";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:placeholderStr];
    [placeholder addAttribute:NSForegroundColorAttributeName
                        value:Placeholder_Color
                        range:NSMakeRange(0, placeholderStr.length)];
    _textContactPhone.attributedPlaceholder = placeholder;
    _textContactPhone.font = [UIFont systemFontOfSize:16];
    _textContactPhone.keyboardType = UIKeyboardTypeNumberPad;
    _textContactPhone.textAlignment = NSTextAlignmentLeft;
}



//现居住地
- (void)createarea {
    _textArea = [[UITextField alloc]initWithFrame:CGRectMake(_indexX, _indexY, KScreenWidth - KScreenWidth/3 - 15, 30)];
    _textArea.textColor = TextField_Text_Color;
    NSString *placeholderStr = @"请选择地址";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:placeholderStr];
    [placeholder addAttribute:NSForegroundColorAttributeName
                        value:Placeholder_Color
                        range:NSMakeRange(0, placeholderStr.length)];
    _textArea.attributedPlaceholder = placeholder;
    _textArea.textAlignment = NSTextAlignmentRight;
    _textArea.delegate = self;
    
}

- (void)addIDcard {
    
    [self showActionSheet];
}

#warning 这里地址选择器要换个位置

#pragma mark - 键盘响应
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_Businesslicense resignFirstResponder];
    [_textDetailArea resignFirstResponder];
    [_textContactName resignFirstResponder];
    [_textContactPhone resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

//#pragma mark - UITextViewDelegate收回键盘
//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
//
//    [textView resignFirstResponder];
//
//    return YES;
//}


#pragma mark - UITextFieldDelegate
//  因为有地址选择器，这里最好用  UITextFieldDelegate
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
//
//    [_Businesslicense resignFirstResponder];
//    [_textDetailArea resignFirstResponder];
//    [_textContactName resignFirstResponder];
//    [_textContactPhone resignFirstResponder];
//
//    return YES;
//}



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

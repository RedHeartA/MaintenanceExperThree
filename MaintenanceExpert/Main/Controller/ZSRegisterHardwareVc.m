//
//  ZSRegisterHardwareVc.m
//  MaintenanceExpert
//
//  Created by xpc on 16/12/13.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSRegisterHardwareVc.h"
#import "ZSRegisterHardwareTwoVc.h"
#import "ZSDetailRegisterModel.h"

#define CELL_COUNT 6
#define CELL_HEIGHT 70

#define CELL_TextField_Frame CGRectMake(KScreenWidth / 3, 17, KScreenWidth - KScreenWidth/3 - 15, 40)

@interface ZSRegisterHardwareVc ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UITextViewDelegate>

{
    
    UITextField *_hardwareName;          //  公司名
    UITextField *_hardwareBrands;       //  公司品牌
    UITextField *_hardwareDeviceType;   //  设备类型
    UITextField *_hardwareType;          //  公司类型（个体、外资、国企、其他）
    UITextField *_hardwareIndustry;      //  公司行业
    UITextView *_hardwareProfile;        //  公司简介
    
    UILabel *_placeholderLab;            //  公司简介placeholder
}

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *dataArr;

@end

@implementation ZSRegisterHardwareVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = ViewController_Back_Color;
    
    self.title = @"硬件商";
    
    [self creatTableView];
    [self creatHardwareButton];
}

- (UIButton *)creatHardwareButton {
    
    UIButton *hardwareButton = [[UIButton alloc] initWithFrame:CGRectMake(30, CELL_HEIGHT * CELL_COUNT + 30 +50, KScreenWidth - 60, Btn_NextAndOutLogin_Height)];
    [hardwareButton setBackgroundImage:[UIImage imageNamed:@"wancheng"] forState:UIControlStateNormal];
    [hardwareButton setBackgroundImage:[UIImage imageNamed:@"wancheng-hov"] forState:UIControlStateSelected];
    [hardwareButton setTitle:@"下一步" forState:UIControlStateNormal];
    [hardwareButton addTarget:self action:@selector(hardwareButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:hardwareButton];
    
    return hardwareButton;
}

- (void)hardwareButtonClick {
    
    [ZSDetailRegisterModel shareRegist].company_name = _hardwareName.text;
    [ZSDetailRegisterModel shareRegist].compang_type = _hardwareType.text;
    [ZSDetailRegisterModel shareRegist].company_service = _hardwareIndustry.text;
    [ZSDetailRegisterModel shareRegist].company_info = _hardwareProfile.text;

    ZSRegisterHardwareTwoVc *hardwareTwoVc = [[ZSRegisterHardwareTwoVc alloc] init];
    [self.navigationController pushViewController:hardwareTwoVc animated:YES];
}

- (UITableView *)creatTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, CELL_COUNT * CELL_HEIGHT + 50) style:UITableViewStylePlain];
    self.tableView.backgroundColor = ViewController_Back_Color;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    return self.tableView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row != 5) {
        return CELL_HEIGHT;
    }
    
    return 120;
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
    
    self.dataArr = [[NSArray alloc]initWithObjects:@"公司名称:",@"公司品牌:",@"设备类型:",@"公司类型:",@"公司行业:",@"公司简介:", nil];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",_dataArr[indexPath.row]];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.textColor = Label_Color;
    
    
    if (indexPath.row == 0) {                             //公司名
        
        [self createHardwareName];
        [cell addSubview:_hardwareName];
    } else if (indexPath.row == 1) {                      //公司品牌
        
        [self createHardwareBrands];
        [cell addSubview:_hardwareBrands];
    } else if (indexPath.row == 2) {                      //设备类型
        
        [self createHardwareDeviceType];
        [cell addSubview:_hardwareDeviceType];
    } else if (indexPath.row == 3) {                      //公司类型
        
        [self creatHardwareType];
        [cell addSubview:_hardwareType];
    } else if (indexPath.row == 4) {                      //公司行业
        
        [self creatHardwareIndustry];
        [cell addSubview:_hardwareIndustry];
    } else if (indexPath.row == 5) {                      //公司简介
        
        [self creatHardwareProfile];
        [cell addSubview:_hardwareProfile];
    } else {
        
    }
    
    if (indexPath.row != 5) {
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, cell.frame.size.height+20, KScreenWidth - 30, 1)];
        lineView.backgroundColor = Line_Color;
        [cell addSubview:lineView];
    }else {
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, cell.frame.size.height+70, KScreenWidth - 30, 1)];
        lineView.backgroundColor = Line_Color;
        [cell addSubview:lineView];
    }
    
    return cell;
}

- (void)createHardwareName {
    _hardwareName = [[UITextField alloc]initWithFrame:CELL_TextField_Frame];
    _hardwareName.delegate = self;
    _hardwareName.textColor = TextField_Text_Color;
    NSString *hardwareName = @"公司名称";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:hardwareName];
    [placeholder addAttribute:NSForegroundColorAttributeName
                        value:Placeholder_Color
                        range:NSMakeRange(0, hardwareName.length)];
    _hardwareName.attributedPlaceholder = placeholder;
    _hardwareName.font = [UIFont systemFontOfSize:16];
    _hardwareName.textAlignment = NSTextAlignmentLeft;
    _hardwareName.returnKeyType = UIReturnKeyDone;
}

- (void)createHardwareBrands {
    _hardwareBrands = [[UITextField alloc]initWithFrame:CELL_TextField_Frame];
    _hardwareBrands.delegate = self;
    _hardwareBrands.textColor = TextField_Text_Color;
    NSString *hardwareBrands = @"公司品牌";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:hardwareBrands];
    [placeholder addAttribute:NSForegroundColorAttributeName
                        value:Placeholder_Color
                        range:NSMakeRange(0, hardwareBrands.length)];
    _hardwareBrands.attributedPlaceholder = placeholder;
    _hardwareBrands.font = [UIFont systemFontOfSize:16];
    _hardwareBrands.textAlignment = NSTextAlignmentLeft;
    _hardwareBrands.returnKeyType = UIReturnKeyDone;
}

#warning 这里要选择
- (void)createHardwareDeviceType {
    _hardwareDeviceType = [[UITextField alloc]initWithFrame:CELL_TextField_Frame];
    _hardwareDeviceType.delegate = self;
    _hardwareDeviceType.textColor = TextField_Text_Color;
    NSString *hardwareDeviceType = @"设备类型";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:hardwareDeviceType];
    [placeholder addAttribute:NSForegroundColorAttributeName
                        value:Placeholder_Color
                        range:NSMakeRange(0, hardwareDeviceType.length)];
    _hardwareDeviceType.attributedPlaceholder = placeholder;
    _hardwareDeviceType.font = [UIFont systemFontOfSize:16];
    _hardwareDeviceType.textAlignment = NSTextAlignmentLeft;
}

- (void)creatHardwareType {
    
    _hardwareType = [[UITextField alloc]initWithFrame:CELL_TextField_Frame];
    _hardwareType.delegate = self;
    _hardwareType.textColor = TextField_Text_Color;
    NSString *hardwareType = @"公司类型";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:hardwareType];
    [placeholder addAttribute:NSForegroundColorAttributeName
                        value:Placeholder_Color
                        range:NSMakeRange(0, hardwareType.length)];
    _hardwareType.attributedPlaceholder = placeholder;
    _hardwareType.font = [UIFont systemFontOfSize:16];
    _hardwareType.textAlignment = NSTextAlignmentLeft;
    _hardwareType.returnKeyType = UIReturnKeyDone;
}

- (void)creatHardwareIndustry {
    
    _hardwareIndustry = [[UITextField alloc]initWithFrame:CELL_TextField_Frame];
    _hardwareIndustry.delegate = self;
    _hardwareIndustry.textColor = TextField_Text_Color;
    NSString *hardwareIndustry = @"公司行业";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:hardwareIndustry];
    [placeholder addAttribute:NSForegroundColorAttributeName
                        value:Placeholder_Color
                        range:NSMakeRange(0, hardwareIndustry.length)];
    _hardwareIndustry.attributedPlaceholder = placeholder;
    _hardwareIndustry.font = [UIFont systemFontOfSize:16];
    _hardwareIndustry.textAlignment = NSTextAlignmentLeft;
    _hardwareIndustry.returnKeyType = UIReturnKeyDone;
}

- (void)creatHardwareProfile {
    
    _hardwareProfile = [[UITextView alloc]initWithFrame:CGRectMake(KScreenWidth / 3 -5, 15, KScreenWidth - KScreenWidth/3 - 15, 90)];
    _hardwareProfile.backgroundColor = ViewController_Back_Color;
    _hardwareProfile.textColor = TextField_Text_Color;
    _hardwareProfile.font = [UIFont systemFontOfSize:16];
    _hardwareProfile.delegate = self;
    _hardwareProfile.textAlignment = NSTextAlignmentLeft;
    
    _placeholderLab = [[UILabel alloc] initWithFrame:CGRectMake(0, -8, _hardwareProfile.frame.size.width, 50)];
    _placeholderLab.text = @" 公司简介";
    _placeholderLab.textColor = Placeholder_Color;
    _placeholderLab.font = [UIFont systemFontOfSize:17];
    [_hardwareProfile addSubview:_placeholderLab];
    
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView {
    
    if ([textView.text length] == 0) {
        [_placeholderLab setHidden:NO];
    }else {
        [_placeholderLab setHidden:YES];
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark - 键盘响应
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [_hardwareName resignFirstResponder];
    [_hardwareBrands resignFirstResponder];
    [_hardwareType resignFirstResponder];
    [_hardwareIndustry resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
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

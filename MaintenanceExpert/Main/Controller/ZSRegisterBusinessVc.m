//
//  ZSRegisterBusinessVc.m
//  MaintenanceExpert
//
//  Created by xpc on 16/12/12.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSRegisterBusinessVc.h"
#import "ZSRegisterBusinessTwoVc.h"
#import "ZSDetailRegisterModel.h"

#define CELL_COUNT 4
#define CELL_HEIGHT 70

#define CELL_TextField_Frame CGRectMake(KScreenWidth / 3, 17, KScreenWidth - KScreenWidth/3 - 15, 40)

@interface ZSRegisterBusinessVc ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UITextViewDelegate>

{
    
    UITextField *_CompanyName;          //  公司名
    UITextField *_CompanyType;          //  公司类型（个体、外资、国企、其他）
    UITextField *_CompanyIndustry;      //  公司行业
    UITextView *_CompanyProfile;        //  公司简介
    
    UILabel *_placeholderLab;            //  公司简介placeholder
}

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *dataArr;

@end

@implementation ZSRegisterBusinessVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = ViewController_Back_Color;
    
    self.title = @"工程商";
    
    [self creatTableView];
    [self creatBussinessButton];
}

- (UIButton *)creatBussinessButton {
    
    UIButton *bussinessButton = [[UIButton alloc] initWithFrame:CGRectMake(30, CELL_HEIGHT * CELL_COUNT + 30 + 50, KScreenWidth - 60, Btn_NextAndOutLogin_Height)];
    [bussinessButton setBackgroundImage:[UIImage imageNamed:@"wancheng"] forState:UIControlStateNormal];
    [bussinessButton setBackgroundImage:[UIImage imageNamed:@"wancheng-hov"] forState:UIControlStateSelected];
    [bussinessButton setTitle:@"下一步" forState:UIControlStateNormal];
    [bussinessButton addTarget:self action:@selector(bussinessButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bussinessButton];
    
    return bussinessButton;
}

- (void)bussinessButtonClick {
    
    [ZSDetailRegisterModel shareRegist].company_name = _CompanyName.text;
    [ZSDetailRegisterModel shareRegist].compang_type = _CompanyType.text;
    [ZSDetailRegisterModel shareRegist].company_service = _CompanyIndustry.text;
    [ZSDetailRegisterModel shareRegist].company_info = _CompanyProfile.text;
    
    
    ZSRegisterBusinessTwoVc *two = [[ZSRegisterBusinessTwoVc alloc] init];
    [self.navigationController pushViewController:two animated:YES];
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
    
    if (indexPath.row != 3) {
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
    
    self.dataArr = [[NSArray alloc]initWithObjects:@"公司名称:",@"公司类型:",@"公司行业:",@"公司简介:", nil];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",_dataArr[indexPath.row]];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.textColor = Label_Color;
    
    
    if (indexPath.row == 0) {                             //公司名
        [self createCompanyName];
        [cell addSubview:_CompanyName];
    } else if (indexPath.row == 1) {                      //公司类型
        
        [self creatCompanyType];
        [cell addSubview:_CompanyType];
    } else if (indexPath.row == 2) {                      //公司行业
        
        [self creatCompanyIndustry];
        [cell addSubview:_CompanyIndustry];
    } else if (indexPath.row == 3) {                      //公司简介
        
        [self creatCompanyProfile];
        [cell addSubview:_CompanyProfile];
    } else {
        
    }
    
    if (indexPath.row != 3) {
        
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

- (void)createCompanyName {
    _CompanyName = [[UITextField alloc]initWithFrame:CELL_TextField_Frame];
    _CompanyName.delegate = self;
    _CompanyName.textColor = TextField_Text_Color;
    NSString *CompanyName = @"公司名称";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:CompanyName];
    [placeholder addAttribute:NSForegroundColorAttributeName
                        value:Placeholder_Color
                        range:NSMakeRange(0, CompanyName.length)];
    _CompanyName.attributedPlaceholder = placeholder;
    _CompanyName.font = [UIFont systemFontOfSize:16];
    _CompanyName.textAlignment = NSTextAlignmentLeft;
    _CompanyName.returnKeyType = UIReturnKeyDone;
}

- (void)creatCompanyType {
    
    _CompanyType = [[UITextField alloc]initWithFrame:CELL_TextField_Frame];
    _CompanyType.delegate = self;
    _CompanyType.textColor = TextField_Text_Color;
    NSString *CompanyType = @"公司类型";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:CompanyType];
    [placeholder addAttribute:NSForegroundColorAttributeName
                        value:Placeholder_Color
                        range:NSMakeRange(0, CompanyType.length)];
    _CompanyType.attributedPlaceholder = placeholder;
    _CompanyType.font = [UIFont systemFontOfSize:16];
    _CompanyType.textAlignment = NSTextAlignmentLeft;
    _CompanyType.returnKeyType = UIReturnKeyDone;
}

- (void)creatCompanyIndustry {
    
    _CompanyIndustry = [[UITextField alloc]initWithFrame:CELL_TextField_Frame];
    _CompanyIndustry.delegate = self;
    _CompanyIndustry.textColor = TextField_Text_Color;
    NSString *CompanyIndustry = @"公司行业";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:CompanyIndustry];
    [placeholder addAttribute:NSForegroundColorAttributeName
                        value:Placeholder_Color
                        range:NSMakeRange(0, CompanyIndustry.length)];
    _CompanyIndustry.attributedPlaceholder = placeholder;
    _CompanyIndustry.font = [UIFont systemFontOfSize:16];
    _CompanyIndustry.textAlignment = NSTextAlignmentLeft;
    _CompanyIndustry.returnKeyType = UIReturnKeyDone;
}

- (void)creatCompanyProfile {
    
    _CompanyProfile = [[UITextView alloc]initWithFrame:CGRectMake(KScreenWidth / 3 -5, 15, KScreenWidth - KScreenWidth/3 - 15, 90)];
    _CompanyProfile.backgroundColor = ViewController_Back_Color;
    _CompanyProfile.textColor = TextField_Text_Color;
    _CompanyProfile.font = [UIFont systemFontOfSize:16];
    _CompanyProfile.delegate = self;
    _CompanyProfile.textAlignment = NSTextAlignmentLeft;
    
    _placeholderLab = [[UILabel alloc] initWithFrame:CGRectMake(0, -8, _CompanyProfile.frame.size.width, 50)];
    _placeholderLab.text = @" 公司简介";
    _placeholderLab.textColor = Placeholder_Color;
    _placeholderLab.font = [UIFont systemFontOfSize:17];
    [_CompanyProfile addSubview:_placeholderLab];
    
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
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_CompanyName resignFirstResponder];
    [_CompanyType resignFirstResponder];
    [_CompanyIndustry resignFirstResponder];
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

//
//  ZSMineInfoViewController.m
//  MaintenanceExpert
//
//  Created by koka on 16/10/27.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSMineInfoViewController.h"
#import "ZSAlertView.h"
#import "MinedetailInformationViewController.h"
#import "MineInfModel.h"
#import "UIViewController+SelectPhotoIcon.h"
#import "ZSMineVIPViewController.h"


@interface ZSMineInfoViewController ()<UITableViewDataSource,UITableViewDelegate>

{
    NSMutableArray *_array1;
    NSMutableArray *_array2;
    UIImageView *_icon;
    UIImage *_iconimage;
    NSString *_name;
    NSString *_mineinfo;
    NSString *_address;
    NSString *_phoneNumb;
    
    
    UITableViewCell *_namecell;
    
    MineInfModel *_Model;
}

@property(nonatomic,strong)UITableView *tableview;
@property (strong, nonatomic) NSArray *mineInfoDataListArr;

@end


@implementation ZSMineInfoViewController

- (void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBarHidden = NO;

    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSData *data = [user objectForKey:@"USER"];
    MineInfModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    _Model = model;
//    NSLog(@"%@",_Model.MineInformation);
    
    //  刷新 个性签名Cell
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:1];
    [_tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
}

- (NSArray *)mineDataList {
    
    if (!_mineInfoDataListArr) {
        NSMutableDictionary *userIcon = [NSMutableDictionary dictionary];
        userIcon[@"title"] = @"头像";
        
        NSMutableDictionary *name = [NSMutableDictionary dictionary];
        name[@"title"] = @"昵称";
        
        NSMutableDictionary *address = [NSMutableDictionary dictionary];
        address[@"title"] = @"地区";
        
        NSMutableDictionary *qianming = [NSMutableDictionary dictionary];
        qianming[@"title"] = @"个性签名";
        
        NSMutableDictionary *phoneNub = [NSMutableDictionary dictionary];
        phoneNub[@"title"] = @"手机号";
        
        NSMutableDictionary *mineVip = [NSMutableDictionary dictionary];
        mineVip[@"title"] = @"会员特权";
        mineVip[@"controller"] = [ZSMineVIPViewController class];
        
        NSArray *section0 = @[userIcon, name, address];
        NSArray *section1 = @[qianming, phoneNub, mineVip];
        
        _mineInfoDataListArr = [NSArray arrayWithObjects:section0, section1, nil];
    }
    
    return _mineInfoDataListArr;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = ViewController_Back_Color;
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = ViewController_Back_Color;
    view.frame = CGRectMake(0, -64, KScreenWidth, 64);
    [self.view addSubview:view];
    
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(5, 10, KScreenWidth - 10, 44 * 6 + 60) style:UITableViewStyleGrouped];
    
    _tableview.backgroundColor = ViewController_Back_Color;
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.bounces = NO;
    _tableview.showsVerticalScrollIndicator = NO;
    _tableview.showsHorizontalScrollIndicator = NO;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableview];
    
    _namecell = [[UITableViewCell alloc]init];
    _iconimage = [[UIImage alloc]init];
    
    [self createDonebtn];
    [self creatAnimation];
}

- (void)creatAnimation {
    
    UIImageView *backimageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"OrderBackBig"]];
    backimageview.frame = CGRectMake(0, KScreenHeight/5 -64, KScreenWidth, KScreenWidth);
    
    CABasicAnimation *basicAnimation1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    basicAnimation1.fromValue = @(2*M_PI);
    basicAnimation1.toValue = @0;
    basicAnimation1.duration = 15;
    basicAnimation1.repeatCount = 20;
    basicAnimation1.removedOnCompletion = NO;
    basicAnimation1.fillMode = kCAFillModeBoth;
    [backimageview.layer addAnimation:basicAnimation1 forKey:@"rotation"];
    
    [self.view addSubview:backimageview];
    
}


- (void)createDonebtn {
    
    UIBarButtonItem *barbtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(Done)];
    self.navigationItem.rightBarButtonItem = barbtn;
    
}

- (void)Done {
    
    [self.navigationController popViewControllerAnimated:NO];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.mineDataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
   return [self.mineInfoDataListArr[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    
    cell.backgroundColor = UIView_BackView_color;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (!cell) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    }
    
    NSDictionary *dict = self.mineInfoDataListArr[indexPath.section][indexPath.row];
    cell.textLabel.text = dict[@"title"];
    cell.textLabel.textColor = Label_Color;
    
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) {
                
                _icon = [[UIImageView alloc] initWithFrame:CGRectMake(cell.frame.size.width - 30, 10, 40, 40)];
                _icon.backgroundColor = [UIColor blueColor];
                _icon.image = _Model.usericon;
                _icon.contentMode = UIViewContentModeScaleToFill;
                _icon.layer.cornerRadius = _icon.frame.size.width / 2;
                _icon.clipsToBounds = YES;
                
//                [cell.detailTextLabel addSubview:_icon];
                [cell.contentView addSubview:_icon];
            }
            if (indexPath.row == 1) {
                
                _namecell = cell;
                _name = _Model.username;
                cell.detailTextLabel.text = _name;
                cell.detailTextLabel.textColor = TextField_Text_Color;
                _Model.username = cell.detailTextLabel.text;
                /**
                 *  先取，改完再存
                 */
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_Model];
                NSUserDefaults *users = [NSUserDefaults standardUserDefaults];
                [users setObject:data forKey:@"USER"];
            }
            if (indexPath.row == 2) {
                
                cell.detailTextLabel.text = _address;
                cell.detailTextLabel.textColor = TextField_Text_Color;
            }
            break;
            
        case 1:
            if (indexPath.row == 0) {
                
                _mineinfo = _Model.MineInformation;
                cell.detailTextLabel.text = _mineinfo;
                cell.detailTextLabel.textColor = TextField_Text_Color;
            }
            if (indexPath.row == 1) {
                
                cell.detailTextLabel.text = _phoneNumb;
                cell.detailTextLabel.textColor = TextField_Text_Color;
            }
            
        default:
            break;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 60;
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.f;
}

#warning 改昵称时，数据传达，点开，数据保留
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section == 0 && indexPath.row == 0) {

        [self showActionSheet];
        
    }else if (indexPath.section == 0 && indexPath.row == 1) { //  昵称
        [ZSAlertView showAlertTextFieldViewWith:self title:nil message:@"请输入昵称" TextFeildCallBackBlock:^(NSString *text) {
            _Model.username = text;
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1 inSection:0];
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        } cancelButtonTitle:@"取消" otherButtonTitles:@"确定"];
        
    }else if (indexPath.section == 0 && indexPath.row == 2) { //  地区
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请输入地区" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        UITextField *textField = [alert textFieldAtIndex:0];
        _address = textField.text;
        [alert show];
    }else if (indexPath.section == 1 && indexPath.row == 0) { //  个性签名
        
        MinedetailInformationViewController *mineinf = [[MinedetailInformationViewController alloc]init];
        [self.navigationController pushViewController:mineinf animated:NO];
        
    }else if (indexPath.section == 1 && indexPath.row == 1) { //  手机号
#warning 这里 和 地区 还没有写入 model
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请输入手机号" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        UITextField *textField = [alert textFieldAtIndex:0];
        _phoneNumb = textField.text;
        [alert show];
    }else if (indexPath.section == 1 && indexPath.row == 2) { //  会员特权 跳转页面
        
        ZSMineVIPViewController *vipVc = [[ZSMineVIPViewController alloc] init];
        [self.navigationController pushViewController:vipVc animated:YES];
    }
}

//TODO:修改头像
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info;{
    
    //获得编辑后的图片
    UIImage *editedImage = (UIImage *)info[UIImagePickerControllerEditedImage];
    _iconimage= editedImage;
    
    _Model.usericon = _iconimage;
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_Model];
    NSUserDefaults *users = [NSUserDefaults standardUserDefaults];
    [users setObject:data forKey:@"USER"];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    [_tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    
    [picker dismissViewControllerAnimated:NO completion:nil];
}

@end

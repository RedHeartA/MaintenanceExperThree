//
//  STPickerArea.m
//  STPickerView
//
//  Created by https://github.com/STShenZhaoliang/STPickerView on 16/2/15.
//  Copyright © 2016年 shentian. All rights reserved.
//

#import "STPickerArea.h"
#import "ZSDetailOrderModel.h"
#import "ZSDetailRegisterModel.h"
@interface STPickerArea()<UIPickerViewDataSource, UIPickerViewDelegate>
{
    NSString *_procinceID;
    NSString *_cityID;
    NSString *_areaID;
}
/** 1.数据源数组 */
@property (nonatomic, strong, nullable)NSMutableArray *arrayRoot;
/** 2.当前省数组 */
@property (nonatomic, strong, nullable)NSMutableArray *arrayProvince;
@property (nonatomic, strong, nullable)NSMutableArray *arrayProvinceID;
/** 3.当前城市数组 */
@property (nonatomic, strong, nullable)NSMutableArray *arrayCity;
@property (nonatomic, strong, nullable)NSMutableArray *arrayCityID;
/** 4.当前地区数组 */
@property (nonatomic, strong, nullable)NSMutableArray *arrayArea;
@property (nonatomic, strong, nullable)NSMutableArray *arrayAreaID;
/** 5.当前选中数组 */
@property (nonatomic, strong, nullable)NSMutableArray *arraySelected;

/** 6.省份 */
@property (nonatomic, strong, nullable)NSString *province;
/** 7.城市 */
@property (nonatomic, strong, nullable)NSString *city;
/** 8.地区 */
@property (nonatomic, strong, nullable)NSString *area;

@end

@implementation STPickerArea

#pragma mark - --- init 视图初始化 ---

- (void)setupUI
{
    _procinceID = @"";
    _cityID = @"";
    _areaID = @"";
    // 1.获取数据
    [self.arrayRoot enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.arrayProvince addObject:obj[@"name"]];
        [self.arrayProvinceID addObject:obj[@"catid"]];
    }];

    NSMutableArray *citys = [NSMutableArray arrayWithArray:[self.arrayRoot firstObject][@"city"]];
    [citys enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.arrayCity addObject:obj[@"name"]];
        [self.arrayCityID addObject:obj[@"catid"]];
    }];

    NSMutableArray *array = [NSMutableArray array];
    NSMutableArray *arrayID = [NSMutableArray array];
    for (NSDictionary *dic in [citys firstObject][@"district"]) {
        [array addObject:[dic objectForKey:@"name"]];
        [arrayID addObject:[dic objectForKey:@"catid"]];
    }
    self.arrayArea = array;
    self.arrayAreaID = arrayID;
    //self.arrayArea = [citys firstObject][@"district"];

    
    self.province = self.arrayProvince[0];
    _procinceID = self.arrayProvinceID[0];
    self.city = self.arrayCity[0];
    _cityID = self.arrayCityID[0];
    
    if (self.arrayArea.count != 0) {
        self.area = self.arrayArea[0];
        _areaID = self.arrayAreaID[0];
    }else{
        self.area = @"";
    }
    
    // 2.设置视图的默认属性
    _heightPickerComponent = 32;
    [self setTitle:@"请选择城市地区"];
    [self.pickerView setDelegate:self];
    [self.pickerView setDataSource:self];

}
#pragma mark - --- delegate 视图委托 ---

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.arrayProvince.count;
    }else if (component == 1) {
        return self.arrayCity.count;
    }else{
        return self.arrayArea.count;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return self.heightPickerComponent;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        self.arraySelected = self.arrayRoot[row][@"city"];

        [self.arrayCity removeAllObjects];
        [self.arrayCityID removeAllObjects];
        [self.arraySelected enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.arrayCity addObject:obj[@"name"]];
            [self.arrayCityID addObject:obj[@"catid"]];
        }];

        NSMutableArray *array = [NSMutableArray array];
        NSMutableArray *arrayID = [NSMutableArray array];
        for (NSDictionary *dic in [NSMutableArray arrayWithArray:[self.arraySelected firstObject][@"district"]]) {
            [array addObject:[dic objectForKey:@"name"]];
            [arrayID addObject:[dic objectForKey:@"catid"]];
        }
        self.arrayArea = array;
        self.arrayAreaID = arrayID;
        

        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView selectRow:0 inComponent:2 animated:YES];

    }else if (component == 1) {
        if (self.arraySelected.count == 0) {
            self.arraySelected = [self.arrayRoot firstObject][@"city"];
        }
        NSMutableArray *array = [NSMutableArray array];
        NSMutableArray *arrayID = [NSMutableArray array];
       
        for (NSDictionary *dic in [NSMutableArray arrayWithArray:[self.arraySelected objectAtIndex:row][@"district"]]) {
            [array addObject:[dic objectForKey:@"name"]];
            [arrayID addObject:[dic objectForKey:@"catid"]];
        }
        self.arrayArea = array;
        self.arrayAreaID = arrayID;

        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];

    }else{
        
    }
    
    [self reloadData];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    
    NSString *text;
    if (component == 0) {
        text =  self.arrayProvince[row];
        _procinceID = self.arrayProvinceID[row];
    }else if (component == 1){
        text =  self.arrayCity[row];

    }else{
        if (self.arrayArea.count > 0) {
            text = self.arrayArea[row];
            _areaID = self.arrayAreaID[row];
        }else{
            text =  @"";
        }
    }
    
    UILabel *label = [[UILabel alloc]init];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont systemFontOfSize:17]];
    [label setText:text];
    return label;
}
#pragma mark - --- event response 事件相应 ---

- (void)selectedOk
{
    [self.delegate pickerArea:self province:self.province city:self.city area:self.area];
    [super selectedOk];
}

#pragma mark - --- private methods 私有方法 ---

- (void)reloadData
{
    NSInteger index0 = [self.pickerView selectedRowInComponent:0];
    NSInteger index1 = [self.pickerView selectedRowInComponent:1];
    NSInteger index2 = [self.pickerView selectedRowInComponent:2];
    self.province = self.arrayProvince[index0];
    _procinceID = self.arrayProvinceID[index0];
    self.city = self.arrayCity[index1];
    _cityID = self.arrayCityID[index1];
    if (self.arrayArea.count != 0) {
        self.area = self.arrayArea[index2];
        _areaID = self.arrayAreaID[index2];
    }else{
        self.area = @"";
    }
    
    NSString *title = [NSString stringWithFormat:@"%@ %@ %@", self.province, self.city, self.area];
    [self setTitle:title];
    NSLog(@"%@",title);
    
    NSString *titleID = [NSString stringWithFormat:@"%@ %@ %@", _procinceID, _cityID, _areaID];
    NSLog(@"%@",titleID);
    [ZSDetailRegisterModel shareRegist].prov_id = _procinceID;
    [ZSDetailRegisterModel shareRegist].city_id = _cityID;
    [ZSDetailRegisterModel shareRegist].dist_id = _areaID;
    
    //[ZSDetailOrderModel shareDetailOrder].Orderprov_id = _procinceID;
    //[ZSDetailOrderModel shareDetailOrder].Ordercity_id = _cityID;
    //[ZSDetailOrderModel shareDetailOrder].Orderdist_id = _areaID;
}

#pragma mark - --- setters 属性 ---

#pragma mark - --- getters 属性 ---

- (NSArray *)arrayRoot
{
    if (!_arrayRoot) {
        NSString *jsonStr = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ddd" ofType:@"json"] encoding:0 error:nil];
        NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
        _arrayRoot= [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    }
    return _arrayRoot;
}
- (NSMutableArray *)arrayProvinceID
{
    if (!_arrayProvinceID) {
        _arrayProvinceID = [NSMutableArray array];
    }
    return _arrayProvinceID;
}

- (NSMutableArray *)arrayCityID
{
    if (!_arrayCityID) {
        _arrayCityID = [NSMutableArray array];
    }
    return _arrayCityID;
}

- (NSMutableArray *)arrayAreaID
{
    if (!_arrayAreaID) {
        _arrayAreaID = [NSMutableArray array];
    }
    return _arrayAreaID;
}

- (NSMutableArray *)arrayProvince
{
    if (!_arrayProvince) {
        _arrayProvince = [NSMutableArray array];
    }
    return _arrayProvince;
}

- (NSMutableArray *)arrayCity
{
    if (!_arrayCity) {
        _arrayCity = [NSMutableArray array];
    }
    return _arrayCity;
}

- (NSMutableArray *)arrayArea
{
    if (!_arrayArea) {
        _arrayArea = [NSMutableArray array];
    }
    return _arrayArea;
}

- (NSMutableArray *)arraySelected
{
    if (!_arraySelected) {
        _arraySelected = [NSMutableArray array];
    }
    return _arraySelected;
}

@end



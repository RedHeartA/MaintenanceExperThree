//
//  ServiceKindTextField.m
//  fengzhuangbiaoge
//
//  Created by koka on 16/12/21.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ServiceKindTextField.h"

@implementation ServiceKindTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        self.textAlignment = NSTextAlignmentRight;
        
    }
    
    return self;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self resignFirstResponder];
    NSMutableArray *arrayData = [[NSMutableArray alloc]initWithObjects:@"安装主机和电池",@"更换主机",@"更换电池",@"维护", nil];
    STPickerSingle *pickerSingle = [[STPickerSingle alloc]init];
    [pickerSingle setArrayData:arrayData];
    [pickerSingle setTitle:@"请选择服务类型"];
    [pickerSingle setContentMode:STPickerContentModeCenter];
    [pickerSingle setDelegate:self];
    [pickerSingle show];
}

- (void)pickerSingle:(STPickerSingle *)pickerSingle selectedTitle:(NSString *)selectedTitle {
     NSString *text = [NSString stringWithFormat:@"%@", selectedTitle];
     self.text = text;
}

@end

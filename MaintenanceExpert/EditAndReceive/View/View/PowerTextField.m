//
//  PowerTextField.m
//  fengzhuangbiaoge
//
//  Created by koka on 16/12/21.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "PowerTextField.h"

@implementation PowerTextField

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
    NSMutableArray *arrayData = [[NSMutableArray alloc]initWithObjects:@"1 KVA",@"2 KVA",@"3 KVA",@"4 KVA",@"6 KVA",@"8 KVA",@"10 KVA",@"45 KVA",@"50 KVA", nil];
    STPickerSingle *pickerSingle = [[STPickerSingle alloc]init];
    [pickerSingle setArrayData:arrayData];
    [pickerSingle setTitle:@"请选择功率"];
    [pickerSingle setContentMode:STPickerContentModeCenter];
    [pickerSingle setDelegate:self];
    [pickerSingle show];
}

- (void)pickerSingle:(STPickerSingle *)pickerSingle selectedTitle:(NSString *)selectedTitle {
    NSString *text = [NSString stringWithFormat:@"%@", selectedTitle];
    self.text = text;
}

@end

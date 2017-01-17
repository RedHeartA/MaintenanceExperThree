//
//  TimeTextField.m
//  fengzhuangbiaoge
//
//  Created by koka on 16/12/21.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "TimeTextField.h"

@implementation TimeTextField

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
    STPickerDate *pickerDate = [[STPickerDate alloc]init];
    [pickerDate setDelegate:self];
    [pickerDate show];
}

- (void)pickerDate:(STPickerDate *)pickerDate year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    
    NSString *text = [NSString stringWithFormat:@"%ld年%ld月%ld日", year, month, day];
    self.text = text;
    
    NSLog(@"==%@",self.text);
}
@end

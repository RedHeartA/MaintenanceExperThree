//
//  NormalTextField.m
//  fengzhuangbiaoge
//
//  Created by koka on 16/12/21.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "NormalTextField.h"

@implementation NormalTextField

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
        self.returnKeyType = UIReturnKeyDone;
        
    }
    
    return self;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    [self resignFirstResponder];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self resignFirstResponder];
    return YES;
}



@end

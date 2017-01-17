//
//  HighWorkSelectView.m
//  fengzhuangbiaoge
//
//  Created by koka on 16/12/21.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "HighWorkSelectView.h"

@implementation HighWorkSelectView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles column:(NSInteger)column {
    if (self = [super initWithFrame:frame titles:titles column:column]) {
        self.tag = 2002;
        self.verticalMargin = 10;
        self.delegate =self;
        
        
    }
    return self;
}
- (void)btnSelectView:(ZHBtnSelectView *)btnSelectView selectedBtn:(ZHCustomBtn *)btn {
    self.selectType = BtnSelectTypeSingleChoose;
    self.currentHighWorkBtn.btnSelected = NO;
    self.currentHighWorkBtn = btn;
    btn.btnSelected = YES;
    if ([self.currentHighWorkBtn.titleLabel.text isEqualToString:@"是"]) {
        [ZSDetailOrderModel shareDetailOrder].HighWork = YES;
    }else{
        [ZSDetailOrderModel shareDetailOrder].HighWork = NO;
    }
}

@end

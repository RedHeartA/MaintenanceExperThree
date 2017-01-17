//
//  jiaoxianSeclectView.m
//  fengzhuangbiaoge
//
//  Created by koka on 16/12/21.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "jiaoxianSeclectView.h"

@implementation jiaoxianSeclectView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles column:(NSInteger)column {
    if (self = [super initWithFrame:frame titles:titles column:column]) {
        self.tag = 2003;
        self.verticalMargin = 10;
        self.delegate =self;
        
        
    }
    return self;
}
- (void)btnSelectView:(ZHBtnSelectView *)btnSelectView selectedBtn:(ZHCustomBtn *)btn {
    self.selectType = BtnSelectTypeSingleChoose;
    self.currentjiaoxianBtn.btnSelected = NO;
    self.currentjiaoxianBtn = btn;
    btn.btnSelected = YES;
    if ([self.currentjiaoxianBtn.titleLabel.text isEqualToString:@"是"]) {
        [ZSDetailOrderModel shareDetailOrder].Counties = YES;
    }else{
        [ZSDetailOrderModel shareDetailOrder].Counties = NO;
    }
}

@end

//
//  GuzhangdianSeclectView.m
//  fengzhuangbiaoge
//
//  Created by koka on 16/12/21.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "GuzhangdianSeclectView.h"

@implementation GuzhangdianSeclectView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles column:(NSInteger)column {
    if (self = [super initWithFrame:frame titles:titles column:column]) {
        self.tag = 2001;
        self.verticalMargin = 10;
        self.delegate =self;
        
        
    }
    return self;
}
- (void)btnSelectView:(ZHBtnSelectView *)btnSelectView selectedBtn:(ZHCustomBtn *)btn {
    self.selectType = BtnSelectTypeSingleChoose;
    self.currentguzhangdianBtn.btnSelected = NO;
    self.currentguzhangdianBtn = btn;
    btn.btnSelected = YES;
    if ([self.currentguzhangdianBtn.titleLabel.text isEqualToString:@"1-3"]) {
        [ZSDetailOrderModel shareDetailOrder].ProblemNum = 1;
    }if ([self.currentguzhangdianBtn.titleLabel.text isEqualToString:@"4-6"]) {
        [ZSDetailOrderModel shareDetailOrder].ProblemNum = 2;
    }if ([self.currentguzhangdianBtn.titleLabel.text isEqualToString:@"7-9"]) {
        [ZSDetailOrderModel shareDetailOrder].ProblemNum = 3;
    }if ([self.currentguzhangdianBtn.titleLabel.text isEqualToString:@"10-12"]) {
        [ZSDetailOrderModel shareDetailOrder].ProblemNum = 4;
    }if ([self.currentguzhangdianBtn.titleLabel.text isEqualToString:@"> 12"]) {
        [ZSDetailOrderModel shareDetailOrder].ProblemNum = 5;
    }

}


@end

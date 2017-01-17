//
//  DianchiZhujiLineSelectView.m
//  fengzhuangbiaoge
//
//  Created by koka on 16/12/21.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "DianchiZhujiLineSelectView.h"

@implementation DianchiZhujiLineSelectView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles column:(NSInteger)column {
    if (self = [super initWithFrame:frame titles:titles column:column]) {
        self.tag = 2005;
        self.verticalMargin = 10;
        self.delegate =self;
        
        
    }
    return self;
}
- (void)btnSelectView:(ZHBtnSelectView *)btnSelectView selectedBtn:(ZHCustomBtn *)btn {
    self.selectType = BtnSelectTypeSingleChoose;
    self.currentDianchilineBtn.btnSelected = NO;
    self.currentDianchilineBtn = btn;
    btn.btnSelected = YES;
}

@end

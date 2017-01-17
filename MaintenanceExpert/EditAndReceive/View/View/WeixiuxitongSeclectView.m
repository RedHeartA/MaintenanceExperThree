//
//  WeixiuxitongSeclectView.m
//  封装好的各种控件自动生成表格
//
//  Created by koka on 16/12/21.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "WeixiuxitongSeclectView.h"

@implementation WeixiuxitongSeclectView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles column:(NSInteger)column {
    if (self = [super initWithFrame:frame titles:titles column:column]) {
        self.tag = 2000;
        self.verticalMargin = 10;
        self.delegate =self;
        self.btnkindView = self;
        
        
    }
    return self;
}
- (void)btnSelectView:(ZHBtnSelectView *)btnSelectView selectedBtn:(ZHCustomBtn *)btn {
    self.selectType = BtnSelectTypeMultiChoose;
    btn.btnSelected = !btn.btnSelected;
    if (btn.btnSelected) {
        [self.titleArr addObject:btn.titleLabel.text];
    } else {
        [self.titleArr removeObject:btn.titleLabel.text];
    }
}



@end

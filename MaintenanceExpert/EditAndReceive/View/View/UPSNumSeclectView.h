//
//  UPSNumSeclectView.h
//  fengzhuangbiaoge
//
//  Created by koka on 16/12/21.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZHBtnSelectView.h"
#import "ZHCustomBtn.h"


/**
 *  UPS主机台数
 */
@interface UPSNumSeclectView : ZHBtnSelectView<ZHBtnSelectViewDelegate>

@property (nonatomic,strong)NSMutableArray *titleArr;

@property (nonatomic,weak)ZHBtnSelectView *btnUPSNumView;
@property (nonatomic,weak)ZHCustomBtn *currentUPSNumBtn;

@end

//
//  UPSPowerSeclectView.h
//  fengzhuangbiaoge
//
//  Created by koka on 16/12/21.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZHBtnSelectView.h"
#import "ZHCustomBtn.h"
/**
 *  UPS功率
 */
@interface UPSPowerSeclectView : ZHBtnSelectView<ZHBtnSelectViewDelegate>

@property (nonatomic,strong)NSMutableArray *titleArr;

@property (nonatomic,weak)ZHBtnSelectView *btnUPSPowerView;
@property (nonatomic,weak)ZHCustomBtn *currentUPSPowerBtn;


@end

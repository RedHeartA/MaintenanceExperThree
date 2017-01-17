//
//  DianchiZhujiLineSelectView.h
//  fengzhuangbiaoge
//
//  Created by koka on 16/12/21.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZHBtnSelectView.h"
#import "ZHCustomBtn.h"
/**
 *  电池主机间连线
 */
@interface DianchiZhujiLineSelectView : ZHBtnSelectView<ZHBtnSelectViewDelegate>

@property (nonatomic,strong)NSMutableArray *titleArr;

@property (nonatomic,weak)ZHBtnSelectView *btnDianchilineView;
@property (nonatomic,weak)ZHCustomBtn *currentDianchilineBtn;

@end

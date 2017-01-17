//
//  UPSKindSeclectView.h
//  fengzhuangbiaoge
//
//  Created by koka on 16/12/21.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZHBtnSelectView.h"
#import "ZHCustomBtn.h"
/**
 *  UPS类型
 */
@interface UPSKindSeclectView : ZHBtnSelectView<ZHBtnSelectViewDelegate>

@property (nonatomic,strong)NSMutableArray *titleArr;

@property (nonatomic,weak)ZHBtnSelectView *btnUPSKindView;
@property (nonatomic,weak)ZHCustomBtn *currentUPSKindBtn;


@end

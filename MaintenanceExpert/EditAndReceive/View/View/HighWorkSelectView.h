//
//  HighWorkSelectView.h
//  fengzhuangbiaoge
//
//  Created by koka on 16/12/21.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZHBtnSelectView.h"
#import "ZHCustomBtn.h"
/**
 *  高空作业
 */
@interface HighWorkSelectView : ZHBtnSelectView<ZHBtnSelectViewDelegate>
@property (nonatomic,strong)NSMutableArray *titleArr;

@property (nonatomic,weak)ZHBtnSelectView *btnHighWorkView;
@property (nonatomic,weak)ZHCustomBtn *currentHighWorkBtn;
@end

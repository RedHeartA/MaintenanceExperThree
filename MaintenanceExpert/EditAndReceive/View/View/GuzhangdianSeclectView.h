//
//  GuzhangdianSeclectView.h
//  fengzhuangbiaoge
//
//  Created by koka on 16/12/21.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZHBtnSelectView.h"
#import "ZHCustomBtn.h"
/**
 *  故障点
 */
@interface GuzhangdianSeclectView : ZHBtnSelectView<ZHBtnSelectViewDelegate>

@property (nonatomic,strong)NSMutableArray *titleArr;

@property (nonatomic,weak)ZHBtnSelectView *btnguzhangdianView;
@property (nonatomic,weak)ZHCustomBtn *currentguzhangdianBtn;


@end

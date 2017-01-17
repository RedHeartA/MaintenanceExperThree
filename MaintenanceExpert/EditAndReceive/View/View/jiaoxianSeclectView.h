//
//  jiaoxianSeclectView.h
//  fengzhuangbiaoge
//
//  Created by koka on 16/12/21.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZHBtnSelectView.h"
#import "ZHCustomBtn.h"
/**
 *  郊县
 */
@interface jiaoxianSeclectView : ZHBtnSelectView<ZHBtnSelectViewDelegate>
@property (nonatomic,strong)NSMutableArray *titleArr;

@property (nonatomic,weak)ZHBtnSelectView *btnjiaoxianView;
@property (nonatomic,weak)ZHCustomBtn *currentjiaoxianBtn;


@end

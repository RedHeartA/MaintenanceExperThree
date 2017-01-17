//
//  WeixiuxitongSeclectView.h
//  封装好的各种控件自动生成表格
//
//  Created by koka on 16/12/21.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZHBtnSelectView.h"
#import "ZHCustomBtn.h"

/**
 *  维修系统
 */

@interface WeixiuxitongSeclectView : ZHBtnSelectView<ZHBtnSelectViewDelegate>
@property (nonatomic,strong)NSMutableArray *titleArr;

@property (nonatomic,weak)ZHCustomBtn *currentkindBtn;
@property (nonatomic,weak)ZHBtnSelectView *btnkindView;

@end

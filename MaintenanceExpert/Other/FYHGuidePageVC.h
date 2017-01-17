//
//  FYHGuidePageVC.h
//  FYHScroViewLogDemo
//
//  Created by cyberzone on 16/4/27.
//  Copyright © 2016年 FYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FYHGuidePageVC : UIViewController

@property (nonatomic, strong) NSMutableArray *picArr;//设置启动图样式 Arr


+ (instancetype)sharedGuideVC;
- (void)fyhGuidePageWithPicArr:(NSMutableArray *)picArr;

@end

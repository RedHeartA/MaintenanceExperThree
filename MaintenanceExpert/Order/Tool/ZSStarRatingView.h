//
//  ZSStarRatingView.h
//  MaintenanceExpert
//
//  Created by xpc on 16/12/7.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol StarRatingDelegate <NSObject>

- (void)mannerGrade:(NSString *)grade withView:(UIView *)selfView;

@end

@interface ZSStarRatingView : UIView

@property (weak, nonatomic) id<StarRatingDelegate> delegate;

//  是否需要半星
@property (assign, nonatomic) BOOL isNeedHalf;
//  评分图片的宽
@property (assign, nonatomic) CGFloat imageWidth;
//  评分图片的高
@property (assign, nonatomic) CGFloat imageHeight;
//  图片数量
@property (assign, nonatomic) NSInteger imageCount;


@end

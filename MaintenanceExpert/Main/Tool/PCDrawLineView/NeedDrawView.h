//
//  NeedDrawView.h
//  PCAnimationDrayLine
//
//  Created by xpc on 16/12/22.
//  Copyright © 2016年 xpc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShapeView;

@interface NeedDrawView : UIView

{
    NSString *_curString;   //  当前要画的那个String
    CGPoint _curPoint;
    NSString *_needDrawString;  //  需要DrawRect的String
    
    int _titleIndex;    //  title的索引
    int _chargeIndex;   //  title显示结束 index+1
    int _lindex;        //  线条的索引
}

@property (strong, nonatomic, readonly) ShapeView *pathShapeView;
@property (strong, nonatomic) NSArray *titlePoints;
@property (strong, nonatomic) NSArray *titles;
@property (strong, nonatomic) NSTimer *timer;

- (void)setData:(NSArray *)array;

- (void)showLinesAnimationBegine;

@end

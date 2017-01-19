//
//  NeedDrawView.m
//  PCAnimationDrayLine
//
//  Created by xpc on 16/12/22.
//  Copyright © 2016年 xpc. All rights reserved.
//

#import "NeedDrawView.h"
#import "ShapeView.h"

static CFTimeInterval const kDuration = 2.0;    //  每条线 画出来的时间
static CGFloat const kPointDiameter = 7.0;

@interface NeedDrawView ()

@property (nonatomic, strong) NSMutableArray *allPoints;
@property (nonatomic, strong) NSMutableArray *curPoints;
@property (nonatomic, strong) NSMutableArray *curPointsRong;

@end


@implementation NeedDrawView


- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.opaque = NO;
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    
    self.userInteractionEnabled = YES;
    
    //  清除上一次的画板
    CGContextRef textRef = UIGraphicsGetCurrentContext();
    CGContextClearRect(textRef, rect);
    
    [self drawString:_needDrawString withPoint:_curPoint];
    
    
    //  前面已经显示的条目清空后 重新画一遍
    
    if (_chargeIndex) {
        
        for (int i = 0; i < _chargeIndex; i++) {
            
            [self drawString:[self.titles objectAtIndex:i] withPoint:[[self.titlePoints objectAtIndex:i] CGPointValue]];
        }
    }
}

#pragma mark - CustormAPI

- (void)setData:(NSArray *)array {
    
    //  文字
    NSArray *titlesArray = [NSArray arrayWithObjects:@"看见这个了吗",@"还有这一个",@"看见了就是成功了", nil];
    self.titles = [self handleArrayAllObjectWithNewlineCharacters:titlesArray];
    self.titlePoints = @[[NSValue valueWithCGPoint:CGPointMake(100, 10)], [NSValue valueWithCGPoint:CGPointMake(150, 30)], [NSValue valueWithCGPoint:CGPointMake(200, 50)]];
    
    //  画线 点的位置
    NSMutableArray *points1 = [NSMutableArray arrayWithObjects:[NSValue valueWithCGPoint:CGPointMake(33, 1)],
                               [NSValue valueWithCGPoint:CGPointMake(88, 1)],
                               [NSValue valueWithCGPoint:CGPointMake(93, 00)], nil];
    
    NSMutableArray *points2 = [NSMutableArray arrayWithObjects:[NSValue valueWithCGPoint:CGPointMake(344, 1)],
                               [NSValue valueWithCGPoint:CGPointMake(287, 1)],
                               [NSValue valueWithCGPoint:CGPointMake(284, 0)], nil];
    
    NSMutableArray *points3 = [NSMutableArray arrayWithObjects:[NSValue valueWithCGPoint:CGPointMake(12, 54)],
                               [NSValue valueWithCGPoint:CGPointMake(37, 66)],
                               [NSValue valueWithCGPoint:CGPointMake(375, 66)], nil];
    
    self.allPoints = [NSMutableArray arrayWithObjects:points1, points2, points3, nil];
    //  调用方法
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    
    [self showLinesAnimationBegine];    //  显示 线条 动画
    
//    [self showTitleAnimationBegine];    //  显示title动画
}




/**
 *
 *  线条 动态展示
 *
 *  @param
 *
 *  @return
 */
- (void)showLinesAnimationBegine {
    self.curPoints = [self.allPoints objectAtIndex:_lindex];
    //添加path的UIView
    ShapeView  *pathShapeView = [[ShapeView alloc] init];
    pathShapeView.backgroundColor = [UIColor clearColor];
    pathShapeView.opaque = NO;
    pathShapeView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:pathShapeView];
    
    //设置线条的颜色
    UIColor *pathColor = nil;
    switch (_lindex) {
        case 0:
            pathColor = [UIColor cyanColor];
            break;
        case 1:
            pathColor = [UIColor whiteColor];
            break;
        case 2:
            pathColor = [UIColor cyanColor];
            break;
        default:
            break;
    }
    pathShapeView.shapeLayer.fillColor = nil;
    pathShapeView.shapeLayer.strokeColor = pathColor.CGColor;
    
    //创建动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
    animation.fromValue = @0.0;
    animation.toValue = @1.0;
    animation.delegate = self;
    animation.duration = kDuration;
    [pathShapeView.shapeLayer addAnimation:animation forKey:NSStringFromSelector(@selector(strokeEnd))];
    [self updatePathsWithPathShapeView:pathShapeView];
}

- (void)updatePathsWithPathShapeView:(ShapeView *)pathShapeView {
    if ([self.curPoints count] >= 2) {
        UIBezierPath *path = [[UIBezierPath alloc] init];
        [path moveToPoint:[[self.curPoints firstObject] CGPointValue]];
        
        //设置路径的颜色和动画
        CGPoint point = [[self.curPoints firstObject] CGPointValue];
        
        //  第一个点
        [path appendPath:[UIBezierPath bezierPathWithArcCenter:point radius:0 startAngle:0.0 endAngle:0 clockwise:YES]];
        
        //   radius: 两条线之间的距离    endAngle:2 * M_PI  画圈用的
//      bezierPathWithArcCenter:[pointValue CGPointValue] radius:kPointDiameter / 2.0 startAngle:0.0 endAngle:2 * M_PI clockwise:YES]];
        
        //  其余的点
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(1, [self.curPoints count] - 1)];
        [self.curPoints enumerateObjectsAtIndexes:indexSet
                                          options:0
                                       usingBlock:^(NSValue *pointValue, NSUInteger idx, BOOL *stop) {
                                           [path addLineToPoint:[pointValue CGPointValue]];
                                           [path appendPath:[UIBezierPath bezierPathWithArcCenter:[pointValue CGPointValue] radius:0 startAngle:0.0 endAngle:0 clockwise:YES]];
                                       }];
        path.usesEvenOddFillRule = YES;
        pathShapeView.shapeLayer.path = path.CGPath;
    }
    else {
        pathShapeView.shapeLayer.path = nil;
    }
}

#pragma mark -----------
#pragma mark CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    _lindex++;
    if (_lindex == [self.allPoints count]) {
        _lindex = 0;
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        return;
    }
    [self showLinesAnimationBegine];
}





/**
 *
 *  文字动态展示     竖向
 *
 *  @param
 *
 *  @return
 */

//  文字（需求）
- (NSArray *)handleArrayAllObjectWithNewlineCharacters:(NSArray *)array {
    
    NSMutableArray *titles = [NSMutableArray arrayWithCapacity:[array count]];
    for (int i = 1; i <= [array count]; i++) {
        
        NSString *titlesString = [array objectAtIndex:i -1];
        NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:[titlesString length]];
        
        for (int m = 0; m < [titlesString length]; m++) {
            
            NSString *charS = [titlesString substringWithRange:NSMakeRange(m, 1)];
            [tempArray addObject:charS];
        }
        NSString *string = [tempArray componentsJoinedByString:@"\n"];
        [titles addObject:string];
    }
    return [titles copy];
}
//   动画开始
- (void)showTitleAnimationBegine {
    
    if (_titleIndex == [self.titles count]) {
        _chargeIndex = 0;
        _titleIndex = 0;
        return;
    }
    _curPoint = [[self.titlePoints objectAtIndex:_titleIndex] CGPointValue];
    _curString = [self.titles objectAtIndex:_titleIndex];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateCurrentString) userInfo:nil repeats:YES];
    _titleIndex++;
}
- (void)updateCurrentString {
    
    static int m = 1;
    if (m == [_curString length] + 1) {
        
        [self.timer invalidate];
        m = 1;
        ++_chargeIndex;
        [self showTitleAnimationBegine];
        return;
    } else {
        _needDrawString = [_curString substringWithRange:NSMakeRange(0, m)];
        m++;
        [self setNeedsDisplay];
    }
}
//  设置字体颜色，文本属性
- (void)drawString:(NSString *)text withPoint:(CGPoint)point {
    
    //  设置字体
    UIFont *font = [UIFont systemFontOfSize:20];
    UIColor *cyanColor = [UIColor cyanColor];
    //  设置文本字体属性
    NSDictionary *dic = @{NSFontAttributeName:font,
                          NSForegroundColorAttributeName:cyanColor};
    [text drawAtPoint:point withAttributes:dic];
}



@end

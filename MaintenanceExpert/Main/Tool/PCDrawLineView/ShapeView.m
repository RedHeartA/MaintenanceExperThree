//
//  ShapeView.m
//  PCAnimationDrayLine
//
//  Created by xpc on 16/12/22.
//  Copyright © 2016年 xpc. All rights reserved.
//

#import "ShapeView.h"

@implementation ShapeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


+ (Class)layerClass {
    
    return [CAShapeLayer class];
}

- (CAShapeLayer *)shapeLayer {
    
    return (CAShapeLayer *)self.layer;
}



@end

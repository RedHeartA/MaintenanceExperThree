//
//  ZSTabBar.m
//  MaintenanceExpert
//
//  Created by koka on 16/10/18.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSTabBar.h"
#import <objc/runtime.h>
#import "UIView+ZSExtension.h"

#define ZSMagin 10

@interface ZSTabBar ()

/** plus按钮 */
@property (nonatomic, weak) UIButton *plusBtn ;
@property (nonatomic,strong) UILabel *label;
@property (nonatomic) CGPoint inputPoint0;
@property (nonatomic) CGPoint inputPoint1;
@property (nonatomic) UIColor *inputColor0;
@property (nonatomic) UIColor *inputColor1;

@end

@implementation ZSTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
//        UIView *tabbarLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 1)];
//        tabbarLine.backgroundColor = [UIColor cyanColor];
//        [self addSubview:tabbarLine];
        
        UIButton *plusBtn = [[UIButton alloc] init];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"post_normal"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"post_normal"] forState:UIControlStateHighlighted];

        self.plusBtn = plusBtn;
        
        [plusBtn addTarget:self action:@selector(plusBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:plusBtn];
        self.backgroundColor = [UIColor blackColor];
        
        self.shadowImage = [[UIImage alloc] init];
    }
    return self;
    
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    //系统自带的按钮类型是UITabBarButton，找出这些类型的按钮，然后重新排布位置，空出中间的位置
    Class class = NSClassFromString(@"UITabBarButton");
    
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {
        self.plusBtn.centerX = KScreenWidth / 2 - self.plusBtn.currentBackgroundImage.size.width / 2;
        //调整发布按钮的中线点Y值
        self.plusBtn.centerY = self.height * 0.5 - 2*ZSMagin - 30 ;
    }else{
        self.plusBtn.centerX = self.centerX;
        //调整发布按钮的中线点Y值
        self.plusBtn.centerY = self.height * 0.5 - 2*ZSMagin ;
    }
    
    
    self.plusBtn.size = CGSizeMake(self.plusBtn.currentBackgroundImage.size.width, self.plusBtn.currentBackgroundImage.size.height);
    
        _label = [[UILabel alloc] init];
        _label.text = @"发布";
        _label.font = [UIFont systemFontOfSize:11];
        [_label sizeToFit];
        _label.textColor = ColorWithRGBA(108, 185, 197, 1);
        _label.backgroundColor =ColorWithRGBA(2, 19, 56, 1);
        [self addSubview:_label];
        _label.centerX = self.plusBtn.centerX;
        _label.centerY = CGRectGetMaxY(self.plusBtn.frame) + 8 ;

    
    int btnIndex = 0;
    for (UIView *btn in self.subviews) {//遍历tabbar的子控件
        if ([btn isKindOfClass:class]) {//如果是系统的UITabBarButton，那么就调整子控件位置，空出中间位置
            //每一个按钮的宽度==tabbar的五分之一
            btn.width = self.width / 5;
            
            btn.x = btn.width * btnIndex;
            
            btnIndex++;
            //如果是索引是2(从0开始的)，直接让索引++，目的就是让消息按钮的位置向右移动，空出来发布按钮的位置
            if (btnIndex == 2) {
                btnIndex++;
            }
            
        }
    }
    
    [self bringSubviewToFront:self.plusBtn];
}



//点击了发布按钮
- (void)plusBtnDidClick
{
    if ([self.delegate respondsToSelector:@selector(tabBarPlusBtnClick:)]) {
        [self.myDelegate tabBarPlusBtnClick:self];
    }
    
}

//重写hitTest方法，去监听发布按钮的点击，目的是为了让凸出的部分点击也有反应
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    //这一个判断是关键，不判断的话push到其他页面，点击发布按钮的位置也是会有反应的，这样就不好了
    //self.isHidden == NO 说明当前页面是有tabbar的，那么肯定是在导航控制器的根控制器页面
    //在导航控制器根控制器页面，那么我们就需要判断手指点击的位置是否在发布按钮身上
    //是的话让发布按钮自己处理点击事件，不是的话让系统去处理点击事件就可以了
    if (self.isHidden == NO) {
        
        //将当前tabbar的触摸点转换坐标系，转换到发布按钮的身上，生成一个新的点
        CGPoint newP = [self convertPoint:point toView:self.plusBtn];
        
        //判断如果这个新的点是在发布按钮身上，那么处理点击事件最合适的view就是发布按钮
        if ( [self.plusBtn pointInside:newP withEvent:event]) {
            return self.plusBtn;
        }else{//如果点不在发布按钮身上，直接让系统处理就可以了
            
            return [super hitTest:point withEvent:event];
        }
    }
    
    else {//tabbar隐藏了，那么说明已经push到其他的页面了，这个时候还是让系统去判断最合适的view处理就好了
        return [super hitTest:point withEvent:event];
    }
}



@end
//
//  OrderScrollView.h
//  fengzhuangbiaoge
//
//  Created by koka on 16/12/21.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderScrollView : UIScrollView<UIScrollViewDelegate>{
    NSInteger index;
    UILabel *label;
    UIImageView *LineImage;
}

@end

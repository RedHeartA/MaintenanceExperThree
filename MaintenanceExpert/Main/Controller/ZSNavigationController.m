//
//  ZSNavigationController.m
//  MaintenanceExpert
//
//  Created by koka on 16/10/18.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSNavigationController.h"
#import "UIImage+Image.h"
#import "ZSTabBarController.h"

//导航栏
#define NavBarColor [UIColor colorWithRed:9.0/255.0 green:13.0/255.0 blue:29.0/255.0 alpha:1.0]

@interface ZSNavigationController ()
{
    
    UIWebView *webView;
    
}
@end

@implementation ZSNavigationController

+ (void)load
{
    
    
    UIBarButtonItem *item=[UIBarButtonItem appearanceWhenContainedIn:self, nil ];
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    dic[NSFontAttributeName]=[UIFont systemFontOfSize:17];
    dic[NSForegroundColorAttributeName] = ColorWithRGBA(44, 161, 229, 1);
    [item setTitleTextAttributes:dic forState:UIControlStateNormal];
    
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
  
    
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[self]];
        //此处修改导航栏的颜色，或者是添加图片
    [bar setBackgroundImage:[UIImage imageWithColor:NavBarColor] forBarMetrics:UIBarMetricsDefault];
    //[bar setBackgroundColor:NavBarColor];
    //[bar setBackgroundImage:[UIImage imageNamed:@"navgation"] forBarMetrics:UIBarMetricsDefault];
    NSMutableDictionary *dicBar=[NSMutableDictionary dictionary];
    
    dicBar[NSFontAttributeName]=[UIFont systemFontOfSize:15];
    [bar setTitleTextAttributes:dic];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.alpha = 0.0;
    self.navigationBar.barStyle = UIBarStyleBlackTranslucent;
//    self.view.backgroundColor = ColorWithRGBA(13, 29, 52, 1);
    self.view.backgroundColor = ViewController_Back_Color;
    
    self.navigationBar.shadowImage = [[UIImage alloc] init];
    self.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 42, KScreenWidth, 2)];
    view.backgroundColor = ColorWithRGBA(20, 31, 63, 1);
    [self.navigationBar addSubview:view];
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 44)];
    
    if (iPhone5SE) {
        image.image =[UIImage imageNamed:@"navgation_5s"];
    }else if (iPhone6_6s) {
        
        image.image =[UIImage imageNamed:@"navgation"];
    }else if (iPhone6Plus_6sPlus) {
        
        image.image =[UIImage imageNamed:@"navgation_plus"];
    }
    //image.backgroundColor = ColorWithRGBA(13, 29, 52, 1);
    image.contentMode = UIViewContentModeScaleAspectFit;
    [self.navigationBar addSubview:image];
    self.navigationBarHidden = YES;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.viewControllers.count > 0) {
        
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tintColor = ColorWithRGBA(27, 135, 200, 1);
        btn.frame = CGRectMake(15, 8, 53.5, 23.5);
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setBackgroundImage:[UIImage imageNamed:@"backbackgroundimage"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(goBackAction) forControlEvents: UIControlEventTouchUpInside];
        [btn setTitle:@"返回" forState:UIControlStateNormal];
        [btn setTitleColor:TextField_Text_Color forState:UIControlStateNormal];
        UIBarButtonItem * back=[[UIBarButtonItem alloc]initWithCustomView:btn];
        viewController.navigationItem.leftBarButtonItem = back;
        
    }
    
    return [super pushViewController:viewController animated:animated];
    
}

-(void)goBackAction{
    
    // 在这里增加返回按钮的自定义动作
    
    [self popViewControllerAnimated:YES];
    
}

@end

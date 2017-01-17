//
//  Basicmapview.m
//  MaintenanceExpert
//
//  Created by koka on 16/12/28.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "Basicmapview.h"


@interface Basicmapview ()<CLLocationManagerDelegate,MKMapViewDelegate>
{
     CLLocationManager *locationManager;
    CLLocationCoordinate2D loc;
}
@end

@implementation Basicmapview

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.showsUserLocation = YES;
        self.delegate = self;
        [self initLocation];
        [self createAnnotation];
    }
    return self;
}
//添加大头针
- (void)createAnnotation{
    //CLLocationDegrees latitude, CLLocationDegrees longitude
    //NSMutableArray *latitudearray =[NSMutableArray array];
   // NSMutableArray *longitudearray =[NSMutableArray array];
    CLLocationDegrees latitude = 36.09175073;
    CLLocationDegrees longitude = 120.37920730;
    
    MKPointAnnotation *annotation0 = [[MKPointAnnotation alloc] init];
    [annotation0 setCoordinate:CLLocationCoordinate2DMake(latitude, longitude)];
    [annotation0 setTitle:@"青岛西王大厦"];
    [annotation0 setSubtitle:@"XXX公司机房"];
    
    MKPointAnnotation *annotation1 = [[MKPointAnnotation alloc] init];
    [annotation1 setCoordinate:CLLocationCoordinate2DMake(36.09275073, 120.38520730)];
    [annotation1 setTitle:@"青岛南京路"];
    [annotation1 setSubtitle:@"XXX公司"];
    

    
    
    [self addAnnotation:annotation0];
    [self addAnnotation:annotation1];

}


-(void)initLocation {
    if (nil == locationManager)
        locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0){
        [locationManager requestWhenInUseAuthorization];
    }
    if(![CLLocationManager locationServicesEnabled]){
        NSLog(@"请开启定位:设置 > 隐私 > 位置 > 定位服务");
    }
    if([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        //[locationManager requestAlwaysAuthorization]; // 永久授权
        [locationManager requestWhenInUseAuthorization]; //使用中授权
    }
    [locationManager startUpdatingLocation];
    
    
    
}



- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    // If it's a relatively recent event, turn off updates to save power.
    CLLocation* location = [locations lastObject];
    NSLog(@"didUpdateLocations:%@",location);
    [locationManager stopUpdatingLocation];
    
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    
    loc = [userLocation coordinate];
    //放大地图到自身的经纬度位置。
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 500, 500);
    [self setRegion:region animated:YES];
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    // If the annotation is the user location, just return nil.（如果是显示用户位置的Annotation,则使用默认的蓝色圆点）
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    if ([annotation isKindOfClass:[MKPointAnnotation class]]) {
        // Try to dequeue an existing pin view first.（这里跟UITableView的重用差不多）
        
         MKAnnotationView* aView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"MKPointAnnotation"];

        
        aView.image = [UIImage imageNamed:@"jifang"];
        aView.canShowCallout = YES;
        UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 50)];
        rightButton.backgroundColor = UIView_BackView_color;
        [rightButton setTitle:@"导航" forState:UIControlStateNormal];
        
        aView.rightCalloutAccessoryView = rightButton;
        
        // Add a custom image to the left side of the callout.（设置弹出起泡的左面图片）
        UIImageView *myCustomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"myimage"]];
        aView.leftCalloutAccessoryView = myCustomImage;
        return aView;
        
        
    }
    
    return nil;//返回nil代表使用默认样式
}


-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    NSLog(@"点击了查看详情");
}


@end

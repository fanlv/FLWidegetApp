//
//  ViewController.m
//  FLWidegetApp
//
//  Created by Fan Lv on 14/12/10.
//  Copyright (c) 2014年 FanLv. All rights reserved.
//

#import "ViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import <objc/runtime.h>
//#import <CoreLocation/CoreLocation.h>



@interface CLLocationManager

+ (id)sharedManager;
+ (BOOL)locationServicesEnabled;
+ (void)setLocationServicesEnabled:(BOOL)enabled;
+ (BOOL)locationServicesEnabled:(BOOL)arg1;
+ (int)authorizationStatusForBundleIdentifier:(id)arg1;

@end





@interface ViewController ()
{
    CLLocationManager *locationManager;
}
@property (weak, nonatomic) IBOutlet UILabel *showLabel;
@property (weak, nonatomic) IBOutlet UISwitch *mySwitch;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    id CLLocationManager1 = objc_getClass("CLLocationManager");
    
    self.mySwitch.on = [CLLocationManager locationServicesEnabled];
    int author = [CLLocationManager1 authorizationStatusForBundleIdentifier:@"com.haoqi.Droponto"];
    
    NSLog(@"%d",author);
    
    
}



- (IBAction)showWidget:(UISwitch *)sender
{
    id CLLocationManager1 = objc_getClass("CLLocationManager");
    [CLLocationManager1 setLocationServicesEnabled:sender.on];
    [CLLocationManager1 locationServicesEnabled:sender.on];

    
//    id CLLocationManager2 = [objc_getClass("CLLocationManager") sharedManager];
//
//    
//    [CLLocationManager2 setLocationServicesPreferencesDialogEnabled:NO];
//    
//    
//    
//    
//    [CLLocationManager1 setAuthorizationStatus:sender.on forBundleIdentifier:@"com.haoqi.Droponto"];
//

//    [[NCWidgetController widgetController] setHasContent:sender.on
//                           forWidgetWithBundleIdentifier:@"com.cocoabit.Widget.Shortcuts"];
}








@end















































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
#import <CoreLocation/CoreLocation.h>
@interface CLLocationManager (iOS8)
+ (BOOL)locationServicesEnabled;
//+ (void)setLocationServicesEnabled:(BOOL)newValue;

+ (void)setLocationServicesEnabled:(bool)arg1;
@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showWidget:(UISwitch *)sender
{
    NSLog(@"%d",sender.on);
    [objc_getClass("CLLocationManager") setLocationServicesEnabled:sender.on];

    
    
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"prefs:root=LOCATION_SERVICES"]];
//
//    [[NCWidgetController widgetController] setHasContent:sender.on
//                           forWidgetWithBundleIdentifier:@"com.cocoabit.Widget.Shortcuts"];
}

@end

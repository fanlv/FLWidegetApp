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


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *showLabel;
@property (weak, nonatomic) IBOutlet UISwitch *mySwitch;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

}


- (IBAction)showWidget:(UISwitch *)sender
{
    
//    [[NCWidgetController widgetController] setHasContent:sender.on
//                           forWidgetWithBundleIdentifier:@"com.cocoabit.Widget.Shortcuts"];
}






@end















































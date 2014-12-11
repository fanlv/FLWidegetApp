//
//  TodayViewController.m
//  FanLvWidget
//
//  Created by Fan Lv on 14/12/10.
//  Copyright (c) 2014年 FanLv. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import <objc/runtime.h>
#import <notify.h>
#import <CoreLocation/CoreLocation.h>

//@interface CLLocationManager (iOS8)
//+ (BOOL)locationServicesEnabled;
//+ (void)setLocationServicesEnabled:(BOOL)newValue;
//@end


extern BOOL CTCellularDataPlanGetIsEnabled();   // 查询
extern void CTCellularDataPlanSetIsEnabled(BOOL enabled);   // 设置


//@interface CLLocationManager (iOS8)
//+ (BOOL)locationServicesEnabled;
//+ (void)setLocationServicesEnabled:(BOOL)newValue;
//@end


@interface TodayViewController () <NCWidgetProviding>

@property (weak, nonatomic) IBOutlet UIButton *cellularBtn;
@property (weak, nonatomic) IBOutlet UIButton *locationBtn;

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.preferredContentSize = CGSizeMake(0, 60);
    self.cellularBtn.selected = CTCellularDataPlanGetIsEnabled();
    self.locationBtn.selected = [CLLocationManager locationServicesEnabled];
}


#pragma mark - Action

- (IBAction)dataSwitchClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    CTCellularDataPlanSetIsEnabled(sender.selected);
}

- (IBAction)locationSwitchClick:(UIButton *)sender
{
//    sender.selected = !sender.selected;
//
//    id CLLocationManager1 = objc_getClass("CLLocationManager");
//    if([CLLocationManager1 respondsToSelector:@selector(setLocationServicesEnabled:)])
//    {
//        [CLLocationManager1 performSelector:@selector(setLocationServicesEnabled) withObject:NO]; //setLocationServicesEnabled:sender.selected];
//    }
//    BOOL b= [CLLocationManager locationServicesEnabled];
//     NSLog(@"%d",b);

}


- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)margins
{
    margins.bottom = 0.0;
    return margins;
}

@end

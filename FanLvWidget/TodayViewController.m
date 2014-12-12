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



//----------------------------定位相关----------------------------
@interface CLLocationManager (iOS8)
+ (BOOL)locationServicesEnabled;
+ (void)setLocationServicesEnabled:(BOOL)newValue;
@end


@interface LocationServicesListController
+ (BOOL)isLocationRestricted;
+ (void)setCoreRoutineAuthorized:(BOOL)arg1;
@end

//----------------------------------------------------------------


//----------------------------DATA 开关API------------------------
extern BOOL CTCellularDataPlanGetIsEnabled();   // 查询
extern void CTCellularDataPlanSetIsEnabled(BOOL enabled);   // 设置
//----------------------------------------------------------------


//----------------------------3g/4G 开关API------------------------
extern CFStringRef const kCTRegistrationDataStatusChangedNotification;
extern CFStringRef const kCTRegistrationDataRateUnknown;
extern CFStringRef const kCTRegistrationDataRate2G;
extern CFStringRef const kCTRegistrationDataRate3G;
extern CFStringRef const kCTRegistrationDataRate4G;
CFArrayRef CTRegistrationCopySupportedDataRates();
CFStringRef CTRegistrationGetCurrentMaxAllowedDataRate();
void CTRegistrationSetMaxAllowedDataRate(CFStringRef dataRate);
//----------------------------------------------------------------


@interface TodayViewController () <NCWidgetProviding>

@property (weak, nonatomic) IBOutlet UIButton *cellularBtn;
@property (weak, nonatomic) IBOutlet UIButton *locationBtn;
@property (weak, nonatomic) IBOutlet UIButton *_4GDataBtn;

@end

@implementation TodayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.preferredContentSize = CGSizeMake(0, 60);
    self.cellularBtn.selected = [self getCellDataState];
    self.locationBtn.selected = [CLLocationManager locationServicesEnabled];
    self._4GDataBtn.selected = [self is4GOR3GStateOn];
    
}



#pragma mark - Action

- (IBAction)dataSwitchClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    [self setCellDataState:sender.selected];
}


- (IBAction)FourGDataBtnClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    [self set4GState:sender.selected];
}

- (IBAction)locationSwitchClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
//    [objc_getClass("CLLocationManager") setLocationServicesEnabled:sender.selected];
//    BOOL b= [CLLocationManager locationServicesEnabled];
//    NSLog(@"%d",b);
}

#pragma mark - NCWidgetProviding Delegate

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler
{
    completionHandler(NCUpdateResultNewData);
}

- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)margins
{
    margins.bottom = 0.0;
    return margins;
}

#pragma mark - Data 开关

- (BOOL)getCellDataState
{
    return CTCellularDataPlanGetIsEnabled();
}


- (void)setCellDataState:(BOOL)enable
{
    CTCellularDataPlanSetIsEnabled(enable);
}


#pragma mark - 4G Or 3G 开关

///检查4G/3G开关是否打开（不支持4G的手机是看3G是否打开）
- (BOOL)is4GOR3GStateOn
{
    BOOL retVal = NO;
    CFStringRef currentDataRates = CTRegistrationGetCurrentMaxAllowedDataRate();
    if([self supportLte])
    {
        if(currentDataRates == kCTRegistrationDataRate4G)
            retVal = YES;
    }
    else
    {
        if (currentDataRates == kCTRegistrationDataRate3G)
            retVal = YES;
    }
    return retVal;
    
}


-(void)set4GState:(BOOL)enable
{
    if (!CTCellularDataPlanGetIsEnabled())
    {
        return;
    }
    
    BOOL currentStatus = [self is4GOR3GStateOn];
    if (currentStatus && !enable)
    {
        if (![self supportLte])//不支持4G的手机用2G
        {
            CTRegistrationSetMaxAllowedDataRate(kCTRegistrationDataRate2G);
        }
        else//支持4G关掉手机以后只能用3G
        {
            CTRegistrationSetMaxAllowedDataRate(kCTRegistrationDataRate3G);
        }
        return;
    }
    if (!currentStatus && enable)
    {
        if ([self supportLte])
        {
            CTRegistrationSetMaxAllowedDataRate(kCTRegistrationDataRate4G);
            return;
        }
        else {
            CTRegistrationSetMaxAllowedDataRate(kCTRegistrationDataRate3G);
            return;
        }
    }
}



- (BOOL)supportLte
{
    CFArrayRef supportedDataRates = CTRegistrationCopySupportedDataRates();
    if (supportedDataRates) {
        if ([(__bridge NSArray *)supportedDataRates containsObject:(__bridge id)kCTRegistrationDataRate3G])
        {
            if ([(__bridge NSArray *)supportedDataRates containsObject:(__bridge id)kCTRegistrationDataRate4G])
            {
                return YES;
            }
        }
    }
    return NO;
}






@end




































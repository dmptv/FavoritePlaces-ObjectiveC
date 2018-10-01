//
//  CurrentLocationViewController.m
//  FavoritePlaces
//
//  Created by 123 on 20.09.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

#import "CurrentLocationViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreData/CoreData.h>
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>
#import "UIViewController+Alert.h"
#import "KAContainerView.h"
#import "KALogoButton.h"

static const CGFloat kSpinnerPadding = 15.f;
static const NSUInteger kSpinnerTag = 1000;

@interface CurrentLocationViewController () <CLLocationManagerDelegate, CAAnimationDelegate>

@property (weak, nonatomic) IBOutlet KAContainerView *containerView;
@property (weak, nonatomic) IBOutlet UIButton *getButton;

// location
@property (strong, nonatomic) CLLocationManager* locationManager;
@property (strong, nonatomic) CLLocation* location;
@property (assign, nonatomic) BOOL updatingLocation;
@property (strong, nonatomic) NSError* lastLocationError;


@end

@implementation CurrentLocationViewController {
    BOOL logoVisible;
    KALogoButton* logoButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.locationManager = [[CLLocationManager alloc] init];
    
    [self updateLabels];
}

#pragma mark - Helpers

- (void) makeLogoButton {
    KALogoButton* button = [KALogoButton buttonWithType:UIButtonTypeCustom superView:self.view];
    [button addTarget:self action:@selector(getLocation:)
              forControlEvents:UIControlEventTouchUpInside];
    logoButton = button;
}

- (void) setupSpinner {
    UIActivityIndicatorView* spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    CGFloat xCoord = CGRectGetMidX(self.containerView.messageLabel.frame);
    CGFloat yCoord = CGRectGetMidY(self.containerView.messageLabel.frame) + CGRectGetHeight(spinner.bounds) / 2 + kSpinnerPadding;
    CGPoint center = CGPointMake(xCoord, yCoord);
    spinner.center = center;
    [spinner startAnimating];
    spinner.tag = kSpinnerTag;
    [self.containerView addSubview:spinner];
}

#pragma mark - Methods

- (void) updateLabels {
    
    if (self.location) {
        
        NSLog(@"1");
        
    } else {
        
        if (self.lastLocationError) {
            
            NSLog(@"2");
            
        } else if (![CLLocationManager locationServicesEnabled]) {
            NSLog(@"3");
            
        } else if (self.updatingLocation) {
            NSLog(@"4");
        } else {
            NSLog(@"5");
            
            [self showLogoView];
        }
    }
    
}

- (void) showLogoView {
    if (!logoVisible) {
        logoVisible = YES;
        self.containerView.hidden = YES;
        if (!logoButton) {
            [self makeLogoButton];
        }
    }
    
}

- (void) hideLogoView {
    if (!logoVisible) { return; }
    logoVisible = NO;
    
    // containerView is placed outside the screen and moved to the center
    [self.containerView setAnimationInSuperView:self.view];
    
    // logo button slides out of the screen
    [logoButton slideOutAnimationInSuperview:self.view];
    
    // at the same time rotates around its center, giving impression that it’s rolling away
    [logoButton rotateOutAnimation];
}

#pragma mark - Actions

- (IBAction) getLocation:(id)sender {
    
    CLAuthorizationStatus authStatus = [CLLocationManager authorizationStatus];
    
    if (logoVisible) {
        [self hideLogoView];
    }
    
    if (authStatus == kCLAuthorizationStatusNotDetermined) {
        [self.locationManager requestWhenInUseAuthorization];
        return;
    }
    
    if ((authStatus == kCLAuthorizationStatusDenied) ||
        (authStatus == kCLAuthorizationStatusRestricted)) {
        [self showAlertWithTitle:@"Location Services Disabled"
                      andMessage:@"Please enable location services for this app in Settings."];
        return;
    }

    if (self.updatingLocation) {
        [self stopLocationManager];
    } else {
        self.location = nil;
        self.lastLocationError = nil;
        [self startLocationManager];
    }
    
    [self updateLabels];
    [self configureGetButton];
 
}

- (void) startLocationManager {
    
    if ([CLLocationManager locationServicesEnabled]) {
        NSLog(@"enabld");
    }
    
    
}

- (void) stopLocationManager {
    NSLog(@"stop location manager");
}

- (void) configureGetButton {
    
    if (self.updatingLocation) {
        [self.getButton setTitle:@"Stop" forState:UIControlStateNormal];
        
        if ([self.view viewWithTag:kSpinnerTag] == nil) {
            [self setupSpinner];
        }
    } else {
        [self.getButton setTitle:@"Get My Location" forState:UIControlStateNormal];
        
        
    }
}



#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError %@", error.description);
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations {
    NSLog(@"didUpdateLocations %@", locations.lastObject);

}

- (void)locationManager:(CLLocationManager *)manager
       didUpdateHeading:(CLHeading *)newHeading {
    NSLog(@"didUpdateHeading %@", newHeading);
}

- (BOOL)locationManagerShouldDisplayHeadingCalibration:(CLLocationManager *)manager {
    NSLog(@"locationManagerShouldDisplayHeadingCalibration ");

    return YES;
}

- (void)locationManager:(CLLocationManager *)manager
        didRangeBeacons:(NSArray<CLBeacon *> *)beacons {
    NSLog(@"didRangeBeacons %@", beacons);
}

- (void)locationManager:(CLLocationManager *)manager
rangingBeaconsDidFailForRegion:(CLBeaconRegion *)region
              withError:(NSError *)error {
    NSLog(@"rangingBeaconsDidFailForRegion %@", error.description);
}

- (void)locationManager:(CLLocationManager *)manager
         didEnterRegion:(CLRegion *)region {
     NSLog(@"didEnterRegion %@", region);
}


- (void)locationManager:(CLLocationManager *)manager
          didExitRegion:(CLRegion *)region {
    
    NSLog(@"didExitRegion %@", region);
}

- (void)locationManager:(CLLocationManager *)manager
monitoringDidFailForRegion:(nullable CLRegion *)region
              withError:(NSError *)error {
    NSLog(@"monitoringDidFailForRegion %@", error.description);
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    NSLog(@"didChangeAuthorizationStatus %d", status);
}

- (void)locationManager:(CLLocationManager *)manager
didStartMonitoringForRegion:(CLRegion *)region {
    NSLog(@"didStartMonitoringForRegion %@", region);
}

- (void)locationManagerDidPauseLocationUpdates:(CLLocationManager *)manager {
    NSLog(@"locationManagerDidPauseLocationUpdates");
}

- (void)locationManagerDidResumeLocationUpdates:(CLLocationManager *)manager {
    NSLog(@"locationManagerDidResumeLocationUpdates");
}

- (void)locationManager:(CLLocationManager *)manager
didFinishDeferredUpdatesWithError:(nullable NSError *)error {
    NSLog(@"didFinishDeferredUpdatesWithError %@", error.description);
}

- (void)locationManager:(CLLocationManager *)manager didVisit:(CLVisit *)visit {
    NSLog(@"visit: %@", visit);
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    [self.containerView.layer removeAllAnimations];
    self.containerView.center = CGPointMake(CGRectGetWidth(self.view.bounds) / 2, 40.0 + CGRectGetHeight(self.containerView.bounds) / 2.0);
    
    [logoButton.layer removeAllAnimations];
    [logoButton removeFromSuperview];
}





@end







































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
    UIButton* logoButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.locationManager = [[CLLocationManager alloc] init];
    
    [self updateLabels];
}

#pragma mark - Helpers

- (void) makeLogoButton {
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tintColor = [UIColor colorNamed:@"tabbarTintcolor"];
    [button setBackgroundImage:[UIImage imageNamed:@"Logo"] forState:UIControlStateNormal];
    [button sizeToFit];
    [button addTarget:self action:@selector(getLocation:)
              forControlEvents:UIControlEventTouchUpInside];
    button.center = CGPointMake(CGRectGetMidX(self.view.bounds), 220.0);
    [self.view addSubview:button];
    
    logoButton = button;
}

- (void) setContainerViewAnimation {
    self.containerView.hidden = NO;
    CGFloat x = CGRectGetWidth(self.view.bounds) * 2.0;
    CGFloat y = 40 + CGRectGetHeight(self.containerView.bounds) / 2.0;
    self.containerView.center = CGPointMake(x, y);
    CGFloat centerX = CGRectGetMidX(self.view.bounds);
    
    CABasicAnimation* panelMover = [CABasicAnimation animationWithKeyPath:@"position"];
    [panelMover setRemovedOnCompletion:NO];
    panelMover.fillMode = kCAFillModeForwards;
    panelMover.duration = 0.6;
    panelMover.fromValue = [NSValue valueWithCGPoint:self.containerView.center];
    panelMover.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, self.containerView.center.y)];
    panelMover.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    __weak id weakSelf = self;
    [panelMover setDelegate:weakSelf];
    
    [self.containerView.layer addAnimation:panelMover forKey:@"panelMover"];
}

- (void) logoButtonSlideOutAnimation {
    CABasicAnimation* logoMover = [CABasicAnimation animationWithKeyPath:@"position"];
    [logoMover setRemovedOnCompletion:NO];
    logoMover.fillMode = kCAFillModeForwards;
    logoMover.duration = 0.5;
    logoMover.fromValue = [NSValue valueWithCGPoint:logoButton.center];
    logoMover.toValue = [NSValue valueWithCGPoint:CGPointMake(-CGRectGetMidX(self.view.bounds), logoButton.center.y)];
    logoMover.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [logoButton.layer addAnimation:logoMover forKey:@"logoMover"];
}

- (void) logoButtonRotateOutAnimation {
    CABasicAnimation* logoRotator = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    [logoRotator setRemovedOnCompletion:NO];
    logoRotator.fillMode = kCAFillModeForwards;
    logoRotator.duration = 0.5;
    logoRotator.fromValue = @0.0;
    logoRotator.toValue = @(M_PI * (-2));
    logoRotator.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [logoButton.layer addAnimation:logoRotator forKey:@"logoRotator"];
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
//        self.containerView.hidden = YES;
        if (!logoButton) {
            [self makeLogoButton];
        }
    }
    
}

- (void) hideLogoView {
    if (!logoVisible) { return; }
    logoVisible = NO;
    
    // containerView is placed outside the screen and moved to the center
    [self setContainerViewAnimation];
    
    // logo button slides out of the screen
    [self logoButtonSlideOutAnimation];
    
    // at the same time rotates around its center, giving impression that it’s rolling away
    [self logoButtonRotateOutAnimation];
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
            UIActivityIndicatorView* spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            CGFloat xCoord = CGRectGetMidX(self.containerView.messageLabel.frame);
            CGFloat yCoord = CGRectGetMidY(self.containerView.messageLabel.frame) + CGRectGetHeight(spinner.bounds) / 2 + kSpinnerPadding;
            CGPoint center = CGPointMake(xCoord, yCoord);
            spinner.center = center;
            [spinner startAnimating];
            spinner.tag = kSpinnerTag;
            [self.containerView addSubview:spinner];
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






































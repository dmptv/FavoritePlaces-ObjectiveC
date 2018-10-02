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
#import "KALocationManager.h"


static const NSUInteger kSpinnerTag = 1000;

@interface CurrentLocationViewController () 

@property (weak, nonatomic) IBOutlet KAContainerView *containerView;
@property (weak, nonatomic) IBOutlet UIButton *getButton;

@property (strong, nonatomic) KALocationManager* locationManager;

// - TO DO - abstract  reverse-geocoding -> KALocationManager wiil request it from other class and then pass that geocoding data to view controller


@end

@implementation CurrentLocationViewController {
    BOOL logoVisible;
    KALogoButton* logoButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.locationManager = [[KALocationManager alloc] init];
    self.locationManager.delegate = self;
    
    [self updateLabels];
}

#pragma mark - Helpers

- (void) makeLogoButton {
    KALogoButton* button = [KALogoButton buttonWithType:UIButtonTypeCustom superView:self.view];
    [button addTarget:self action:@selector(getLocation:)
              forControlEvents:UIControlEventTouchUpInside];
    logoButton = button;
}

#pragma mark - Methods

- (void) updateLabels {
    
    // - TO DO - implement labels
    
    if (self.locationManager.location) {
        
        NSLog(@"1");
        
    } else {
        
        if (self.locationManager.lastLocationError) {
            
            NSLog(@"2");
            
        } else if (![self.locationManager locationServicesEnabled]) {
            NSLog(@"3");
            
        } else if (self.locationManager.updatingLocation) {
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
    
    CLAuthorizationStatus authStatus = [self.locationManager authorizationStatus];
    
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

    if (self.locationManager.updatingLocation) {
        [self.locationManager stopLocationManager];
    } else {
        self.locationManager.location = nil;
        self.locationManager.lastLocationError = nil;
        [self.locationManager startLocationManager];
    }
    
    [self updateLabels];
    [self configureGetButton];
 
}

- (void) configureGetButton {
    
    if (self.locationManager.updatingLocation) {
        [self.getButton setTitle:@"Stop" forState:UIControlStateNormal];
        
        if ([self.view viewWithTag:kSpinnerTag] == nil) {
            [self.containerView spinnerWithTag:kSpinnerTag];
        }
    } else {
        [self.getButton setTitle:@"Get My Location" forState:UIControlStateNormal];
        
        
    }
}

#pragma mark - KALocationManagerDelegate

- (void) updateLocation:(CLLocation*) location {
    NSLog(@" ---> update location delegate");
    [self updateLabels];
}

- (void) configureButtonWithError:(nullable NSError*) error {
    NSLog(@" ---> configure button");
    [self configureGetButton];
}












@end







































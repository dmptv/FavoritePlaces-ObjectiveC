//
//  KALocationManager.m
//  FavoritePlaces
//
//  Created by 123 on 02.10.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

#import "KALocationManager.h"

@interface KALocationManager () <CLLocationManagerDelegate>

@property (strong, nonatomic) NSTimer* timer;
@property (strong, nonatomic) CLLocationManager* locationManager;

@end

@implementation KALocationManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        _locationManager = [[CLLocationManager alloc] init];
        _updatingLocation = NO;
    }
    return self;
}

#pragma mark - Public Methods

- (void) startLocationManager {
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        [self.locationManager startUpdatingLocation];
        self.updatingLocation = YES;
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(didTimeOut) userInfo:nil repeats:NO];
    }
}

- (void) stopLocationManager {
    if (self.updatingLocation) {
        [self.locationManager stopUpdatingLocation];
        self.locationManager.delegate = self;
        self.updatingLocation = NO;
        
        if (self.timer) {
            [self.timer invalidate];
        }
    }
}

- (CLAuthorizationStatus) authorizationStatus {
    return [CLLocationManager authorizationStatus];
}

- (void) requestWhenInUseAuthorization {
    [self.locationManager requestWhenInUseAuthorization];
}

- (BOOL) locationServicesEnabled {
    return [CLLocationManager locationServicesEnabled];
}

#pragma mark - Handles

- (void) didTimeOut {
    NSLog(@"*** Time out");
    
    if (!self.location) {
        [self stopLocationManager];
        
        self.lastLocationError = [NSError errorWithDomain:@"MY Location Error" code:1 userInfo:nil];
        /// send message to Vew Controller
        // updateLabels()
        // configureGetButton()
    }
}

#pragma mark - Private Methods

- (void) validateNewLocation:(CLLocation* ) newLocation {
    if (newLocation.timestamp.timeIntervalSinceNow < -5) {
        return;
    }
    if (newLocation.horizontalAccuracy < 0) {
        return;
    }
    
    [self configureLocationFromNewLocation:newLocation];
}

- (void) configureLocationFromNewLocation:(CLLocation* ) newLocation  {
    double distance = CLLocationDistanceMax;
    if (self.location) {
        distance = [newLocation distanceFromLocation:self.location];
    }
    
    if (!self.location || self.location.horizontalAccuracy > newLocation.horizontalAccuracy) {
        [self setupLocation:newLocation withDistance:distance];
        [self performGeocoding];
    } else if (distance < 1) {
        [self setupLocation:newLocation withDistanceAndTimeInterval:distance];
    }
}

- (void) setupLocation:(CLLocation* ) newLocation withDistance:(double ) distance {
    self.lastLocationError = nil;
    self.location = newLocation;
    /// send message to VC
    // updateLabels()
    
    if (newLocation.horizontalAccuracy <= self.locationManager.desiredAccuracy) {
        [self stopLocationManager];
        
        /// send message to VC
        // configureGetButton()
        
        if (distance > 0) {
            /// performingReverseGeocoding = false
        }
    }
}

- (void) setupLocation:(CLLocation* ) newLocation withDistanceAndTimeInterval:(double ) distance {
    NSTimeInterval timeInterval =
    [newLocation.timestamp timeIntervalSinceDate:self.location.timestamp];
    
    if (timeInterval > 10) {
        [self stopLocationManager];
        
        /// send message to VC
        // updateLabels()
        // configureGetButton()
    }
}


- (void) performGeocoding {
    
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError %@", error.description);
    
    if (error.code == kCLErrorLocationUnknown) {
        // keep trying until find a location or
        // receive a more serious error
        return;
    }
    
    // In the case of such a more serious error
    self.lastLocationError = error;
    [self stopLocationManager];
    
    /// send message to VC
    // updateLabels()
    // configureGetButton()
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation* newLocation = locations.lastObject;
    NSLog(@"*** locationManager didUpdateLocations %@", newLocation);
    
    [self validateNewLocation:newLocation];
}


@end




























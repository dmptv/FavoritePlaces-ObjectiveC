//
//  KALocationManager.h
//  FavoritePlaces
//
//  Created by 123 on 02.10.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol KALocationManagerDelegate;

NS_ASSUME_NONNULL_BEGIN

@interface KALocationManager : NSObject

@property (strong, nonatomic, nullable) CLLocation* location;
@property (strong, nonatomic, nullable) NSError* lastLocationError;
@property (assign, nonatomic) BOOL updatingLocation;

@property (weak, nonatomic) id<KALocationManagerDelegate> delegate;

- (void) startLocationManager;

- (void) stopLocationManager;

- (CLAuthorizationStatus) authorizationStatus;

- (void) requestWhenInUseAuthorization;

- (BOOL) locationServicesEnabled;

@end

NS_ASSUME_NONNULL_END

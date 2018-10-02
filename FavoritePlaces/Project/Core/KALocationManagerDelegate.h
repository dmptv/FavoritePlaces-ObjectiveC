//
//  KALocationManagerDelegate.h
//  FavoritePlaces
//
//  Created by 123 on 02.10.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


NS_ASSUME_NONNULL_BEGIN

@protocol KALocationManagerDelegate <NSObject>

@required

- (void) updateLocation:(CLLocation*) location;

@optional
- (void) configureButtonWithError:(nullable NSError*) error;

@end

NS_ASSUME_NONNULL_END

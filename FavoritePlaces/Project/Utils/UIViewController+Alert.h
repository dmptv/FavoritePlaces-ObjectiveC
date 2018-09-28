//
//  UIViewController+Alert.h
//  FavoritePlaces
//
//  Created by 123 on 28.09.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Alert)

- (void) showAlertWithTitle:(NSString*) title andMessage:(NSString*) message;

@end

NS_ASSUME_NONNULL_END

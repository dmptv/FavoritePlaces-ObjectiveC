//
//  KALogoButton.h
//  FavoritePlaces
//
//  Created by 123 on 01.10.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KALogoButton : UIButton

+ (instancetype)buttonWithType:(UIButtonType)buttonType superView:(UIView*) superView;
- (void) slideOutAnimationInSuperview:(UIView*) superview;
- (void) rotateOutAnimation;

@end

NS_ASSUME_NONNULL_END

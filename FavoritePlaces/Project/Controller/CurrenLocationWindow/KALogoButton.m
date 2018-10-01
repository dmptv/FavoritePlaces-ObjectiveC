//
//  KALogoButton.m
//  FavoritePlaces
//
//  Created by 123 on 01.10.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

#import "KALogoButton.h"

@implementation KALogoButton

+ (instancetype)buttonWithType:(UIButtonType)buttonType superView:(UIView*) superview {
    KALogoButton* btn = [KALogoButton buttonWithType:buttonType];
    if (self == [KALogoButton class]) {
        btn.tintColor = [UIColor colorNamed:@"tabbarTintcolor"];
        [btn setBackgroundImage:[UIImage imageNamed:@"Logo"] forState:UIControlStateNormal];
        [btn sizeToFit];
        btn.center = CGPointMake(CGRectGetMidX(superview.bounds), 220.0);
        [superview addSubview:btn];
    }
    return btn;
}

- (void) slideOutAnimationInSuperview:(UIView*) superview {
    CABasicAnimation* logoMover = [CABasicAnimation animationWithKeyPath:@"position"];
    [logoMover setRemovedOnCompletion:NO];
    logoMover.fillMode = kCAFillModeForwards;
    logoMover.duration = 0.5;
    logoMover.fromValue = [NSValue valueWithCGPoint:self.center];
    logoMover.toValue = [NSValue valueWithCGPoint:CGPointMake(-CGRectGetMidX(superview.bounds), self.center.y)];
    logoMover.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [self.layer addAnimation:logoMover forKey:@"logoMover"];
}

- (void) rotateOutAnimation {
    CABasicAnimation* logoRotator = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    [logoRotator setRemovedOnCompletion:NO];
    logoRotator.fillMode = kCAFillModeForwards;
    logoRotator.duration = 0.5;
    logoRotator.fromValue = @0.0;
    logoRotator.toValue = @(M_PI * (-2));
    logoRotator.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [self.layer addAnimation:logoRotator forKey:@"logoRotator"];
}

@end

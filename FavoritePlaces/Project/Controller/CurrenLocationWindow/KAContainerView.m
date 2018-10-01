//
//  KAContainerView.m
//  FavoritePlaces
//
//  Created by 123 on 01.10.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

#import "KAContainerView.h"
#import <QuartzCore/QuartzCore.h>

static const CGFloat kSpinnerPadding = 15.f;

@interface KAContainerView () <CAAnimationDelegate>

@end

@implementation KAContainerView {
    UIView* superview;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {

        [self commonInit];
    }
    return self;
}

- (void) commonInit {
    
    [NSBundle.mainBundle loadNibNamed:@"KAContainerView" owner:self options:nil];
    [self addSubview:_contentView];
    _contentView.frame = self.bounds;
    _contentView.autoresizingMask =
    UIViewAutoresizingFlexibleHeight |
    UIViewAutoresizingFlexibleWidth;
}

- (void) setAnimationInSuperView:(UIView*) superview {
    superview = superview;
    
    self.contentView.hidden = NO;
    CGFloat x = CGRectGetWidth(superview.bounds) * 2.0;
    CGFloat y = 40 + CGRectGetHeight(self.contentView.bounds) / 2.0;
    self.contentView.center = CGPointMake(x, y);
    CGFloat centerX = CGRectGetMidX(superview.bounds);
    
    CABasicAnimation* panelMover = [CABasicAnimation animationWithKeyPath:@"position"];
    [panelMover setRemovedOnCompletion:NO];
    panelMover.fillMode = kCAFillModeForwards;
    panelMover.duration = 0.6;
    panelMover.fromValue = [NSValue valueWithCGPoint:self.contentView.center];
    panelMover.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, self.contentView.center.y)];
    panelMover.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    __weak id weakSelf = self;
    [panelMover setDelegate:weakSelf];
    
    [self.contentView.layer addAnimation:panelMover forKey:@"panelMover"];
}

- (void) spinnerWithTag:(NSUInteger) tag {
    UIActivityIndicatorView* spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    CGFloat xCoord = CGRectGetMidX(self.messageLabel.frame);
    CGFloat yCoord = CGRectGetMidY(self.messageLabel.frame) + CGRectGetHeight(spinner.bounds) / 2 + kSpinnerPadding;
    CGPoint center = CGPointMake(xCoord, yCoord);
    spinner.center = center;
    [spinner startAnimating];
    spinner.tag = tag;
    [self.contentView addSubview:spinner];
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self.contentView.layer removeAllAnimations];
    self.contentView.center = CGPointMake(CGRectGetWidth(superview.bounds) / 2, 40.0 + CGRectGetHeight(self.contentView.bounds) / 2.0);
}

@end

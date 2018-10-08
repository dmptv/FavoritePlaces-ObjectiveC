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
@property (weak, nonatomic) UIView* supView;

@end

@implementation KAContainerView

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
    [self addSubview:self.contentView];
    self.contentView.frame = self.bounds;
}

- (void) setAnimationInSuperView:(UIView*) superview {
    self.supView = superview;
    
    self.hidden = NO;
    CGFloat x = CGRectGetWidth(superview.bounds) * 2.0;
    CGFloat y = 40 + CGRectGetHeight(self.contentView.bounds) / 2.0;
    self.center = CGPointMake(x, y);
    CGFloat centerX = CGRectGetMidX(self.supView.bounds);

    CABasicAnimation* panelMover = [CABasicAnimation animationWithKeyPath:@"position"];
    [panelMover setRemovedOnCompletion:NO];
    panelMover.fillMode = kCAFillModeForwards;
    panelMover.duration = 0.6;
    panelMover.fromValue = [NSValue valueWithCGPoint:self.center];
    panelMover.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, self.center.y)];
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
    [self addSubview:spinner];
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    [self.contentView.layer removeAllAnimations];
    self.center = CGPointMake(CGRectGetWidth(self.supView.bounds) / 2,
                                          40.0 + CGRectGetHeight(self.contentView.bounds) / 2.0);
    
}

@end

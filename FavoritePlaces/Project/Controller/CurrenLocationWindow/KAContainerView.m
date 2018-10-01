//
//  KAContainerView.m
//  FavoritePlaces
//
//  Created by 123 on 01.10.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

#import "KAContainerView.h"
#import <QuartzCore/QuartzCore.h>

@implementation KAContainerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"init with frame");
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        NSLog(@"init with coder");
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

- (void) setAnimationInSuperView:(UIView*) superView {
    self.contentView.hidden = NO;
    CGFloat x = CGRectGetWidth(superView.bounds) * 2.0;
    CGFloat y = 40 + CGRectGetHeight(self.contentView.bounds) / 2.0;
    self.contentView.center = CGPointMake(x, y);
    CGFloat centerX = CGRectGetMidX(superView.bounds);
    
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

@end

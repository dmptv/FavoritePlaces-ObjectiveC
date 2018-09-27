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

@interface CurrentLocationViewController ()

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *longitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIButton *tagButton;
@property (weak, nonatomic) IBOutlet UIButton *getButton;
@property (weak, nonatomic) IBOutlet UILabel *latitudeTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *longitudeTextLabel;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) UIButton *logoButton;
@property (assign, nonatomic) BOOL logoVisible;


@end

@implementation CurrentLocationViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self updateLabels];
    
}

#pragma mark - Helpers

- (void) makeLogoButton {
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage* image = [[UIImage imageNamed:@"Logo"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    button.tintColor = [UIColor colorNamed:@"tabbarTintcolor"];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button sizeToFit];
    [button addTarget:self action:@selector(getLocation:)
              forControlEvents:UIControlEventTouchUpInside];
    button.center = CGPointMake(CGRectGetMidX(self.view.bounds), 220.0);
    [self.view addSubview:button];
    
    self.logoButton = button;
}

#pragma mark - Methods

- (void) updateLabels {
    [self showLogoView];
    
}

- (void) showLogoView {
    if (!self.logoVisible) {
        self.logoVisible = YES;
        self.containerView.hidden = YES;
        if (!self.logoButton) {
            [self makeLogoButton];
        }
    }
}

- (void) hideLogoView {
    if (!self.logoVisible) { return; }
    self.logoVisible = NO;
    
    // containerView is placed outside the screen and moved to the center
    self.containerView.hidden = NO;
    CGFloat x = CGRectGetWidth(self.view.bounds) * 2.0;
    CGFloat y = 40 + CGRectGetHeight(self.view.bounds) / 2.0;
    CGPoint center = CGPointMake(x, y);
    self.containerView.center = center;
    
    
    //let centerX = view.bounds.midX
    
}

#pragma mark - Actions

- (IBAction) getLocation:(id)sender {
    
    if (self.logoVisible) {
        [self hideLogoView];
    }
    
    
    
}


@end







































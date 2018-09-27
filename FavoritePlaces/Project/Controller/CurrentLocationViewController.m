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
   
    
    
//    [self makeLogoButton];
    [self updateLabels];
    
}

- (void) makeLogoButton {
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"Logo"] forState:UIControlStateNormal];
    [button sizeToFit];
    [button addTarget:self
                        action:@selector(getLocation:)
              forControlEvents:UIControlEventTouchUpInside];
    button.center = CGPointMake(CGRectGetMidX(self.view.bounds), 220.0);
    [self.view addSubview:button];
    
    self.logoButton = button;
}

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


- (IBAction) getLocation:(id)sender {
    
    NSLog(@"get location called");
    
}


@end







































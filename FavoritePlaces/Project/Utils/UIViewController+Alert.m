//
//  UIViewController+Alert.m
//  FavoritePlaces
//
//  Created by 123 on 28.09.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

#import "UIViewController+Alert.h"

@implementation UIViewController (Alert)

- (void) showAlertWithTitle:(NSString*) title andMessage:(NSString*) message {
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle : title
                                                                    message : message
                                                             preferredStyle : UIAlertControllerStyleAlert];
    
    UIAlertAction * ok = [UIAlertAction  actionWithTitle:@"OK"
                                                   style:UIAlertActionStyleDefault
                                                 handler:^(UIAlertAction * action)
                          {
                              NSLog(@"Ok tapped");
                              
                          }];
    
    [alert addAction:ok];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:YES completion:nil];
    });
}

@end

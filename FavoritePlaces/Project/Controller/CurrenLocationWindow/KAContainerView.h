//
//  KAContainerView.h
//  FavoritePlaces
//
//  Created by 123 on 01.10.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KAContainerView : UIView
@property (strong, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *longitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIButton *tagButton;
@property (weak, nonatomic) IBOutlet UILabel *latitudeTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *longitudeTextLabel;


@end

NS_ASSUME_NONNULL_END

//
//  LocationCell.h
//  FavoritePlaces
//
//  Created by 123 on 20.09.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LocationCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;


@end

NS_ASSUME_NONNULL_END

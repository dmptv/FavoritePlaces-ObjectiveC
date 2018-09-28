//
//  Person.h
//  FavoritePlaces
//
//  Created by 123 on 28.09.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CreditCard;

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property (nonatomic, strong) CreditCard *card;

@end

NS_ASSUME_NONNULL_END

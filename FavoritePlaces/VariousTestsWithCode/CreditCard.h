//
//  CreditCard.h
//  FavoritePlaces
//
//  Created by 123 on 28.09.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface CreditCard : NSObject

@property (nonatomic, unsafe_unretained, readonly) Person *holder;        //!!!

- (id) initWithHolder: (Person *)holder;

@end

NS_ASSUME_NONNULL_END

//
//  CreditCard.m
//  FavoritePlaces
//
//  Created by 123 on 28.09.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

#import "CreditCard.h"

@implementation CreditCard

- (id) initWithHolder: (Person *)aHolder {
    self = [super init];
    if (self) {
        _holder = aHolder;
    }
    return self;
}

@end

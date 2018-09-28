//
//  MyClass.m
//  FavoritePlaces
//
//  Created by 123 on 28.09.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

#import "MyClass.h"


@interface MyClass ()

@property (assign, nonatomic) int aInt;
@property (strong, nonatomic) NSString* bString;

@end

static int const kIntConst = 99;

@implementation MyClass

- (instancetype) initWithA:(int) aInt andB:(NSString*) bString {
    self = [super init];
    if (self) {
        _aInt = aInt;
        _bString = bString;
        
        NSLog(@"%d", kIntConst);
    }
    return self;
}

- (void) setAInt:(int)aInt {
    // чтобы сделать как let в swift
    NSAssert(false, @"You are not allowed to assign to aInt");
}

- (void) anotherMethod:(int)newInt {
    _aInt = newInt;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"--> %d  %@", self.aInt, self.bString];
}


@end

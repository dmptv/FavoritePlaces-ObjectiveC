//
//  KAContainerView.m
//  FavoritePlaces
//
//  Created by 123 on 01.10.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

#import "KAContainerView.h"

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

@end

//
//  AudioEngin.m
//  FavoritePlaces
//
//  Created by 123 on 09.10.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

#import "AudioEngin.h"
#import <AudioToolbox/AudioToolbox.h>

@interface AudioEngin ()

//@property (assign, nonatomic) SystemSoundID soundID;

@end

@implementation AudioEngin {
    SystemSoundID soundID;
}

- (instancetype)initSound
{
    self = [super init];
    if (self) {
        [self loadSoundEffect];
    }
    return self;
}

- (void) loadSoundEffect {
    NSString* path = [NSBundle.mainBundle pathForResource:@"Beep" ofType:@"caf"];
    NSURL* url = [NSURL fileURLWithPath:path];
    soundID = 0;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &(self->soundID));
    OSStatus status = AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &(self->soundID));
    if (status != kAudioServicesNoError) {
        NSLog(@"--> Error code %d loading sound at path: %@", (int)status, path);
    }
}

//- (void) unloadSoundEffect {
//    AudioServicesDisposeSystemSoundID(soundID);
//    soundID = 0;
//}

- (void) playSoundEffect {
//    AudioServicesPlaySystemSound(soundID);
    
    AudioServicesPlaySystemSoundWithCompletion(soundID, ^{
        AudioServicesDisposeSystemSoundID(self->soundID);
        self->soundID = 0;
        
    });

}



@end

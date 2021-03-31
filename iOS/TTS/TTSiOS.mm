//
//  UnityEngineCloudiOS.mm
//
//  Created by Viraf Zack on 7/2/14
//  Copyright (c) 2014 Unity. All rights reserved.
//

#if __has_feature(objc_arc)
#define RETAIN self
#define AUTORELEASE self
#define RELEASE self
#define DEALLOC self
#else
#define RETAIN retain
#define AUTORELEASE autorelease
#define RELEASE release
#define DEALLOC dealloc
#endif

#import <Foundation/Foundation.h>
#import "TTSSystem.h"


extern "C" {
    
    void TTS_speekText(const char *text)
    {
        TTSSystem *tts = [TTSSystem sharedTTSSystem];
        [tts speakText:[NSString stringWithUTF8String:text]];
    }
    
}


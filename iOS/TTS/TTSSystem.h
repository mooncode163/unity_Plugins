//
//  TTSSystem.h
//  Unity-iPhone
//
//  Created by jaykie Chen on 17/4/14.
//
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@interface TTSSystem : NSObject <AVSpeechSynthesizerDelegate>


+ (TTSSystem *) sharedTTSSystem;
-(void) speakText:(NSString *)text;
@end

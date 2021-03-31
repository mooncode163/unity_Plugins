//
//  TTSSystem.m
//  Unity-iPhone
//
//  Created by jaykie Chen on 17/4/14.
//
//

#import "TTSSystem.h"
@interface TTSSystem()
{
    AVSpeechSynthesisVoice *voice;
    AVSpeechSynthesizer *synth;
}
@end

@implementation TTSSystem
static TTSSystem *s_sharedTTSSystem = nil;
+ (TTSSystem *) sharedTTSSystem
{
    @synchronized(self)
    {
        if (!s_sharedTTSSystem){
            s_sharedTTSSystem = [[TTSSystem alloc] init];
            [s_sharedTTSSystem initValue];
        }
        
        
    }
    return s_sharedTTSSystem;
}

-(void) initValue
{
    voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];
    synth = [[AVSpeechSynthesizer alloc]init];
    synth.delegate = self;
}

-(void) speakText:(NSString *)text
{
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:text];
    //设置语言
    utterance.voice = voice;
    NSLog(@"%@",[AVSpeechSynthesisVoice speechVoices]);
    utterance.volume= 1;  //设置音量（0.0~1.0）默认为1.0
    utterance.rate= 0.4;  //设置语速
    utterance.pitchMultiplier= 1.0;  //设置语调
    [synth speakUtterance:utterance];
}


#pragma mark AVSpeechSynthesizer
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance
{
    UnitySendMessage("Scene", "TTSSpeechDidStart", "start");
}
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance
{
    UnitySendMessage("Scene", "TTSSpeechDidFinish", "finish");
}


@end

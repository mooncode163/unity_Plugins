//
//  AdVideoBase.h
//  Unity-iPhone
//
//  Created by jaykie Chen on 17/4/14.
//
//

#import <Foundation/Foundation.h> 
#import "Common.h"

#import <objc/runtime.h>
#import <objc/message.h>

#define ADVIDEO_TYPE_INSERT 0
#define ADVIDEO_TYPE_REWARD 1

@class AdVideoBase;
@protocol AdVideoDelegate<NSObject>

@optional

- (void)AdVideoDidFail:(AdVideoBase *)ad;

@end

@interface AdVideoBase : NSObject
{
    bool isReadyAdmob;
    bool isNeedShowAd;
    bool isLoaded;
    
    bool isShowTime;
    bool isVideo;
    
    int adType;
    bool _isBackground;
    
    UInt64 timeLoadAdms;
    bool isLoadAdTimeOut;
    bool isLoadAdEnd;
}

@property (nonatomic, weak) id<AdVideoDelegate> delegate;
@property(nonatomic,retain) NSString *source;
@property(nonatomic,retain) NSString *appId;
@property(nonatomic,retain) NSString *appKey;
-(void) setBackground:(bool) isBackground;
-(void) show;
-(void) setAd;
-(void) onClickAd;
-(UInt64) getSystemMs;
-(void) setType:(int) type; 

//callback
-(void) didFail;
-(void) didStart;
-(void) didFinish:(NSString*)str;
@end




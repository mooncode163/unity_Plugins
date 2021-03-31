//
//  AdNativeBase.h
//  Unity-iPhone
//
//  Created by jaykie Chen on 17/4/14.
//
//

#import <Foundation/Foundation.h> 
#import "Common.h"
#import <objc/runtime.h>
#import <objc/message.h>

@class AdNativeBase;
@protocol AdNativeDelegate<NSObject>

@optional

- (void)AdNativeDidFail:(AdNativeBase *)ad;

@end

@interface AdNativeBase : NSObject
{
    bool isReadyAdmob;
    bool isNeedShowAd;
    bool isLoaded;
    
    bool isShowTime;
    bool isVideo;
    
    
    bool _isBackground;
    
      UInt64 timeLoadAdms;
    bool isLoadAdTimeOut;
    bool isLoadAdEnd;
}

@property (nonatomic, weak) id<AdNativeDelegate> delegate;
@property(nonatomic,retain) NSString *source;
@property(nonatomic,retain) NSString *appId;
@property(nonatomic,retain) NSString *appKey;
-(void) setBackground:(bool) isBackground;
-(void) show;
-(void) showSplash;
-(void) setAd;
-(void) onClickAd;
-(UInt64) getSystemMs;
//callback
-(void) didFail;
-(void) didLoad:(NSString*)str;
@end




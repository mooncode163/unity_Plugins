//
//  AdInsertBase.h
//  Unity-iPhone
//
//  Created by jaykie Chen on 17/4/14.
//
//

#import <Foundation/Foundation.h> 
#import "Common.h"
#import <objc/runtime.h>
#import <objc/message.h>

@class AdSplashBase;
@protocol AdSplashDelegate<NSObject>

@optional

- (void)AdSplashDidFail:(AdSplashBase *)ad;

@end

@interface AdSplashBase : NSObject
{
    bool isReadyAdmob;
    bool isNeedShowAd;
    bool isLoaded;
    
    bool isShowTime;
    bool isVideo;
    
    
    bool _isBackground;
}

@property (nonatomic, weak) id<AdSplashDelegate> delegate;
@property(nonatomic,retain) NSString *source;
@property(nonatomic,retain) NSString *appId;
@property(nonatomic,retain) NSString *appKey;
@property(nonatomic,assign) int adType;

-(void) setBackground:(bool) isBackground;
-(void) show;
-(void) setAd;

//callback
-(void) didFail;
-(void) willShow;
-(void) didClose;
@end




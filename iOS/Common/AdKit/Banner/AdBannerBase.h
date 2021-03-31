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

@class AdBannerBase;
@protocol AdBannerDelegate<NSObject>

@optional

- (void)AdBannerDidFail:(AdBannerBase *)ad;

@end

@interface AdBannerBase : NSObject
{
    int screenW;
    int screenH;
     UIView *viewAd;
    int adOffsetY;
    UInt64 timeLoadAdms;
    bool isLoadAdTimeOut;
    bool isLoadAdEnd;
}

@property (nonatomic, weak) id<AdBannerDelegate> delegate;
@property(nonatomic,retain) NSString *source;
@property(nonatomic,retain) NSString *appId;
@property(nonatomic,retain) NSString *appKey;
-(void) setBackground:(bool) isBackground;
-(void) show:(bool)isShow;
-(void) setAd;
-(void) setScreenSize:(int)w height:(int)h;
-(void) setScreenOffset:(int)x ofty:(int)y;
-(void)setAlpha:(float )alpha;
- (void)adBannerDidReceiveAd;
-(void)layoutSubView:(int)w height:(int)h;
//callback
-(void) didFail;
-(void) willShow;
-(void) didClose;
-(UInt64) getSystemMs;
@end




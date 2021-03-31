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

@class AdInsertBase;
@protocol AdInsertDelegate<NSObject>

@optional

- (void)AdInsertDidFail:(AdInsertBase *)ad;
- (void)AdInsertDidLoad:(AdInsertBase *)ad;

@end

@interface AdInsertBase : NSObject
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
    bool isLoadingAd;
}

@property (nonatomic, weak) id<AdInsertDelegate> delegate;
@property(nonatomic,retain) NSString *source;
@property(nonatomic,retain) NSString *appId;
@property(nonatomic,retain) NSString *appKey;
@property(nonatomic,retain) NSString *unityObjName;

-(void) setBackground:(bool) isBackground;
-(void) show;
-(void) setAd;
-(UInt64) getSystemMs;
-(void) setUnityObjectInfo:(NSString *)strObjName;
//callback
-(void) didFail;
-(void) willShow;
-(void) didClose;
@end




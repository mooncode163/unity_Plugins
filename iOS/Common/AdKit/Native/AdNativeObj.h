//
//  CCAdApplistObj.h
//  moonma_tankcity
//
//  Created by chen Jaykie on 13-10-2.
//
//




#import <Foundation/Foundation.h>
#import "Common.h"
#import "AdNativeBase.h"
//
//
//#ifdef ENABLE_AD_GDT
//#import "AdNativeGdt.h"
//#endif
//
//#ifdef ENABLE_AD_Baidu
//#import "AdNativeBaidu.h"
//#endif
//
//
//#ifdef ENABLE_AD_Chsj
//#import "AdNativeChsj.h"
//#endif
//
//#import "AdNativeAdmob.h"

@interface AdNativeObj : NSObject<AdNativeDelegate>
{
//    AdNativeBase *adNative;
    id adNative;
    // AdNative *adNative;
    int adSource;
     void *poitAdNative;//类指针
    //芒果
   // AdMoGoInterstitial *interstitial;
    //插屏广告
    //GMInterstitialAD *interstitialAD;
  
     
    
}


@property(nonatomic,retain) NSString *strAdSource;
@property(nonatomic,retain) NSString *strAdSplashSource;
@property(nonatomic,retain) NSString *appId;
@property(nonatomic,retain) NSString *appKey;
@property(nonatomic,retain) NSString *appSplashId;
@property(nonatomic,retain) NSString *appSplashKey;//开屏广告
 
+ (AdNativeObj *) sharedAdNativeObj;
-(void) show;
-(void)setAdSource:(int )source;
-(void) setAd:(NSString *) strSource;
-(void) setClassePoit:(void *) p ;
-(void) setBackground:(bool) isBackground;
-(void) setAdOnMainThread;
-(void) onClickAd; 
-(void) showSplash:(NSString *) strSource;
@end

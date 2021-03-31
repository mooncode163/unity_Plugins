//
//  CCAdApplistObj.h
//  moonma_tankcity
//
//  Created by chen Jaykie on 13-10-2.
//
//




#import <Foundation/Foundation.h>
#import "Common.h"
#import "AdSplashBase.h"

//
//#import "AdSplashAdmob.h"
//#ifdef ENABLE_AD_GDT
//#import "AdSplashGdt.h"
//#endif
//#ifdef ENABLE_AD_Baidu
//#import "AdSplashBaidu.h"
//#endif
//
//#ifdef ENABLE_AD_Chsj
//#import "AdSplashChsj.h"
//#endif
//#import "AdSplashAdView.h"

@interface AdSplashObj : NSObject<AdSplashDelegate>
{
//    AdSplashBase *adSplash;
    id adSplash;
    
    int adSource;
     void *poitAdInsert;//类指针
    //芒果
   // AdMoGoInterstitial *interstitial;
    //插屏广告
    //GMInterstitialAD *interstitialAD;
  int adType;
     
    
}


@property(nonatomic,retain) NSString *strAdSource;
@property(nonatomic,retain) NSString *strAdSplashSource;
@property(nonatomic,retain) NSString *appId;
@property(nonatomic,retain) NSString *appKey;
@property(nonatomic,retain) NSString *appSplashId;
@property(nonatomic,retain) NSString *appSplashKey;//开屏广告 

+ (AdSplashObj *) sharedAdSplashObj;
-(void) show;
-(void)setAdSource:(int )source;
-(void) setAd:(NSString *) strSource tpye:(int)strType;
-(void) setClassePoit:(void *) p ;
-(void) setBackground:(bool) isBackground;
-(void) setAdOnMainThread;
@end

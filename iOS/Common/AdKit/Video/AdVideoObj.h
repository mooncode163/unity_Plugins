//
//  CCAdApplistObj.h
//  moonma_tankcity
//
//  Created by chen Jaykie on 13-10-2.
//
//




#import <Foundation/Foundation.h>
#import "Common.h"
#import "AdVideoBase.h"
//#import "AdVideoUnity.h"
//#import "AdVideoAdmob.h"
//#import "AdVideoInmobi.h"
//#import "AdVideoAdView.h"
//#import "AdVideoMobVista.h"

@interface AdVideoObj : NSObject<AdVideoDelegate>
{
//    AdVideoBase *AdVideo;
    id AdVideo;
    // AdVideo *AdVideo;
    int adSource;
     void *poitAdVideo;//类指针
    //芒果
   // AdMoGoInterstitial *interstitial;
    //插屏广告
    //GMInterstitialAD *interstitialAD;
  
    int adType;
    
}

//@property(nonatomic,retain) NSString *strPreloadAdSource;
@property(nonatomic,retain) NSString *strAdSource;
@property(nonatomic,retain) NSString *strAdSplashSource;
@property(nonatomic,retain) NSString *appId;
@property(nonatomic,retain) NSString *appKey;
@property(nonatomic,retain) NSString *appSplashId;
@property(nonatomic,retain) NSString *appSplashKey;//开屏广告
 
+ (AdVideoObj *) sharedAdVideoObj;
-(void) show;
-(void)setAdSource:(int )source;
-(void) setAd:(NSString *) strSource;
-(void) setClassePoit:(void *) p ;
-(void) setBackground:(bool) isBackground;
-(void) setAdOnMainThread;
-(void) onClickAd;
-(void) setType:(int) type;
-(void) preloadAd:(NSString *) strSource;
-(void) createAd:(NSString *) strSource;
-(void) preloadAdOnMainThread;

@end

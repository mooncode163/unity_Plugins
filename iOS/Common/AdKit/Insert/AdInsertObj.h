//
//  CCAdApplistObj.h
//  moonma_tankcity
//
//  Created by chen Jaykie on 13-10-2.
//
//




#import <Foundation/Foundation.h>
#import "Common.h"
#import "AdInsertBase.h"
//#import "AdInsertAdmob.h"
#ifdef ENABLE_AD_GDT
//#import "AdInsertGdt.h"
#endif
#ifdef ENABLE_AD_Baidu
//#import "AdInsertBaidu.h"
#endif

#ifdef ENABLE_AD_Chsj
//#import "AdInsertChsj.h"
#endif

//#import "AdInsertUnity.h"
//#import "AdInsertInmobi.h"
//#import "AdInsertMobVista.h"
//#import "AdInsertVideoMobVista.h"
@interface AdInsertObj : NSObject<AdInsertDelegate>
{
//    AdInsertBase *adInsert;
    id adInsert;
    
    // AdInsert *adInsert;
    int adSource;
     void *poitAdInsert;//类指针
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
@property(nonatomic,retain) NSString *unityObjName;

 
+ (AdInsertObj *) sharedAdInsertObj;
-(void) show;
-(void)setAdSource:(int )source;
-(void) setAd:(NSString *) strSource;
-(void) setClassePoit:(void *) p ;
-(void) setBackground:(bool) isBackground;
-(void) setAdOnMainThread;
-(void) setUnityObjectInfo:(NSString *)strObjName;
@end

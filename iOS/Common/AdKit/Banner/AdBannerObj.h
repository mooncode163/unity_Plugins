//
//  AdBannerObj.h
//  moonma_tankcity
//
//  Created by chen Jaykie on 13-10-2.
//
//
//#define ENABLE_AD_BAIDU

#import <Foundation/Foundation.h>
#import "Common.h"
#import "AdBannerBase.h"

//#import "AdBannerAdmob.h"
//#ifdef ENABLE_AD_GDT
//#import "AdBannerGdt.h"
//#endif
//#ifdef ENABLE_AD_Baidu
//#import "AdBannerBaidu.h"
//#endif
//#ifdef ENABLE_AD_Chsj
//#import "AdBannerChsj.h"
//#endif

//#import "AdBannerAdView.h"
//#import "AdBannerInmobi.h"
//#import "AdBannerMobVista.h"

@interface AdBannerObj : NSObject
{
    int screenWidth;
    int screenHeight;
    int adSource;
    int adOffsetY;
    int adOffsetX;

    float adAlpha;
    void *poitThis;//类指针
    bool isshowad;
    
//    AdBannerBase *adBanner;
    id adBanner;
}

@property(nonatomic,retain) NSString *strAdSource;
@property(nonatomic,retain) NSString *appId;
@property(nonatomic,retain) NSString *appKey;
+ (AdBannerObj *) sharedAdBannerObj;
-(void) setScreenSize:(int)w height:(int)h;
-(void)setAdSource:(int )source;
-(void) setAd:(NSString *) strSource;
-(void)setAlpha:(float )alpha;
-(void) setClassePoit:(void *) p;
-(void) layoutSubView:(int)w height:(int)h;
-(void) show:(bool)isShow;
-(void) setScreenOffset:(int)x ofty:(int)y;

@end

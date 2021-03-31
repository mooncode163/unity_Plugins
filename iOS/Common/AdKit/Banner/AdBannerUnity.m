//
//  AdBanneriOS.mm
//
//  Created by Viraf Zack on 7/2/14
//  Copyright (c) 2014 Unity. All rights reserved.
//

#if __has_feature(objc_arc)
#define RETAIN self
#define AUTORELEASE self
#define RELEASE self
#define DEALLOC self
#else
#define RETAIN retain
#define AUTORELEASE autorelease
#define RELEASE release
#define DEALLOC dealloc
#endif

#import <Foundation/Foundation.h>
#import "AdBannerObj.h"
// #import "AdConfigObj.h" 
#include "AdConfig.h"

//TARGET_OS_IPHONE  TARGET_IPHONE_SIMULATOR
#ifdef TARGET_IPHONE_SIMULATOR

    //#define DISABLE_ADBANNER

#endif

 


#if defined (__cplusplus)
extern "C"
{
#endif
      
    void AdBanner_InitAd(const char *source)
    {
        #ifndef DISABLE_ADBANNER
         AdBannerObj *ad = [AdBannerObj sharedAdBannerObj];
        
//         AdConfigObj *adConfigObj = [AdConfigObj sharedAdConfigObj];
//         //
//          AdConfig_GetAdSource(SOURCE_TYPE_BANNER);
//          NSString *strSource = adConfigObj.strAdSource;
//
//          AdConfig_GetAppId([strSource UTF8String]);
//          NSString *strAppId = adConfigObj.strAppId;
//
//          AdConfig_GetAdKey([strSource UTF8String],SOURCE_TYPE_BANNER);
//          NSString *strAdKey = adConfigObj.strAdKey;
//
//          [ad setAd:strSource appid:strAppId key:strAdKey];
        [ad setAd:[NSString stringWithUTF8String:source]];
        #endif
    }
    void AdBanner_ShowAd(bool isShow)
    {
        #ifndef DISABLE_ADBANNER
        AdBannerObj *ad = [AdBannerObj sharedAdBannerObj];
         [ad show:isShow];
         #endif
    }
    
    void AdBanner_SetScreenSize(int w,int h)
    {
        #ifndef DISABLE_ADBANNER
        AdBannerObj *ad = [AdBannerObj sharedAdBannerObj];
        [ad setScreenSize:w height:h];
        #endif
    }
    void AdBanner_SetScreenOffset(int x,int y)
    {
         #ifndef DISABLE_ADBANNER
        AdBannerObj *ad = [AdBannerObj sharedAdBannerObj];
        [ad setScreenOffset:x ofty:y];
        #endif
    }
    
    
#if defined (__cplusplus)
}
#endif


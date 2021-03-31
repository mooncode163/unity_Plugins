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
#import "AdSplashObj.h" 

#import "Common.h"
// #import "AdConfigObj.h" 
#include "AdConfig.h"

#if defined (__cplusplus)
extern "C"
{
#endif
 
    //开屏设置
    void AdSplash_SetConfig(const char*source,const char*appId,const char*appKey,const char* type)
    {
        
       
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithUTF8String:source ]  forKey:KEY_ADSPLASH_SOURCE ];
         [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithUTF8String:appId ] forKey:KEY_ADSPLASH_APPID ];
         [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithUTF8String:appKey] forKey:KEY_ADSPLASH_APPKEY ];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithUTF8String:type] forKey:KEY_ADSPLASH_TYPE];
        //在存储数据的地方,别忘了这一句
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    //开机插屏设置
    void AdSplashInsert_SetConfig(const char*source,const char*appId,const char*appKey,const char* type)
    {
        
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithUTF8String:source ]  forKey:KEY_ADSPLASH_INSERT_SOURCE ];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithUTF8String:appId ] forKey:KEY_ADSPLASH_INSERT_APPID ];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithUTF8String:appKey] forKey:KEY_ADSPLASH_INSERT_APPKEY ];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithUTF8String:type] forKey:KEY_ADSPLASH_TYPE];
        
        //在存储数据的地方,别忘了这一句
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
   
    void AdSplash_InitAd(const char*source,int type)
    {
          AdSplashObj *ad = [AdSplashObj sharedAdSplashObj];
        if(ad==nil){
            printf("AdSplashObj is null");
        }
//        AdConfigObj *adConfigObj = [AdConfigObj sharedAdConfigObj];
//        int type = SOURCE_TYPE_SPLASH;
//         //
//          AdConfig_GetAdSource(type);
//          NSString *strSource = adConfigObj.strAdSource;
//
//          AdConfig_GetAppId([strSource UTF8String]);
//          NSString *strAppId = adConfigObj.strAppId;
//
//          AdConfig_GetAdKey([strSource UTF8String],type);
//          NSString *strAdKey = adConfigObj.strAdKey;
//
//          [ad setAd:strSource appid:strAppId key:strAdKey];
//          
         [ad setAd:[NSString stringWithUTF8String: source] tpye:type];
    }
    void AdSplash_Show()
    {
        AdSplashObj *ad = [AdSplashObj sharedAdSplashObj];
        [ad show];
    }
    
    void StartAdSplash()
    {
        return;
        bool isEnable = [[NSUserDefaults standardUserDefaults] boolForKey:KEY_ENABLE_ADSPLASH];
        if(!isEnable){
            return;
        }
       if(Common_IsNoAd())
       {
           return;
       }
        
        NSString *type = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_ADSPLASH_TYPE];
        if(isBlankString(type)){
            type = ADSPLASH_TYPE_DEFAULT;
        }
        
        NSString *source = nil;
        NSString *appid = nil;
        NSString *appkey = nil;
        
        if([type isEqualToString:ADSPLASH_TYPE_SPLASH])
        {
            source = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_ADSPLASH_SOURCE];
            if(isBlankString(source)){
                source = ADSPLASH_SOURCE_DEFAULT;
            }
            appid = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_ADSPLASH_APPID];
            if(isBlankString(appid)){
                appid = ADSPLASH_APPID_DEFAULT;
            }
            appkey = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_ADSPLASH_APPKEY];
            if(isBlankString(appkey)){
                appkey = ADSPLASH_APPKEY_DEFAULT;
            }
        }else{
            //ADSPLASH_TYPE_INSERT
            source = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_ADSPLASH_INSERT_SOURCE];
            if(isBlankString(source))
            {
                source = ADSPLASH_INSERT_SOURCE_DEFAULT;
            }
             appid = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_ADSPLASH_INSERT_APPID];
            if(isBlankString(appid))
            {
                appid = ADSPLASH_INSERT_APPID_DEFAULT;
            }
             appkey = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_ADSPLASH_INSERT_APPKEY];
            if(isBlankString(appkey))
            {
                appkey = ADSPLASH_INSERT_APPKEY_DEFAULT;
            }
        }
       
        
         bool isInChina = [[NSUserDefaults standardUserDefaults] boolForKey:KEY_IP_IN_CHINA];
        
        // AdSplash_InitAd([source UTF8String],[type UTF8String]);
        // AdSplash_Show();
    }
    
    
#if defined (__cplusplus)
}
#endif


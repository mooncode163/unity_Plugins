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
#import "AdInsertObj.h"
// #import "AdConfigObj.h"

#include "AdConfig.h"

#if defined (__cplusplus)
extern "C"
{
#endif
 
    void AdInsert_SetObjectInfo(const char*objName)
    {
        AdInsertObj *ad = [AdInsertObj sharedAdInsertObj];
        [ad setUnityObjectInfo:[NSString stringWithUTF8String:objName]];
    }
    
    void AdInsert_InitAd(const char*source)
    {
        NSLog(@"AdInsert_InitAd:source=%s",source);
        AdInsertObj *ad = [AdInsertObj sharedAdInsertObj];
        if(!ad){
            printf("AdInsertObj is null");
        }
        //AdConfigObj *adConfigObj = [AdConfigObj sharedAdConfigObj];
        //int type = SOURCE_TYPE_INSERT;
        //异步
        //AdConfig_StartGetConfig(type);
         //
        //   AdConfig_GetAdSource(type);
        //   NSString *strSource = adConfigObj.strAdSource;

        //   AdConfig_GetAppId([strSource UTF8String]);
        //   NSString *strAppId = adConfigObj.strAppId;

        //   AdConfig_GetAdKey([strSource UTF8String],type);
        //   NSString *strAdKey = adConfigObj.strAdKey;

        //   [ad setAd:strSource appid:strAppId key:strAdKey];
         [ad setAd:[NSString stringWithUTF8String:source]];
    }
    void AdInsert_ShowAd()
    {
        AdInsertObj *ad = [AdInsertObj sharedAdInsertObj];
        [ad show];
    }

 
   
    
#if defined (__cplusplus)
}
#endif


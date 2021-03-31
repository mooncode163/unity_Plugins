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
#import "AdNativeObj.h"

#include "AdConfig.h"
#if defined (__cplusplus)
extern "C"
{
#endif
    
    void AdNative_SetObjectInfo(const char*name,const char*method)
    {
        
    }
    
    void AdNative_InitAd(const char*source)
    {
        AdNativeObj *ad = [AdNativeObj sharedAdNativeObj];
        [ad setAd:[NSString stringWithUTF8String:source]];

        
    }
    void AdNative_ShowAd()
    {
        AdNativeObj *ad = [AdNativeObj sharedAdNativeObj];
        [ad show];
    }
   void AdNative_ShowSplash(const char*source)
    {
        AdNativeObj *ad = [AdNativeObj sharedAdNativeObj]; 
        [ad showSplash:[NSString stringWithUTF8String:source]];
    }
    
    void AdNative_OnClickAd()
    {
        AdNativeObj *ad = [AdNativeObj sharedAdNativeObj];
        [ad onClickAd];
    }
 
   
    
#if defined (__cplusplus)
}
#endif


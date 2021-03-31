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
#import "AdVideoObj.h"

#include "AdConfig.h"

#if defined (__cplusplus)
extern "C"
{
#endif
    
    void AdVideo_SetObjectInfo(const char*name,const char*method)
    {
        
    }

    void AdVideo_SetType(int type)
    {
        AdVideoObj *ad = [AdVideoObj sharedAdVideoObj];
        [ad setType:type];
    }
    
    

    void AdVideo_PreLoad(const char*source)
    {
        AdVideoObj *ad = [AdVideoObj sharedAdVideoObj];
        [ad preloadAd:[NSString stringWithUTF8String:source]];
    }

    void AdVideo_InitAd(const char*source)
    {
        AdVideoObj *ad = [AdVideoObj sharedAdVideoObj];
        [ad setAd:[NSString stringWithUTF8String:source]];
    }

    void AdVideo_ShowAd()
    {
        AdVideoObj *ad = [AdVideoObj sharedAdVideoObj];
        [ad show];
        
        
    }
    void AdVideo_OnClickAd()
    {
        AdVideoObj *ad = [AdVideoObj sharedAdVideoObj];
        [ad onClickAd];
    }
 
   
    
#if defined (__cplusplus)
}
#endif


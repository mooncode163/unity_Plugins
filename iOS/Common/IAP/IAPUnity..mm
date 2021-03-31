//
//  UnityEngineCloudiOS.mm
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
#import "Common.h"
#import "IAPObj.h"
 

/////
extern "C" {
    void IAP_SetObjectInfo(const char*objName,const char*objMethod)
    {
         IAPObj *buy = [IAPObj sharedIAPObj];
        [buy setUnityObjectInfo:[NSString stringWithUTF8String:objName] key:[NSString stringWithUTF8String:objMethod]];
    }
     void IAP_SetSource(const char*source)
    { 
    }

    void IAP_StartBuy(const char*product)
    {
        IAPObj *buy = [IAPObj sharedIAPObj];
        [buy startBuy:[NSString stringWithUTF8String:product]];
    }
     void IAP_RestoreBuy(const char*product)
    {
        IAPObj *buy = [IAPObj sharedIAPObj];
        [buy restoreBuy:[NSString stringWithUTF8String:product]];
    }
    
}


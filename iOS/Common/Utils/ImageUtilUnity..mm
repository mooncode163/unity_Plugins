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
#import <UIKit/UIKit.h>
#import "Common.h" 
#import "ImageUtilObj.h"

/////
extern "C" { 

      void ImageUtil_SetObjectInfo(const char*objName,const char*objMethod)
    {
     ImageUtilObj *imageUtil = [ImageUtilObj main];
        [imageUtil SetUnityObjectInfo:[NSString stringWithUTF8String:objName] key:[NSString stringWithUTF8String:objMethod]];
    }

     void ImageUtil_OpenSysImageLib()
    { 
             ImageUtilObj *imageUtil = [ImageUtilObj main];
             [imageUtil OpenSysImageLib];
    }
    void ImageUtil_OpenSysCamera()
    { 
           ImageUtilObj *imageUtil = [ImageUtilObj main];
             [imageUtil OpenSysCamera];
    }

     
    
}


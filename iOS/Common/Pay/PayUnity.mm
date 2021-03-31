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
#import "PayObj.h"

#if defined (__cplusplus)
extern "C"
{
#endif
      
    void Pay_Init(const char *source,const char *appId,const char *appKey)
    {
        
         PayObj *Pay = [PayObj sharedPayObj];
        [Pay setAppId:[NSString stringWithUTF8String:appId]];
        
    }
    //void Pay_PayInfo(const char *source,const char *title, const char *pic)
    void Pay_PayInfo(const char *title, const char *pic)
    {
        //-(void) PayContent:(NSString *)strType title:(NSString *)strTitle detail:(NSString *)strDetail pic:(NSString *)strPic url:(NSString *)strUrl
        PayObj *Pay = [PayObj sharedPayObj];
       // [Pay payContent:[NSString stringWithUTF8String:source] title:[NSString stringWithUTF8String:title] detail:[NSString stringWithUTF8String:detail] pic:[NSString stringWithUTF8String:pic] url:[NSString stringWithUTF8String:url]];
        
    }
#if defined (__cplusplus)
}
#endif


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

 


#if defined (__cplusplus)
extern "C"
{
#endif
      
    void MediaPlayer_Open(const char *url)
    {
        }
    void MediaPlayer_Play()
      {
          }
    void MediaPlayer_Pause()
        {
            }
    void MediaPlayer_Close()
        {
            }
#if defined (__cplusplus)
}
#endif


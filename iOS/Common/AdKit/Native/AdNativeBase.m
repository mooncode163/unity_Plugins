//
//  AdNativeBase.m
//  Unity-iPhone
//
//  Created by jaykie Chen on 17/4/14.
//
//

#import "AdNativeBase.h"

@implementation AdNativeBase
//@synthesize appId;
//@synthesize appKey;

-(UInt64) getSystemMs
{
    UInt64 msecond = [[NSDate date] timeIntervalSince1970]*1000;
    return msecond;
}

-(void) setBackground:(bool) isBackground
{
    _isBackground = isBackground;
    
}

-(void) show
{
}
-(void) showSplash
{

}
-(void) setAd 
{
}
-(void) onClickAd
{
}



//callback
-(void) didFail
{
    char ptmp[1024]={0};
    sprintf(ptmp, "%s",[self.source UTF8String]);
    UnitySendMessage("Scene", "AdNativeDidFail", ptmp);
   
    
}
-(void) didLoad:(NSString*)str
{
    UnitySendMessage("Scene", "AdNativeDidLoad", [str UTF8String]);
}


@end

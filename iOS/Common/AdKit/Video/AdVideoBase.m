//
//  AdVideoBase.m
//  Unity-iPhone
//
//  Created by jaykie Chen on 17/4/14.
//
//

#import "AdVideoBase.h"

@implementation AdVideoBase
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
-(void) setAd
{
}
-(void) onClickAd
{
}
-(void) setType:(int) type
{
     adType = type;
}


//callback
-(void) didFail
{
    char ptmp[1024]={0};
    sprintf(ptmp, "%s",[self.source UTF8String]);
    UnitySendMessage("Scene", "AdVideoDidFail", ptmp);
   
    
}

-(void) didStart
{
    UnitySendMessage("Scene", "AdVideoDidStart", " ");
}

-(void) didFinish:(NSString*)str
{
    UnitySendMessage("Scene", "AdVideoDidFinish", [str UTF8String]);
}


@end

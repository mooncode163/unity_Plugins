//
//  AdSplashBase.m
//  Unity-iPhone
//
//  Created by jaykie Chen on 17/4/14.
//
//

#import "AdSplashBase.h"

@implementation AdSplashBase 
@synthesize adType;
//@synthesize appKey;

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


//callback
-(void) didFail
{
    //UnitySendMessage("Scene", "AdSplashDidFail", "");
}
-(void) willShow
{
    //UnitySendMessage("Scene", "AdSplashWillShow", "");
}
-(void) didClose
{
    //UnitySendMessage("Scene", "AdSplashDidClose", "");
}

@end

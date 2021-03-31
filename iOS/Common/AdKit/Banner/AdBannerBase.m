//
//  AdInsertBase.m
//  Unity-iPhone
//
//  Created by jaykie Chen on 17/4/14.
//
//

#import "AdBannerBase.h"

@implementation AdBannerBase
//@synthesize appId;
//@synthesize appKey;

-(UInt64) getSystemMs
{
    UInt64 msecond = [[NSDate date] timeIntervalSince1970]*1000;
    return msecond;
}

-(void) setBackground:(bool) isBackground
{
   // _isBackground = isBackground;
    
}


-(void) show:(bool)isShow
{
}
-(void) setAd
{
}
-(void) setScreenSize:(int)w height:(int)h
{
    screenW = w;
    screenH = h;
}
-(void) setScreenOffset:(int)x ofty:(int)y
{
    adOffsetY = y;
}

-(void)setAlpha:(float )alpha
{
    viewAd.alpha = alpha;
    
}

-(void)layoutSubView:(int)w height:(int)h
{
    
    if(!viewAd){
        return;
    }
    screenW = w;
    screenH = h;
    //更新状态
    CGRect frame =  viewAd.frame;
    
    float scale = [[UIScreen mainScreen] scale];
    
    //横屏
    frame.origin.y = h/scale - frame.size.height-adOffsetY/scale;
    frame.origin.x = (w/scale  - frame.size.width)/2;
    
    
    
    NSLog(@"adbaner::x=%f,y=%f w=%f,h=%f, adOffsetY =%d",frame.origin.x,frame.origin.y,frame.size.width,frame.size.height,adOffsetY);
    
    viewAd.frame = frame;
    
}

- (void)adBannerDidReceiveAd
{
    
    if(!viewAd){
        return;
    }
    
    
    // viewAd.frame = frame
    [self layoutSubView:screenW height:screenH];
    
    
    CGRect frame =  viewAd.frame;
    float scale = [[UIScreen mainScreen] scale];
    //    CCAdBannerIos *p =(CCAdBannerIos *)poitThis;
    //    if(p){
    //        p->didReceiveAd(frame.size.width*scale, frame.size.height*scale);
    //    }
    char ptmp[1024]={0};
    int w = (int)(frame.size.width*scale);
    int h = (int)(frame.size.height*scale);
    sprintf(ptmp, "%d:%d",w,h);
    UnitySendMessage("Scene", "AdBannerDidReceiveAd", ptmp);
    
    // adMogoView.hidden = !isshowad;
}


//callback
-(void) didFail
{
    char *ptmp =(char *) [self.source UTF8String];
     UnitySendMessage("Scene", "AdBannerDidReceiveAdFail", ptmp);
}
-(void) willShow
{
    //UnitySendMessage("Scene", "AdInsertWillShow", "");
}
-(void) didClose
{
    //UnitySendMessage("Scene", "AdInsertDidClose", "");
}

@end

//
//  AdBannerObj.m
//  moonma_tankcity
//
//  Created by chen Jaykie on 13-10-2.
//
// 
#import "AdBannerObj.h"





@interface AdBannerObj () <AdBannerDelegate>


{
    //果盟横幅(Banner)广告
   // AdMoGoView  *adMogoView;
    
   //  DianJinBanner *offerBanner;
    
    //admob
    
    
    
    
   
    //std::string strAdSource;
}

@end

@implementation AdBannerObj
@synthesize appId;
@synthesize appKey;

static AdBannerObj *sharedAdBannerObj = nil;


// Init
+ (AdBannerObj *) sharedAdBannerObj
{
    @synchronized(self)     {
        if (!sharedAdBannerObj)
            sharedAdBannerObj = [[AdBannerObj alloc] init];
      //  [sharedAdBannerObj setAdSource:AD_SOURCE_ADSMOGO];
        
    }
    return sharedAdBannerObj;
}

-(void)setAdSource:(int )source
{
    adSource = source;
}

-(void) setClassePoit:(void *) p
{
    poitThis = p;
}

-(void) setAd:(NSString *) strSource
{ 
    self.strAdSource = strSource;
    [self performSelectorOnMainThread:@selector(setAdOnMainThread) withObject:nil waitUntilDone:NO];
}

-(void) setAdOnMainThread

{
    Class kclass = nil;
   // return;
    #ifdef ENABLE_AD_GDT
    if ([self.strAdSource isEqualToString:STRING_AD_SOURCE_GDT])
    {
        
//        adBanner = [[AdBannerGdt alloc]init];
        kclass = objc_getClass("AdBannerGdt"); 
    }
    #endif
    #ifdef ENABLE_AD_Baidu
    if ([self.strAdSource isEqualToString:STRING_AD_SOURCE_Baidu])
    {
        
//        adBanner = [[AdBannerBaidu alloc]init];
        kclass = objc_getClass("AdBannerBaidu");
    }
    #endif
    #ifdef ENABLE_AD_Chsj
    if ([self.strAdSource isEqualToString:STRING_AD_SOURCE_Chsj])
    {
        
//        adBanner = [[AdBannerChsj alloc]init];
        kclass = objc_getClass("AdBannerChsj");
  
    }
    #endif

    
    if ([self.strAdSource isEqualToString:STRING_AD_SOURCE_ADMOB])
    {
//        adBanner = [[AdBannerAdmob alloc]init];
        kclass = objc_getClass("AdBannerAdmob");
    }
    
    // if ([self.strAdSource isEqualToString:STRING_AD_SOURCE_ADVIEW])
    // {
    //     adBanner = [[AdBannerAdView alloc]init];
    // }
    // if ([self.strAdSource isEqualToString:STRING_AD_SOURCE_Inmobi])
    // {
        
    //     adBanner = [[AdBannerInmobi alloc]init];
    // }
    // if ([self.strAdSource isEqualToString:SOURCE_MobVista])
    // {
        
    //     adBanner = [[AdBannerMobVista alloc]init];
    // }
    if(kclass==nil)
    {
        [self OnFail];
        return;
    }
    adBanner = [[kclass alloc]init];

    if(adBanner!=nil){
        [self setScreenSize:screenWidth height:screenHeight];
//        adBanner.delegate = self;
//        [adBanner setAd];
        
        Ivar ivar = class_getClassVariable(adBanner, "_delegate");
        object_setIvar(adBanner, ivar, self);
        ((void(*) (id,SEL))objc_msgSend)(adBanner, @selector(setAd));
        
    }
   
 }


-(void) setScreenSize:(int)w height:(int)h
{

    screenWidth = w;
    screenHeight = h;
    if (adBanner) {
//        [adBanner setScreenSize:w height:h];
        ((void(*) (id,SEL,int,int))objc_msgSend)(adBanner, @selector(setScreenSize:height:),w,h);
    }
}
-(void) setScreenOffset:(int)x ofty:(int)y
{

    adOffsetX = x;
    adOffsetY = y;
    if (adBanner) {
//        [adBanner setScreenOffset:x ofty:y];
        ((void(*) (id,SEL,int,int))objc_msgSend)(adBanner, @selector(setScreenOffset:ofty:),x,y);
    }
}
 



-(void)setAlpha:(float )alpha
{
    adAlpha = alpha;
     [self performSelectorOnMainThread:@selector(setAlphaOnMainThread) withObject:nil waitUntilDone:NO];
}

-(void) setAlphaOnMainThread
{
     
    if (adBanner) {
//        [adBanner setAlpha:adAlpha];
        ((void(*) (id,SEL,float))objc_msgSend)(adBanner, @selector(setAlpha:),adAlpha);
    }
    
}

-(void) show:(bool)isShow
{
    isshowad = isShow; 
    if(isShow){
     NSLog(@"isShow=%d",isShow);
    }
     [self performSelectorOnMainThread:@selector(showOnMainThread) withObject:nil waitUntilDone:NO];
}

-(void) showOnMainThread
{
    
    if (adBanner) {
//        [adBanner setScreenOffset:adOffsetX ofty:adOffsetY];
        ((void(*) (id,SEL,int,int))objc_msgSend)(adBanner, @selector(setScreenOffset:ofty:),adOffsetX,adOffsetY);
        
//        [adBanner show:isshowad];
        ((void(*) (id,SEL,bool))objc_msgSend)(adBanner, @selector(show:),isshowad);
    }
    
}



-(void)layoutSubView:(int)w height:(int)h
{
    if (adBanner) {
//        [adBanner layoutSubView:w height:h];
        ((void(*) (id,SEL,int,int))objc_msgSend)(adBanner, @selector(layoutSubView:height:),w,h);
    }
}
-(void) OnFail
{
    if(adBanner!=nil)
    {
        ((void(*) (id,SEL))objc_msgSend)(adBanner, @selector(didFail));
    }
}


#pragma mark delegate
- (void)AdBannerDidFail:(AdBannerBase *)ad
{
//    if ([ad.source isEqualToString:STRING_AD_SOURCE_ADMOB]) {
//        [self setAd:STRING_AD_SOURCE_GDT appid:self.appId key:self.appKey];
//        [self show:isshowad offsety:adOffsetY];
//    }
}
@end

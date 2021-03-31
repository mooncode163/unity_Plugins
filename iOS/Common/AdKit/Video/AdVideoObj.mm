//
//  AdVideoObj.m
//  moonma_tankcity
//
//  Created by chen Jaykie on 13-10-2.
//
//

#import "AdVideoObj.h"


//账号id
#define ACCOUNT_ID_INMOBI   @"18da910b826940e1abbb916e69dda1f2"
bool g_is_inmobi_sdk_init = false;
 


@interface AdVideoObj () 


{
    
}


@end

@implementation AdVideoObj
@synthesize appId;
@synthesize appKey;
@synthesize appSplashId;
@synthesize appSplashKey;
static AdVideoObj *sharedAdVideoObj = nil;


// Init
+ (AdVideoObj *) sharedAdVideoObj
{
    @synchronized(self)
    {
        if (!sharedAdVideoObj){
            sharedAdVideoObj = [[AdVideoObj alloc] init];
        }
    }
    return sharedAdVideoObj;
}



-(void) setBackground:(bool) isBackground
{
    if(AdVideo){
        ((void(*) (id,SEL,bool))objc_msgSend)(AdVideo, @selector(setBackground:),objc_msgSend);
      
    }
    
}

-(void) setType:(int) type
{
     adType = type;
}
-(void)setAdSource:(int )source
{
     
}
-(void) createAd:(NSString *) strSource
{
    Class kclass = nil;
 
    
    if ([strSource isEqualToString:STRING_AD_SOURCE_UNITY])
    {
        kclass = objc_getClass("AdVideoUnity");
        if(kclass==nil)
        {
            [self OnFail];
            return ;
        }

        AdVideo = ((id(*)  (id , SEL ))objc_msgSend)(kclass , @selector(sharedAdVideoUnity));
//        ad = [AdVideoUnity sharedAdVideoUnity];
    }
    
    if ([strSource isEqualToString:STRING_AD_SOURCE_ADMOB])
    {
        
//        ad = [AdVideoAdmob sharedAdVideoAdmob];
        
        kclass = objc_getClass("AdVideoAdmob");
        if(kclass==nil)
        {
            [self OnFail];
            return ;
        }

        AdVideo = ((id(*)  (id , SEL ))objc_msgSend)(kclass , @selector(sharedAdVideoAdmob));
    }
    
    // if ([strSource isEqualToString:STRING_AD_SOURCE_Inmobi])
    // {
        
    //     ad = [AdVideoInmobi sharedAdVideoInmobi];
    // }
    // if ([strSource isEqualToString:STRING_AD_SOURCE_ADVIEW])
    // {
        
    //     ad = [AdVideoAdView sharedAdVideoAdView];
    // }
    // if ([strSource isEqualToString:SOURCE_MobVista])
    // {
    //     ad = [AdVideoMobVista sharedAdVideoMobVista];
    // }
   
}
-(void) preloadAd:(NSString *) strSource
{
    //self.strPreloadAdSource = strSource; 
    [self performSelectorOnMainThread:@selector(preloadAdOnMainThread:) withObject:strSource waitUntilDone:NO];
}

-(void) preloadAdOnMainThread:(NSString *) str
{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    UIViewController *controller = keyWindow.rootViewController;
   [self createAd:str];
    //AdVideo.delegate = self;
//    [ad setType:adType];
//    [ad setAd];
    
    ((void(*) (id,SEL,int))objc_msgSend)(AdVideo, @selector(setType:),adType);
    ((void(*) (id,SEL))objc_msgSend)(AdVideo, @selector(setAd));
}

-(void) setAd:(NSString *) strSource
{ 
   // self.strAdSource = strSource; 
    
    [self performSelectorOnMainThread:@selector(setAdOnMainThread:) withObject:strSource waitUntilDone:NO];
}

-(void) setAdOnMainThread:(NSString *) str
{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    UIViewController *controller = keyWindow.rootViewController;
     [self createAd:str];
//    AdVideo.delegate = self;
//    [AdVideo setType:adType];
//    [AdVideo setAd];
    
    Ivar ivar = class_getClassVariable(AdVideo, "_delegate");
    object_setIvar(AdVideo, ivar, self);
    ((void(*) (id,SEL,int))objc_msgSend)(AdVideo, @selector(setType:),adType);
    ((void(*) (id,SEL))objc_msgSend)(AdVideo, @selector(setAd));
}



-(void) OnFail
{
    if(AdVideo!=nil)
    {
        ((void(*) (id,SEL))objc_msgSend)(AdVideo, @selector(didFail));
    }
}


-(void) show
{
    [self performSelectorOnMainThread:@selector(showOnMainThread) withObject:nil waitUntilDone:NO];
    
    
}

-(void) showOnMainThread
{
    if(AdVideo==nil)
    {
        return;
    }
    ((void(*) (id,SEL,int))objc_msgSend)(AdVideo, @selector(setType:),adType);
    ((void(*) (id,SEL))objc_msgSend)(AdVideo, @selector(show));
}
-(void) onClickAd
{
    [self performSelectorOnMainThread:@selector(onClickAdOnMainThread) withObject:nil waitUntilDone:NO];
    
    
}
-(void) onClickAdOnMainThread
{
    if(AdVideo==nil)
    {
        return;
    }
    ((void(*) (id,SEL))objc_msgSend)(AdVideo, @selector(onClickAd));
    
}


-(void) setClassePoit:(void *) p
{
    poitAdVideo = p;
}

#pragma mark delegate
- (void)AdVideoDidFail:(AdVideoBase *)ad
{
   // if ([ad.source isEqualToString:STRING_AD_SOURCE_ADMOB])
   // {
        //[self setAd:STRING_AD_SOURCE_GDT appid:self.appId key:self.appKey];
        //[self show];
   // }
    
}







@end


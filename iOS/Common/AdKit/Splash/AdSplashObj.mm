//
//  CCAdSplashObj.m
//  moonma_tankcity
//
//  Created by chen Jaykie on 13-10-2.
//
//

#import "AdSplashObj.h"


//账号id
#define ACCOUNT_ID_INMOBI   @"18da910b826940e1abbb916e69dda1f2"
bool g_is_inmobi_sdk_init = false;
 


@interface AdSplashObj ()


{
     
    
    
}


@end

@implementation AdSplashObj
@synthesize appId;
@synthesize appKey;
@synthesize appSplashId;
@synthesize appSplashKey; 
static AdSplashObj *sharedAdSplashObj = nil;


// Init
+ (AdSplashObj *) sharedAdSplashObj
{
    @synchronized(self)     {
        if (!sharedAdSplashObj)
            sharedAdSplashObj = [[AdSplashObj alloc] init];
    }
    return sharedAdSplashObj;
}



-(void) setBackground:(bool) isBackground
{
    if(adSplash){
        ((void(*) (id,SEL,bool))objc_msgSend)(adSplash, @selector(setBackground:),isBackground);
//        [adSplash setBackground:isBackground];
    }
    
}

-(void) setAd:(NSString *) strSource tpye:(int)strType
{
//    std::string source([strSource UTF8String]);
//    strAdSource = source;
//
    self.strAdSource = strSource;
     
    adType = strType;
    
    [self performSelectorOnMainThread:@selector(setAdOnMainThread) withObject:nil waitUntilDone:NO];
}

-(void) setAdOnMainThread
{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    UIViewController *controller = keyWindow.rootViewController;
    Class kclass = nil;
    #ifdef ENABLE_AD_GDT
    if ([self.strAdSource isEqualToString:STRING_AD_SOURCE_GDT])
    {
//        adSplash = [[AdSplashGdt alloc]init];
        
        kclass = objc_getClass("AdSplashGdt");
 
   
    }
    #endif

    #ifdef ENABLE_AD_Baidu
    if ([self.strAdSource isEqualToString:STRING_AD_SOURCE_Baidu])
    {
//        adSplash = [[AdSplashBaidu alloc]init];
        kclass = objc_getClass("AdSplashBaidu");
    }
    #endif
    
    
        #ifdef ENABLE_AD_Chsj
    if ([self.strAdSource isEqualToString:STRING_AD_SOURCE_Chsj])
    {
//        adSplash = [[AdSplashChsj alloc]init];
        kclass = objc_getClass("AdSplashChsj");
    }
    #endif
    
     if ([self.strAdSource isEqualToString:STRING_AD_SOURCE_ADMOB])
     {
//         adSplash = [[AdSplashAdmob alloc]init];
         kclass = objc_getClass("AdSplashAdmob");
        
     }
    // if ([self.strAdSource isEqualToString:STRING_AD_SOURCE_ADVIEW])
    // {
    //     adSplash = [[AdSplashAdView alloc]init];
        
    // }
    
    if(kclass==nil)
    {
        [self OnFail];
        return ;
    }
    adSplash = [[kclass alloc]init];
    {
        Ivar ivar = class_getClassVariable(adSplash, "_delegate");
        object_setIvar(adSplash, ivar, self);
    }
    {
        Ivar ivar = class_getClassVariable(adSplash, "_adType");
//        object_setIvar(adSplash, ivar, adType);
    }
   
//        adSplash.adType = adType;
//        adSplash.delegate = self;
//     [adSplash setAd];
    
     ((id(*)  (id , SEL ))objc_msgSend)(adSplash , @selector(setAd));
}
-(void)setAdSource:(int )source
{
     
}


-(void) OnFail
{
    if(adSplash!=nil)
    {
        ((void(*) (id,SEL))objc_msgSend)(adSplash, @selector(didFail));
    }
}



-(void) show
{
    [self performSelectorOnMainThread:@selector(showOnMainThread) withObject:nil waitUntilDone:NO];
    
    
}

-(void) showOnMainThread
{
         [adSplash show];
     
 
}

-(void) setClassePoit:(void *) p
{
    poitAdInsert = p;
}

#pragma mark delegate
- (void)AdSplashDidFail:(AdSplashBase *)ad
{
//    if ([ad.source isEqualToString:STRING_AD_SOURCE_ADMOB]) {
//        [self setAd:STRING_AD_SOURCE_GDT appid:self.appId key:self.appKey];
//        [self show];
//    }
    
}
 





@end


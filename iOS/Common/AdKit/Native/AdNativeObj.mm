//
//  AdNativeObj.m
//  moonma_tankcity
//
//  Created by chen Jaykie on 13-10-2.
//
//

#import "AdNativeObj.h"


//账号id
#define ACCOUNT_ID_INMOBI   @"18da910b826940e1abbb916e69dda1f2"
bool g_is_inmobi_sdk_init = false;
 


@interface AdNativeObj () 


{
    
}


@end

@implementation AdNativeObj
@synthesize appId;
@synthesize appKey;
@synthesize appSplashId;
@synthesize appSplashKey;
static AdNativeObj *sharedAdNativeObj = nil;


// Init
+ (AdNativeObj *) sharedAdNativeObj
{
    @synchronized(self)
    {
        if (!sharedAdNativeObj){
            sharedAdNativeObj = [[AdNativeObj alloc] init];
        }
    }
    return sharedAdNativeObj;
}



-(void) setBackground:(bool) isBackground
{
    if(adNative){
//        [adNative setBackground:isBackground];
        ((void(*) (id,SEL,bool))objc_msgSend)(adNative, @selector(setBackground:),isBackground);
    }
    
}

-(void) setAd:(NSString *) strSource  
{
    self.strAdSource = strSource;
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
        kclass = objc_getClass("AdNativeGdt");
//        adNative = [[AdNativeGdt alloc]init];
    }
    #endif

    #ifdef ENABLE_AD_Baidu
    if ([self.strAdSource isEqualToString:STRING_AD_SOURCE_Baidu])
    {
        kclass = objc_getClass("AdNativeBaidu");
//        adNative = [[AdNativeBaidu alloc]init];
    }
    #endif
    
       #ifdef ENABLE_AD_Chsj
    if ([self.strAdSource isEqualToString:STRING_AD_SOURCE_Chsj])
    {
        kclass = objc_getClass("AdNativeChsj");
//        adNative = [[AdNativeChsj alloc]init];
    }
    #endif 
       
    if ([self.strAdSource isEqualToString:STRING_AD_SOURCE_ADMOB])
    {
        kclass = objc_getClass("AdNativeAdmob");
//        adNative = [[AdNativeAdmob alloc]init];
    }
     
//    adNative.delegate = self;
//     [adNative setAd];
    
    if(kclass==nil)
    {
        [self OnFail];
        return ;
    }
    adNative = [[kclass alloc]init];
    {
        Ivar ivar = class_getClassVariable(adNative, "_delegate");
        object_setIvar(adNative, ivar, self);
    }
 
   
//        adSplash.adType = adType;
//        adSplash.delegate = self;
//     [adSplash setAd];
    
     ((void(*)  (id , SEL ))objc_msgSend)(adNative , @selector(setAd));
}

-(void)setAdSource:(int )source
{
     
}

-(void) OnFail
{
    if(adNative!=nil)
    {
        ((void(*) (id,SEL))objc_msgSend)(adNative, @selector(didFail));
    }
}



-(void) show
{
    [self performSelectorOnMainThread:@selector(showOnMainThread) withObject:nil waitUntilDone:NO];
}

-(void) showOnMainThread
{
//         [adNative show];
    if(adNative==nil)
    {
        return;
    }
    ((void(*)  (id , SEL ))objc_msgSend)(adNative , @selector(show));
  
} 
-(void) showSplash:(NSString *) strSource  
{
   [self setAd:strSource];
   //  self.strAdSource = strSource;
    [self performSelectorOnMainThread:@selector(showSplashOnMainThread) withObject:nil waitUntilDone:NO];
}

-(void) showSplashOnMainThread
{
//     [adNative showSplash];
    ((void(*)  (id , SEL ))objc_msgSend)(adNative , @selector(showSplash));
}


-(void) onClickAd
{
    [self performSelectorOnMainThread:@selector(onClickAdOnMainThread) withObject:nil waitUntilDone:NO];
    
    
}
-(void) onClickAdOnMainThread
{
//    [adNative onClickAd];
    ((void(*)  (id , SEL ))objc_msgSend)(adNative , @selector(onClickAd));
}


-(void) setClassePoit:(void *) p
{
    poitAdNative = p;
}

#pragma mark delegate
- (void)AdNativeDidFail:(AdNativeBase *)ad
{
   // if ([ad.source isEqualToString:STRING_AD_SOURCE_ADMOB])
   // {
        //[self setAd:STRING_AD_SOURCE_GDT appid:self.appId key:self.appKey];
        //[self show];
   // }
    
}







@end


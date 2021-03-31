//
//  AdInsertObj.m
//  moonma_tankcity
//
//  Created by chen Jaykie on 13-10-2.
//
//

#import "AdInsertObj.h"
#import "AdInsertAdmob.h"

//账号id
#define ACCOUNT_ID_INMOBI   @"18da910b826940e1abbb916e69dda1f2"
bool g_is_inmobi_sdk_init = false;



@interface AdInsertObj ()
{
    AdInsertAdmob *adInsertAdmob;
//     id adInsertAdmob;
    //GDTSplashAd *_splashGdt;
}


@end

@implementation AdInsertObj
@synthesize appId;
@synthesize appKey;
@synthesize appSplashId;
@synthesize appSplashKey;
@synthesize unityObjName;

static AdInsertObj *sharedAdInsertObj = nil;


// Init
+ (AdInsertObj *) sharedAdInsertObj
{
    @synchronized(self)
    {
        if (!sharedAdInsertObj){
            sharedAdInsertObj = [[AdInsertObj alloc] init];
        }
    }
    return sharedAdInsertObj;
}



-(void) setBackground:(bool) isBackground
{
//    if(adInsert){
//        [adInsert setBackground:isBackground];
//    }
    
    if(adInsert!=nil)
    {
         ((void(*) (id,SEL,bool))objc_msgSend)(adInsert, @selector(setBackground:),isBackground);
    }
    
}

-(void) setUnityObjectInfo:(NSString *)strObjName
{
    self.unityObjName = strObjName;
}

-(void) setAd:(NSString *) strSource  
{
     
    self.strAdSource = strSource;
    
    NSLog(@"AdInsertObj  setAd strSource=%@",self.strAdSource);
    
//    self.strAdSource = STRING_AD_SOURCE_Baidu;
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
        kclass = objc_getClass("AdInsertGdt");
        if(kclass==nil)
        {
            [self OnFail];
            return;
        }
        adInsert = [[kclass alloc]init];
//        adInsert = [[AdInsertGdt alloc]init];
    }
#endif

#ifdef ENABLE_AD_Baidu
    if ([self.strAdSource isEqualToString:STRING_AD_SOURCE_Baidu])
    {
//        adInsert = [AdInsertBaidu sharedAdInsertBaidu];
        kclass = objc_getClass("AdInsertBaidu");
        if(kclass==nil)
        {
            [self OnFail];
            return;
        }
//        adInsert = [kclass sharedAdInsertBaidu];
//(id(*)  (id , SEL ) 含义 返回类型为id参数2个 id 和 sel
        adInsert = ((id(*)  (id , SEL ))objc_msgSend)(kclass , @selector(sharedAdInsertBaidu));
        
      
    }
#endif

    
    #ifdef ENABLE_AD_Chsj
    if ([self.strAdSource isEqualToString:STRING_AD_SOURCE_Chsj])
    {
//        adInsert = [[AdInsertChsj alloc]init];
        kclass = objc_getClass("AdInsertChsj");
        if(kclass==nil)
        {
            [self OnFail];
            return;
        }
        adInsert = [[kclass alloc]init];
    }
#endif

    if ([self.strAdSource isEqualToString:STRING_AD_SOURCE_ADMOB])
    {
#if 1
        // admob 8.0 用动态加载插屏会crash 该用静态加载
        adInsertAdmob = [AdInsertAdmob sharedAdInsertAdmob];
        adInsertAdmob.isUseAsSplash = false;
        // adInsert = adInsertAdmob;
        adInsert = nil;
        adInsertAdmob.delegate = self;
        [adInsertAdmob setAd];
        return;
        
#else
          kclass = objc_getClass("AdInsertAdmob");
        if(kclass==nil)
        {
            [self OnFail];
            return;
        }
//        adInsertAdmob = [kclass sharedAdInsertAdmob];
        adInsert = ((id(*)  (id , SEL ))objc_msgSend)(kclass , @selector(sharedAdInsertAdmob));
        
       
        Ivar ivar = class_getClassVariable(adInsert, "_isUseAsSplash");
//bool @(false) int @(10)
         object_setIvar(adInsert, ivar, @(false));
        NSLog(@"AdInsertAdmob isUseAsSplash =%@",object_getIvar(adInsert,ivar));
        
        
//        object_setIvar(adInsertAdmob, ivar, @"testname");
//        adInsert = adInsertAdmob;
//        [adInsert setUnityObjectInfo:self.unityObjName];
        
       
//        ((void(*) (id,SEL,NSString *))objc_msgSend)(adInsert, @selector(setUnityObjectInfo:),self.unityObjName);
  
        
//        adInsert.delegate = self;
//          ivar = class_getClassVariable(adInsert, "_delegate");
//        object_setIvar(adInsert, ivar, self);
        
//        [adInsert setAd];
//        ((void(*) (id,SEL))objc_msgSend)(adInsert, @selector(setAd));
        
//            ((void(*) (id,SEL,NSString *,NSString *))objc_msgSend)([[kclass alloc] init], @selector(Run4:str1:),@"test",@"test1");
        
//         return;
#endif
    }
    if ([self.strAdSource isEqualToString:STRING_AD_SOURCE_UNITY])
    {
//        adInsert = [[AdInsertUnity alloc]init];
        kclass = objc_getClass("AdInsertUnity");
        if(kclass==nil)
        {
            [self OnFail];
            return;
        }
        adInsert = [[kclass alloc]init];
        
    }
    // if ([self.strAdSource isEqualToString:STRING_AD_SOURCE_Inmobi])
    // {
        
    //     adInsert = [[AdInsertInmobi alloc]init];
    // }
    // if ([self.strAdSource isEqualToString:SOURCE_MobVista])
    // { 
    //     adInsert = [[AdInsertVideoMobVista alloc]init];
    // }
    
//    [adInsert setUnityObjectInfo:self.unityObjName];
    ((void(*) (id,SEL,NSString *))objc_msgSend)(adInsert, @selector(setUnityObjectInfo:),self.unityObjName);

//    adInsert.delegate = self;
    Ivar ivar = class_getClassVariable(adInsert, "_delegate");
    object_setIvar(adInsert, ivar, self);
    ((void(*) (id,SEL))objc_msgSend)(adInsert, @selector(setAd));
   
}

-(void)setAdSource:(int )source
{
     
}

-(void) OnFail
{
    if(adInsert!=nil)
    {
        ((void(*) (id,SEL))objc_msgSend)(adInsert, @selector(didFail));
    }
}




-(void) show
{
    NSLog(@"AdInsertObj  show strSource=%@",self.strAdSource);
    [self performSelectorOnMainThread:@selector(showOnMainThread) withObject:nil waitUntilDone:NO];
    
    
}

-(void) showOnMainThread
{
    NSLog(@"AdInsertObj::showOnMainThread self.strAdSource=%@",self.strAdSource);
//    if(adInsert!=nil){
//        [adInsert show];
//    }
//    if ([self.strAdSource isEqualToString:STRING_AD_SOURCE_ADMOB])
    if(adInsert!=nil)
    {
        NSLog(@"AdInsertObj::showOnMainThread 1");
        ((void(*) (id,SEL))objc_msgSend)(adInsert, @selector(show));
    }else{
        NSLog(@"AdInsertObj::showOnMainThread 2");
        if(adInsertAdmob!=nil)
        {
            NSLog(@"AdInsertObj::showOnMainThread 3");
            [adInsertAdmob show];
        }
    }
    
   
}

-(void) setClassePoit:(void *) p
{
    poitAdInsert = p;
}

#pragma mark delegate
- (void)AdInsertDidFail:(AdInsertBase *)ad
{
    // if ([ad.source isEqualToString:STRING_AD_SOURCE_ADMOB])
    // {
    //[self setAd:STRING_AD_SOURCE_GDT appid:self.appId key:self.appKey];
    //[self show];
    // }
    
}

- (void)AdInsertDidLoad:(AdInsertBase *)ad
{
    NSLog(@"AdInsertObj::AdInsertDidLoad");
    if ([self.strAdSource isEqualToString:STRING_AD_SOURCE_ADMOB])
    {
        static bool isfirst = false;
        if(!isfirst){
            isfirst = true;
            //在adInsertAdmob.delegate 被更新之后 AdSplashAdmob的AdInsertDidLoad不会被执行而不显示插屏
            //显示第一次开机插屏
           //[adInsert show];
        }
        
        
    }
}







@end


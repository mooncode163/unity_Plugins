//
//  UnityEngineCloudiOS.mm
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
#import "Common.h"
#import <sys/utsname.h>  
//
//@interface UnityEngineCloudUtil : NSObject
//+(const char*) makeStringCopy:(NSString*)nsString;
//+(NSString*) createNSString:(const char*)string;
//@end
//
//@implementation UnityEngineCloudUtil
//
//+(const char*) makeStringCopy:(NSString*)nsString
//{
//    const char* utf8Val = nsString ? [nsString UTF8String] : "";
//	char* res = (char*)malloc(strlen(utf8Val) + 1);
//	strcpy(res, utf8Val);
//	return res;
//}
//
//// Converts C style string to NSString
//+(NSString*) createNSString:(const char*)string
//{
//    if (string)
//    {
//        return [NSString stringWithUTF8String: string];
//    }
//    return nil;
//}
//@end


//
///////
//@interface UnityEngineCloudMobileProvisionUtil : NSObject
//+(NSDictionary*) getMobileProvision;
//@end
//
//@implementation UnityEngineCloudMobileProvisionUtil
//
//+(NSString*) getMobileProvisionFilePath
//{
//    return [[NSBundle mainBundle] pathForResource:@"embedded" ofType:@"mobileprovision"];
//}
//
//+(NSString*) getMobileProvisionAllContent
//{
//    NSString* mobileProvisionFilePath = [UnityEngineCloudMobileProvisionUtil getMobileProvisionFilePath];
//    if (mobileProvisionFilePath==nil)
//        return nil;
//    
//    return [NSString stringWithContentsOfFile:mobileProvisionFilePath
//                                     encoding:NSISOLatin1StringEncoding error:NULL];
//}
//
//+(NSString*) getMobileProvisionPlistContent
//{
//    NSString* mobileProvisionContent = [UnityEngineCloudMobileProvisionUtil getMobileProvisionAllContent];
//    if (mobileProvisionContent==nil)
//        return nil;
//    
//    NSScanner* plistScanner = [NSScanner scannerWithString:mobileProvisionContent];
//    if ([plistScanner scanUpToString:@"<plist" intoString:nil]==NO)
//        return nil;
//    
//    NSString* plistContent;
//    if ([plistScanner scanUpToString:@"</plist>" intoString:&plistContent]==NO)
//        return nil;
//    
//    return [NSString stringWithFormat:@"%@</plist>", plistContent];
//}
//
//+(NSDictionary*) getMobileProvision
//{
//    NSString* mobileProvisionPlistContent = [UnityEngineCloudMobileProvisionUtil getMobileProvisionPlistContent];
//    if (mobileProvisionPlistContent==nil)
//        return nil;
//    
//    NSData* plistData = [mobileProvisionPlistContent dataUsingEncoding:NSISOLatin1StringEncoding];
//    NSError* error = nil;
//    return [NSPropertyListSerialization propertyListWithData:plistData
//                                                     options:NSPropertyListImmutable format:NULL error:&error];
//}
//
//@end


/////
extern "C" {
    
    static NSDictionary* mobileProvision = nil;
    static bool lookedForMobileProvision = NO;
    static int toOrientaion;
    
    bool isBlankString(NSString *str)
    {
        bool ret = false;
        if(!str){
            return true;
        }
        if ([str length]==0) {
            ret = true;
        }
        if ([str isEqualToString:@" "]) {
            ret = true;
        }
        return ret;
    }
    
    const char* makeStringCopy(NSString*nsString)
    {
        const char* utf8Val = nsString ? [nsString UTF8String] : "";
    	char* res = (char*)malloc(strlen(utf8Val) + 1);
    	strcpy(res, utf8Val);
    	return res;
    }
    
    const char* Common_GetCachePath()
    {
        NSString *tmpDir = NSTemporaryDirectory();
        return makeStringCopy(tmpDir);
    }
    const char * Common_GetLibCatchPath()
    {
        NSString *tmpDir = [NSString stringWithFormat:@"%@/Library/Caches",NSHomeDirectory()];
        return makeStringCopy(tmpDir);
    }
    
   const char * Common_GetAppName()
    {
        NSString *str = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
        //NSString *str = [[[NSBundle mainBundle] localizedInfoDictionary] objectForKey:@"CFBundleDisplayName"];
        //NSString *str = NSLocalizedString(@"CFBundleDisplayName", nil);
        
        return makeStringCopy(str);
        
    }
    
    
    const char * Common_GetAppPackage()
    {
        // CFBundleShortVersionString verion
        //CFBundleVersion build
        NSString *str = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
        // NSLog(@"getPackege_ios::%@",str);
        
        
        return makeStringCopy(str);
        
    }
    
    
    const char * Common_GetAppVersion()
    {
        // CFBundleShortVersionString verion
        //CFBundleVersion build
        NSString *str = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        NSLog(@"getAppVersion::%@",str);
        if (str==Nil) {
            str = @"1.0.0";
        }
        
         return makeStringCopy(str);
        
    }
    
    void Common_EnableAdSplash()
    {
        
        bool isEnable = [[NSUserDefaults standardUserDefaults] boolForKey:KEY_ENABLE_ADSPLASH];
        if(!isEnable){
             NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];     
            [userDefaults setBool:YES forKey:KEY_ENABLE_ADSPLASH]; 
            //在存储数据的地方,别忘了这一句 
            [[NSUserDefaults standardUserDefaults] synchronize];

            StartAdSplash();
        }
        
        
 
    }

    void Common_SetIpInChina(bool in)
    {

             NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];     
            [userDefaults setBool:in forKey:KEY_IP_IN_CHINA]; 
            //在存储数据的地方,别忘了这一句 
            [[NSUserDefaults standardUserDefaults] synchronize];
 
    } 

 
    bool Common_IsNoAd()
    {
        bool ret = [[NSUserDefaults standardUserDefaults] boolForKey:KEY_APP_NO_AD];
        return ret;
    }
    void Common_SetNoAd()
    {
             NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];     
            [userDefaults setBool:true forKey:KEY_APP_NO_AD]; 
            //在存储数据的地方,别忘了这一句 
            [[NSUserDefaults standardUserDefaults] synchronize];
    }

 
void setOrientationOnMainThread()
{
    
    //强制旋转屏幕
    if([[UIDevice currentDevice]respondsToSelector:@selector(setOrientation:)]) {
        
        int toOrientationDevice = UIDeviceOrientationPortrait;
        switch (toOrientaion) {
            case UIORIENTATION_ALL:
                toOrientationDevice = UIDeviceOrientationUnknown;
                break;
                
            case UIORIENTATION_PortraitUp:
                toOrientationDevice = UIDeviceOrientationPortrait;
                break;
                
            case UIORIENTATION_PortraitDown:
                toOrientationDevice = UIDeviceOrientationPortraitUpsideDown;
                break;
                
            case UIORIENTATION_LandscapeRight:
                toOrientationDevice = UIDeviceOrientationLandscapeLeft;
                break;
                
            case UIORIENTATION_LandscapeLeft:
                toOrientationDevice = UIDeviceOrientationLandscapeRight;
                break;
                
                
            case UIORIENTATION_Portrait:
                toOrientationDevice = UIDeviceOrientationPortrait;
                break;
                
            case UIORIENTATION_Landscape:
                toOrientationDevice = UIDeviceOrientationLandscapeLeft;//UIDeviceOrientationLandscapeRight
                break;
                
                
            default:
                break;
        }
        
        NSInteger a = toOrientationDevice;
        id b = @(a);//NSNumber * someNumber = @(3);
       // void *p = (__bridge void *)&toOrientationDevice;
        
       //id dt = (__bridge id)*p;
        //no ARC
        //[[UIDevice currentDevice]performSelector:@selector(setOrientation:) withObject:(id)toOrientationDevice];
       
        //ARC
        if(toOrientationDevice!=UIDeviceOrientationUnknown){
            [[UIDevice currentDevice]performSelector:@selector(setOrientation:) withObject:b];
        }
    }
    
}
    
    void Common_SetOrientation(int orientaion)
    {
        UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
        UIViewController *controller = keyWindow.rootViewController;
        // RootViewController *root = (RootViewController*)controller;
        
        //     if([root respondsToSelector:@selector(setOrientation:)])
        //     {
        //         [root setOrientation:orientaion];
        //     }
        toOrientaion = orientaion;
        setOrientationOnMainThread();
        //[controller performSelectorOnMainThread:@selector(setOrientationOnMainThread) withObject:nil waitUntilDone:NO];
        
    }

    
    bool IsDeviceIPad()
    {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 30200
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            return YES;
        }
#endif
        return NO;
    }
 
 //iOS 刘海屏判断
    bool isIPhoneX()
    {
        // 根据安全区域判断
        if (@available(iOS 11.0, *)) {
            CGFloat height = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom;
            return (height > 0);
        } else {
            return NO;
        } 
    }

     bool Common_IsiPhoneX()
     { 
           return isIPhoneX();
           /*
    struct utsname systemInfo;  
  
    uname(&systemInfo);  
  
    NSString* deviceName  = [NSString stringWithCString:systemInfo.machine  
                                        encoding:NSUTF8StringEncoding]; 
    bool ret = false;

    //if ([deviceString isEqualToString:@"iPhone10,1"])   return @"iPhone 8";
    //if ([deviceString isEqualToString:@"iPhone10,4"])   return @"iPhone 8";
    // if ([deviceString isEqualToString:@"iPhone10,2"])   return @"iPhone 8 Plus";
    // if ([deviceString isEqualToString:@"iPhone10,5"])   return @"iPhone 8 Plus";
         NSLog(@"deviceName=%@",deviceName);
//    if (([deviceName isEqualToString:@"iPhone10,3"])||([deviceName isEqualToString:@"iPhone10,6"]))
//    {
//        ret = true;
//    }
          CGRect  frame = [UIScreen mainScreen].bounds;
         //iPhoneX 2436 x 1125 @3x
          int h = MAX(frame.size.width, frame.size.height);
         //iPhoneX 2436 x 1125 @3x
         if(h == 812) {
             ret = true;
         }
         
        return ret;

        */

    }

    int Common_GetHeightSystemTopBar()
    {
        int h = 0;
       float scale = [[UIScreen mainScreen] scale];
        CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
        NSLog(@"Common_GetHeightSystemTopBar:scale=%f,rectStatus h=%f",scale,rectStatus.size.height);
        if(Common_IsiPhoneX()){
            //44 pt
            h = 32*scale;
        }
        return h;
    }
	int Common_GetHeightSystemHomeBar()
    {
        int h = 0;
          float scale = [[UIScreen mainScreen] scale];
        NSLog(@"Common_GetHeightSystemHomeBar:scale=%f",scale);
        if(Common_IsiPhoneX()){
            //34 pt
            h = 34*scale;
        }
        return h;
    }
    
}


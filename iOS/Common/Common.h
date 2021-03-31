//
//  Common.h
//  Unity-iPhone
//
//  Created by jaykie Chen on 17/4/14.
//
//

#ifndef Common_h
#define Common_h

#define STRING_AD_SOURCE_Baidu @"baidu"
#define STRING_AD_SOURCE_ADMOB @"admob"
#define STRING_AD_SOURCE_Inmobi @"inmobi"
#define STRING_AD_SOURCE_GDT @"gdt"
#define STRING_AD_SOURCE_Chsj @"chsj"
#define STRING_AD_SOURCE_UNITY @"unity"
#define STRING_AD_SOURCE_ADVIEW @"adview"
#define SOURCE_MobVista @"mobvista"

#define SOURCE_WEIXIN @"weixin"
#define SOURCE_WEIXINFRIEND @"weixinfriend"
#define SOURCE_QQ @"qq"
#define SOURCE_QQZONE @"qqzone"
#define SOURCE_EMAIL @"email"
#define SOURCE_SMS @"sms"
#define SOURCE_WEIBO @"weibo"

//tencent gdt
#define AD_APP_ID_GDT @"1105860933" // 儿童ios
#define AD_APP_ID_GDT_BANNER @"6020515874413711"
#define AD_APP_ID_GDT_INSERT @"6010512834916762"
#define AD_APP_ID_GDT_SPLASH @"9050912894215754"

//adview
#define AD_APP_ID_ADVIEW @"SDK201206150611426lq3b0gbm7ph0en" // 宝宝农场发现ios
#define AD_APP_KEY_ADVIEW_SPLASH @"0"

#define AD_APP_ID_ADMOB @"ca-app-pub-9172948412628142~2786113316" //GameUnity

#define AD_APP_ID_ADMOB_BANNER @"ca-app-pub-9172948412628142/4262846516" //
//#define AD_APP_ID_ADMOB_INSERT AD_APP_ID_ADMOB
#define AD_APP_ID_ADMOB_INSERT @"ca-app-pub-9172948412628142/7216312919"        //
#define AD_APP_ID_ADMOB_NATIVE @"ca-app-pub-9172948412628142/5216198518"        //
#define AD_APP_ID_ADMOB_INSERT_SPLASH @"ca-app-pub-9172948412628142/7216312919" //开机插屏

//key

#define ADSPLASH_TYPE_SPLASH @"splash"
#define ADSPLASH_TYPE_INSERT @"splash_insert"

#define KEY_ENABLE_ADSPLASH @"KEY_ENABLE_ADSPLASH"

#define KEY_ADSPLASH_TYPE @"KEY_ADSPLASH_TYPE"

#define KEY_ADSPLASH_SOURCE @"KEY_ADSPLASH_SOURCE"
#define KEY_ADSPLASH_APPID @"KEY_ADSPLASH_APPID"
#define KEY_ADSPLASH_APPKEY @"KEY_ADSPLASH_APPKEY"

#define KEY_ADSPLASH_INSERT_SOURCE @"KEY_ADSPLASH_INSERT_SOURCE"
#define KEY_ADSPLASH_INSERT_APPID @"KEY_ADSPLASH_INSERT_APPID"
#define KEY_ADSPLASH_INSERT_APPKEY @"KEY_ADSPLASH_INSERT_APPKEY"

#define ADSPLASH_TYPE_DEFAULT ADSPLASH_TYPE_SPLASH //ADSPLASH_TYPE_INSERT

//开屏
#define ADSPLASH_SOURCE_DEFAULT STRING_AD_SOURCE_ADVIEW
#define ADSPLASH_APPID_DEFAULT AD_APP_ID_ADVIEW
#define ADSPLASH_APPKEY_DEFAULT AD_APP_KEY_ADVIEW_SPLASH

//开机插屏
#define ADSPLASH_INSERT_SOURCE_DEFAULT @"gdt"
#define ADSPLASH_INSERT_APPID_DEFAULT AD_APP_ID_GDT
#define ADSPLASH_INSERT_APPKEY_DEFAULT AD_APP_ID_GDT_INSERT
//#define ADSPLASH_INSERT_TYPE_DEFAULT  ADSPLASH_TYPE_INSERT

#define KEY_IP_IN_CHINA @"KEY_IP_IN_CHINA"
#define KEY_APP_NO_AD @"KEY_APP_NO_AD"
//timeout
#define LOAD_AD_TIMEOUT_SECODE_ADMOB 40.0f
#define LOAD_AD_TIMEOUT_SECODE LOAD_AD_TIMEOUT_SECODE_ADMOB

#define SOURCE_TYPE_SPLASH 0
#define SOURCE_TYPE_BANNER 1
#define SOURCE_TYPE_INSERT 2
#define SOURCE_TYPE_SPLASH_INSERT 3
#define SOURCE_TYPE_NATIVE 4
#define SOURCE_TYPE_VIDEO 5
#define SOURCE_TYPE_INSERT_VIDEO 6

//#define ENABLE_SHARE
#define ENABLE_AD_GDT
#define ENABLE_AD_Chsj
#define ENABLE_AD_Baidu

typedef enum
{
    UIORIENTATION_ALL = 0, //all 任意方向
    UIORIENTATION_PortraitUp,
    UIORIENTATION_PortraitDown,
    UIORIENTATION_LandscapeLeft,
    UIORIENTATION_LandscapeRight,
    UIORIENTATION_Portrait,
    UIORIENTATION_Landscape,
} UIOrientation;

#if defined(__cplusplus)
extern "C"
{
#endif
    bool isBlankString(NSString *str);
    extern bool IsDeviceIPad();
    void StartAdSplash();
    bool Common_IsNoAd();
    void Common_SetNoAd();
    const char *Common_GetAppPackage();
    const char* makeStringCopy(NSString*nsString);

#if defined(__cplusplus)
}
#endif
#endif /* Common_h */

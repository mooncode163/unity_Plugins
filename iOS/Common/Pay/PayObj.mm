//
//  CCAdInsertObj.m
//  moonma_tankcity
//
//  Created by chen Jaykie on 13-10-2.
//
//

#import "PayObj.h"
#import "Common.h"
 

#define XcodeAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

static bool isDeviceJailbroken()
{
    bool jailbroken = NO;
    NSString *cydiaPath = @"/Applications/Cydia.app";
    NSString *aptPath = @"/private/var/lib/apt/";
    if ([[NSFileManager defaultManager] fileExistsAtPath:cydiaPath]) {
        jailbroken = YES;
    }
    
    return jailbroken;
}


@interface PayObj()

{
//std::string strAdSource;
}
@end

@implementation PayObj
@synthesize appId;
@synthesize appKey;

static PayObj *s_sharePayObj = nil;


// Init
+ (PayObj *) sharedPayObj
{
    @synchronized(self)     {
        if (!s_sharePayObj)
            s_sharePayObj = [[PayObj alloc] init];
    }
    return s_sharePayObj;
}


-(void) setAppId:(NSString *) strAppId
{
    
} 


-(void) setClassePoit:(void *) p
{
    pointThis = p;
}
 

-(void) payContent:(NSString *)strType title:(NSString *)strTitle detail:(NSString *)strDetail pic:(NSString *)strPic url:(NSString *)strUrl
{
    
}
 


@end


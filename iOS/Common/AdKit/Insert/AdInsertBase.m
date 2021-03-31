//
//  AdInsertBase.m
//  Unity-iPhone
//
//  Created by jaykie Chen on 17/4/14.
//
//

#import "AdInsertBase.h"
#import "AdInsertObj.h"

@implementation AdInsertBase
@synthesize unityObjName;
//@synthesize appKey;

-(void) setUnityObjectInfo:(NSString *)strObjName
{
    self.unityObjName = strObjName;
}

-(UInt64) getSystemMs
{
    UInt64 msecond = [[NSDate date] timeIntervalSince1970]*1000;
    return msecond;
}

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
    char ptmp[1024]={0};
    sprintf(ptmp, "%s",[self.source UTF8String]);
    AdInsertObj *ad = [AdInsertObj sharedAdInsertObj];
    char ptmpObj[1024]={0};
    if(ad.unityObjName==nil){
        sprintf(ptmpObj, "Scene");
    }else{
    sprintf(ptmpObj, "%s",[ad.unityObjName UTF8String]);
    }
    NSLog(@"ptmpObj=%s",ptmpObj);
    
    UnitySendMessage(ptmpObj, "AdInsertDidFail", ptmp);
   
    
}
-(void) willShow
{
    UnitySendMessage("Scene", "AdInsertWillShow", "");
}
-(void) didClose
{
    UnitySendMessage("Scene", "AdInsertDidClose", "");
}

@end

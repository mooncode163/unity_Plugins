//
//  CCAdApplistObj.h
//  moonma_tankcity
//
//  Created by chen Jaykie on 13-10-2.
//
//

#import <Foundation/Foundation.h>


@interface PayObj : NSObject
{
    void *pointThis;//类指针
    
}

@property(nonatomic,retain) NSString *appId;
@property(nonatomic,retain) NSString *appKey;


+ (PayObj *) sharedPayObj;
-(void) setAppKey:(NSString *)strAppKey;
-(void) payContent:(NSString *)strType title:(NSString *)strTitle detail:(NSString *)strDetail pic:(NSString *)strPic url:(NSString *)strUrl;
-(void) setClassePoit:(void *) p ;

@end

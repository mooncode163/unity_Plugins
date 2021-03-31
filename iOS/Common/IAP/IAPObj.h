//
//  CCAdApplistObj.h
//  moonma_tankcity
//
//  Created by chen Jaykie on 13-10-2.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <StoreKit/StoreKit.h>
#import "MLIAPManager.h"

@interface IAPObj : NSObject<MLIAPManagerDelegate>
{
     int buyType;
    bool isLoaded;
    void *pointClass;//类指针
    bool isRestoreBuy;
    bool isStartPaymentProduct;
}
+ (IAPObj *) sharedIAPObj;
-(void) setAppIdOrKey:(NSString *)strAppId key:(NSString *)strAppKey;
-(void) setUnityObjectInfo:(NSString *)strObjName key:(NSString *)strObjMethod;
-(void) show;
-(void)setAdSource:(int )source;
-(void)startBuy:(NSString *)strProduct;
-(void)restoreBuy:(NSString *)strProduct;
-(void) setClassPoint:(void *)p;
@property (nonatomic,retain) NSString *productName;
@property (nonatomic,retain) NSString *unityObjName;
@property (nonatomic,retain) NSString *unityObjMethod;
@end

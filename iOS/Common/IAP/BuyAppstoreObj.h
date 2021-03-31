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

enum{
    IAP0p99=10,
    IAP1p99,
    IAP4p99,
    IAP9p99,
    IAP24p99,
}buyCoinsTag;

#define ProductID_IAP0p99 @"com.buytest.one"//$0.99
#define ProductID_IAP1p99 @"com.buytest.two" //$1.99
#define ProductID_IAP4p99 @"com.buytest.three" //$4.99
#define ProductID_IAP9p99 @"com.buytest.four" //$19.99
#define ProductID_IAP24p99 @"com.buytest.five" //$24.99

@interface BuyAppstoreObj : NSObject
{
     int buyType;
    bool isLoaded;
    void *pointClass;//类指针
    bool isRestoreBuy;
}
+ (BuyAppstoreObj *) sharedBuyAppstoreObj;
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

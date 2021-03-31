//
//  CCAdInsertObj.m
//  moonma_tankcity
//
//  Created by chen Jaykie on 13-10-2.
//
//

#import "IAPObj.h"
#import "Common.h" 

#define UNITY_CALLBACK_BUY_DID_FINISH "BuyDidFinish"
#define UNITY_CALLBACK_BUY_DID_Fail "BuyDidFail"
#define UNITY_CALLBACK_DID_BUY "DidBuy"
#define UNITY_CALLBACK_BUY_DID_RESTORE "BuyDidRestore"
#define UNITY_CALLBACK_BUY_CANCEL_BY_USER "BuyCancelByUser"

@implementation IAPObj
@synthesize productName;
@synthesize unityObjName;
@synthesize unityObjMethod;
static IAPObj *s_sharedIAPObj = nil;


// Init
+ (IAPObj *) sharedIAPObj
{
    @synchronized(self)     {
        if (!s_sharedIAPObj)
            s_sharedIAPObj = [[IAPObj alloc] init];
        [s_sharedIAPObj initValue];
    }
    return s_sharedIAPObj;
}

-(void)initValue
{
    isStartPaymentProduct = false;
     [MLIAPManager sharedManager].delegate = self;
}
-(void)setAdSource:(int )source
{

    
}

-(void) setUnityObjectInfo:(NSString *)strObjName key:(NSString *)strObjMethod
{
    self.unityObjName = strObjName;
    self.unityObjMethod = strObjMethod;
}


-(void) show
{

}



-(void)restoreBuy:(NSString *)strProduct
{
    isRestoreBuy = true;
    isStartPaymentProduct = false;
    [[MLIAPManager sharedManager] requestProductWithId:strProduct];
    
}

-(void)startBuy:(NSString *)strProduct
{
    isRestoreBuy = false;
    isStartPaymentProduct = false;
   [[MLIAPManager sharedManager] requestProductWithId:strProduct];
    
}
-(void) setClassPoint:(void *)p
{
    pointClass = p;
}

-(bool)CanMakePay
{
    return [SKPaymentQueue canMakePayments];
}

-(void)onBuyFinish
{
    UnitySendMessage([self.unityObjName UTF8String], [self.unityObjMethod UTF8String], UNITY_CALLBACK_BUY_DID_FINISH);
}

-(void)onBuyFail
{
     UnitySendMessage([self.unityObjName UTF8String], [self.unityObjMethod UTF8String], UNITY_CALLBACK_BUY_DID_Fail);
}

-(void)onBuyCancelByUser
{
    UnitySendMessage([self.unityObjName UTF8String], [self.unityObjMethod UTF8String], UNITY_CALLBACK_BUY_CANCEL_BY_USER);
}
-(void)onBuyDidRestore
{
 UnitySendMessage([self.unityObjName UTF8String], [self.unityObjMethod UTF8String], UNITY_CALLBACK_BUY_DID_RESTORE);
}

#pragma mark - ================ MLIAPManager Delegate =================

- (void)receiveProduct:(SKProduct *)product {
    
    if (product != nil) { 
        bool ret = false;
        
        if (isRestoreBuy) {
            //恢复购买
            ret = [[MLIAPManager sharedManager] restorePurchase];
        }else{
            //购买商品
            ret =[[MLIAPManager sharedManager] purchaseProduct:product];
        }
        
        if (!ret) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"失败" message:@"您禁止了应用内购买权限,请到设置中开启" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
            [alert show];
        }else{
            isStartPaymentProduct = true;
        }
        
    } else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"失败" message:@"该商品不存在" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
        [alert show];
    }
}


-(void) onBuyFinishMainThread
{
     [self onBuyFinish];
}

- (void)successedWithReceipt:(NSData *)transactionReceipt {
    NSLog(@"购买成功");
    
    isStartPaymentProduct = false;
    
    NSString  *transactionReceiptString = [transactionReceipt base64EncodedStringWithOptions:0];
    
    if ([transactionReceiptString length] > 0) {
        NSLog(@"length"); 
        // 向自己的服务器验证购买凭证（此处应该考虑将凭证本地保存,对服务器有失败重发机制）
        /**
         服务器要做的事情:
         接收ios端发过来的购买凭证。
         判断凭证是否已经存在或验证过，然后存储该凭证。
         将该凭证发送到苹果的服务器验证，并将验证结果返回给客户端。
         如果需要，修改用户相应的会员权限
         */
        
        /**
         if (凭证校验成功) {
         [[MLIAPManager sharedManager] finishTransaction];
         }
         */
    }
     [self performSelectorOnMainThread:@selector(onBuyFinishMainThread) withObject:nil waitUntilDone:NO];
   
}

- (void)failedPurchaseWithError:(NSString *)errorDescripiton {
    //NSLog(@"购买失败");
    if(isStartPaymentProduct){
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"失败" message:errorDescripiton delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
    [alert show];
    
    [self onBuyFail];
    }
}

- (void)buyCancelByUser
{
    [self onBuyCancelByUser];
}
- (void)buyDidRestore
{
    [self onBuyDidRestore];
}

@end

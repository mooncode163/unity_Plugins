//
//  CCAdInsertObj.m
//  moonma_tankcity
//
//  Created by chen Jaykie on 13-10-2.
//
//

#import "BuyAppstoreObj.h"
#import "Common.h" 

#define UNITY_CALLBACK_BUY_DID_FINISH "BuyDidFinish"
#define UNITY_CALLBACK_BUY_DID_Fail "BuyDidFail"
#define UNITY_CALLBACK_DID_BUY "DidBuy"
#define UNITY_CALLBACK_BUY_DID_RESTORE "BuyDidRestore"
#define UNITY_CALLBACK_BUY_CANCEL_BY_USER "BuyCancelByUser"

@implementation BuyAppstoreObj
@synthesize productName;
@synthesize unityObjName;
@synthesize unityObjMethod;
static BuyAppstoreObj *sharedBuyAppstoreObj = nil;


// Init
+ (BuyAppstoreObj *) sharedBuyAppstoreObj
{
    @synchronized(self)     {
        if (!sharedBuyAppstoreObj)
            sharedBuyAppstoreObj = [[BuyAppstoreObj alloc] init];
        [sharedBuyAppstoreObj initValue];
    }
    return sharedBuyAppstoreObj;
}

-(void)initValue
{
    //----监听购买结果
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    
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
    
    [self startBuy:strProduct];
    isRestoreBuy = true;
}

-(void)startBuy:(NSString *)strProduct
{
    isRestoreBuy = false;
    self.productName = strProduct;
    if ([SKPaymentQueue canMakePayments]) {
        NSLog (@"---------请求对应的产品信息------------:%@",strProduct);
        NSArray *product = nil;
        product=[[NSArray alloc] initWithObjects:strProduct,nil];
        
        NSSet *nsset = [NSSet setWithArray:product];
        SKProductsRequest *request=[[SKProductsRequest alloc] initWithProductIdentifiers: nsset];
        request.delegate=self;
        [request start];
        //[product release];
        NSLog(@"允许程序内付费购买");
    }
    else
    {
        NSLog(@"不允许程序内付费购买");
        UIAlertView *alerView =  [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:@"You can‘t purchase in app store（Himi说你没允许应用程序内购买）"
                                                           delegate:nil cancelButtonTitle:NSLocalizedString(@"Close（关闭）",nil) otherButtonTitles:nil];
        
        [alerView show];
        //[alerView release];
        
    }
    
  
}
-(void) setClassPoint:(void *)p
{
    pointClass = p;
}

-(bool)CanMakePay
{
    return [SKPaymentQueue canMakePayments];
}

#pragma mark request
//<SKProductsRequestDelegate> 请求协议
//收到的产品信息
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    
    NSLog(@"-----------收到产品反馈信息--------------");
    NSArray *myProduct = response.products;
    NSArray *arrayInvalid = response.invalidProductIdentifiers;
   
    if(arrayInvalid.count){
    NSLog(@"产品Product ID:%@",[arrayInvalid objectAtIndex:0]);
    }
   NSLog(@"产品付费数量: %d", [myProduct count]);
    
    if([myProduct count]==0){
        [self onBuyFail];
        return;
    }
    // populate UI
    for(SKProduct *product in myProduct){
        NSLog(@"product info");
        NSLog(@"SKProduct 描述信息%@", [product description]);
        NSLog(@"产品标题 %@" , product.localizedTitle);
        NSLog(@"产品描述信息: %@" , product.localizedDescription);
        NSLog(@"价格: %@" , product.price);
        NSLog(@"Product id: %@" , product.productIdentifier);
    }
    
    
    if (isRestoreBuy) {
        //[self  restorePurchase];
    }else {
        //SKPayment *payment =  [SKPayment paymentWithProductIdentifier:self.productName];    //支付$0.99
        SKPayment *payment =  [SKPayment paymentWithProduct:[myProduct objectAtIndex:0]];
        
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        
        NSLog(@"---------发送购买请求------------");
        [[SKPaymentQueue defaultQueue] addPayment:payment];
        //[request autorelease];
    }
    
 
    
}
- (void)requestProUpgradeProductData
{
    NSLog(@"------请求升级数据---------");
    NSSet *productIdentifiers = [NSSet setWithObject:@"com.productid"];
    SKProductsRequest* productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:productIdentifiers];
    productsRequest.delegate = self;
    [productsRequest start];
    
}
//弹出错误信息
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"-------弹出错误信息----------");
    UIAlertView *alerView =  [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Alert",NULL) message:[error localizedDescription]
                                                       delegate:nil cancelButtonTitle:NSLocalizedString(@"Close",nil) otherButtonTitles:nil];
    [alerView show];
    //[alerView release];
}

-(void) requestDidFinish:(SKRequest *)request
{
    NSLog(@"----------反馈信息结束--------------");
    if (isRestoreBuy) {
        [self  restorePurchase];
    }
    
}

-(bool) restorePurchase
{
    NSLog(@"EBPurchase restorePurchase");
    
    if ([SKPaymentQueue canMakePayments]) {
        // Yes, In-App Purchase is enabled on this device.
        // Proceed to restore purchases.
        
        // Assign an observer to monitor the transaction status.
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        
        // Request to restore previous purchases.
        [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
        
        
//        if (pointClass) {
//            ((CCBuyAppstoreIos *) pointClass)-> buyDidRestore();
//        }
        //UnitySendMessage([self.unityObjName UTF8String], [self.unityObjMethod UTF8String], UNITY_CALLBACK_BUY_DID_RESTORE);
        return YES;
        
    } else {
        // Notify user that In-App Purchase is Disabled.
        return NO;
    }
}

-(void) PurchasedTransaction: (SKPaymentTransaction *)transaction{
    NSLog(@"-----PurchasedTransaction----");
    NSArray *transactions =[[NSArray alloc] initWithObjects:transaction, nil];
    [self paymentQueue:[SKPaymentQueue defaultQueue] updatedTransactions:transactions];
    //[transactions release];
}

#pragma mark buy
//<SKPaymentTransactionObserver> 千万不要忘记绑定，代码如下：
//----监听购买结果
//[[SKPaymentQueue defaultQueue] addTransactionObserver:self];

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions//交易结果
{
    NSLog(@"-----paymentQueue--------");
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased://交易完成
            {
                [self completeTransaction:transaction];
                /*
                NSLog(@"-----交易完成 --------");
                NSLog(@"不允许程序内付费购买");
                UIAlertView *alerView =  [[UIAlertView alloc] initWithTitle:@"Alert"
                                                                    message:@"Himi说你购买成功啦～娃哈哈"
                                                                   delegate:nil cancelButtonTitle:NSLocalizedString(@"Close（关闭）",nil) otherButtonTitles:nil];
                
                [alerView show];
                [alerView release];
                */
                
                if (pointClass) {
                   //((CCBuyAppstoreIos *) pointClass)-> buyDidFinishIos();
                }
                
                UnitySendMessage([self.unityObjName UTF8String], [self.unityObjMethod UTF8String], UNITY_CALLBACK_BUY_DID_FINISH);
                
            }
                break;
            case SKPaymentTransactionStateFailed://交易失败
            {
                [self failedTransaction:transaction];
               
            
                if (transaction.error.code != SKErrorPaymentCancelled)
                {
                        NSLog (@"-----交易失败 --------");
                     [self onBuyFail];
                }else{
                    [self onBuyCancelByUser];
                }
               
                
            }
                break;
              
            case SKPaymentTransactionStateRestored://已经购买过该商品
                [self restoreTransaction:transaction];
//                if (pointClass) {
//                    ((CCBuyAppstoreIos *) pointClass)-> buyDidBuyedIos();
//                }
             //UnitySendMessage([self.unityObjName UTF8String], [self.unityObjMethod UTF8String], UNITY_CALLBACK_DID_BUY);
             UnitySendMessage([self.unityObjName UTF8String], [self.unityObjMethod UTF8String], UNITY_CALLBACK_BUY_DID_RESTORE);
                
                NSLog(@"-----已经购买过该商品 --------");
                break;

            case SKPaymentTransactionStatePurchasing:      //商品添加进列表
                NSLog(@"-----商品添加进列表 --------");
                break;
                
            default:
                break;
        }
    }
}
- (void) completeTransaction: (SKPaymentTransaction *)transaction

{
    NSLog(@"-----completeTransaction--------");
    // Your application should implement these two methods.
    NSString *product = transaction.payment.productIdentifier;
    if ([product length] > 0) {
        
        NSArray *tt = [product componentsSeparatedByString:@"."];
        NSString *bookid = [tt lastObject];
        if ([bookid length] > 0) {
            [self recordTransaction:bookid];
            [self provideContent:bookid];
        }
    }
    
    // Remove the transaction from the payment queue.
    
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    
}

//记录交易
-(void)recordTransaction:(NSString *)product{
    NSLog(@"-----记录交易--------");
}

//处理下载内容
-(void)provideContent:(NSString *)product{
    NSLog(@"-----下载--------");
}

- (void) failedTransaction: (SKPaymentTransaction *)transaction{
     NSLog(@"失败 error.code=%d",transaction.error.code);
    if (transaction.error.code != SKErrorPaymentCancelled)
    {
    }
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    
}
-(void) paymentQueueRestoreCompletedTransactionsFinished: (SKPaymentTransaction *)transaction{
    
}

- (void) restoreTransaction: (SKPaymentTransaction *)transaction

{
    NSLog(@" 交易恢复处理");
    
}

-(void) paymentQueue:(SKPaymentQueue *) paymentQueue restoreCompletedTransactionsFailedWithError:(NSError *)error{
    NSLog(@"-------paymentQueue----");
}

#pragma mark connection delegate
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"%@",  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    switch([(NSHTTPURLResponse *)response statusCode]) {
        case 200:
        case 206:
            break;
        case 304:
            break;
        case 400:
            break;
        case 404:
            break;
        case 416:
            break;
        case 403:
            break;
        case 401:
        case 500:
            break;
        default:
            break;
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"test");
}

-(void)dealloc
{
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];//解除监听
 //   [super dealloc];
}

-(void)onBuyFail
{
     UnitySendMessage([self.unityObjName UTF8String], [self.unityObjMethod UTF8String], UNITY_CALLBACK_BUY_DID_Fail);
}

-(void)onBuyCancelByUser
{
    UnitySendMessage([self.unityObjName UTF8String], [self.unityObjMethod UTF8String], UNITY_CALLBACK_BUY_CANCEL_BY_USER);
}


@end

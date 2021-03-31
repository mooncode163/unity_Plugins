//
//  CCAdApplistObj.h
//  moonma_tankcity
//
//  Created by chen Jaykie on 13-10-2.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h> 

@interface ImageUtilObj : NSObject
{
    
}

+ (ImageUtilObj *) main;
-(void) OpenSysImageLib;
-(void) OpenSysCamera;
-(void) OpenPicker;
- (void)SaveImage:(UIImage *)image;
-(void) SetUnityObjectInfo:(NSString *)strObjName key:(NSString *)strObjMethod;

@end

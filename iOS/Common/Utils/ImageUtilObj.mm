//
//  CCAdInsertObj.m
//  moonma_tankcity
//
//  Created by chen Jaykie on 13-10-2.
//
//

#import "ImageUtilObj.h"
#import "Common.h" 

//UIImagePickerController拍照的UIImage竟然旋转了90度
//https://www.jianshu.com/p/5389818f9e62

@interface ImageUtilObj ()<UIImagePickerControllerDelegate>
{
        BOOL isPicker ;
}
@property (strong, nonatomic) UIImagePickerController *picker;
@property (nonatomic,retain) NSString *unityObjName;
@property (nonatomic,retain) NSString *unityObjMethod;

@end

@implementation ImageUtilObj 
static ImageUtilObj *s_main = nil; 
+ (ImageUtilObj *) main
{
    @synchronized(self)     {
        if (!s_main){
            s_main = [[ImageUtilObj alloc] init]; 
        }
    }
    return s_main;
}

-(void) SetUnityObjectInfo:(NSString *)strObjName key:(NSString *)strObjMethod
{
    self.unityObjName = strObjName;
    self.unityObjMethod = strObjMethod;
}

-(void) OpenSysImageLib
{
       isPicker = NO;
//            打开相册
            self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            isPicker = true;
      [self OpenPicker];
}
-(void) OpenSysCamera
{
      isPicker = NO;
    //            打开相机 
//            判断相机是否可用
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                isPicker = true;
            }
    [self OpenPicker];
} 

-(void) OpenPicker;
{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    UIViewController *controller = keyWindow.rootViewController;
    
         if (isPicker) {
        [controller presentViewController:self.picker animated:YES completion:nil];
    }else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误" message:@"相机不可用" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action];
        
        [controller presentViewController:alert animated:YES completion:nil];
    }
}

- (UIImagePickerController *)picker
{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    UIViewController *controller = keyWindow.rootViewController;
    
    if (!_picker) {
        _picker = [[UIImagePickerController alloc]init];
        _picker.delegate = self;
        _picker.allowsEditing = YES;
    }
    return _picker;
}
- (void)SaveImage:(UIImage *)image {
UIImage *imageNew = image;
    if(image.imageOrientation!=UIImageOrientationUp){
        //https://www.jianshu.com/p/5389818f9e62 
            // Adjust picture Angle
            UIGraphicsBeginImageContext(image.size);
            [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
            imageNew = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
    }

   // NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    //NSString *filePath = [[paths objectAtIndex:0]stringByAppendingPathComponent:
                      //    [NSString stringWithFormat:@"syt_image_camera_tmp.png"]];  // 保存文件的名称
    NSString *tmpDir = NSTemporaryDirectory();
    NSString *filePath = [NSString stringWithFormat:@"%@/sys_image_camera_tmp.png",tmpDir]; 

    BOOL result =[UIImagePNGRepresentation(imageNew)writeToFile:filePath   atomically:YES]; // 保存成功会返回YES
    if (result == YES) {
        NSLog(@"保存成功");
           UnitySendMessage([self.unityObjName UTF8String], [self.unityObjMethod UTF8String],[filePath UTF8String]);
    }
    
} 

//delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
//    获取图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
   // self.image.image = image;
//    获取图片后返回
    [picker dismissViewControllerAnimated:YES completion:nil];

    [self SaveImage:image];
}

//按取消按钮时候的功能
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
//    返回
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end

//
//  ShowQrcodeView.m
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/9/11.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "ShowQrcodeView.h"

#import <CoreImage/CoreImage.h>

@interface ShowQrcodeView ()
@property (weak, nonatomic) IBOutlet UILabel *phoneBuyLab;

@end

@implementation ShowQrcodeView

-(instancetype)init{
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"ShowQrcodeView" owner:self options:nil].lastObject;
        
//        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressSave)];
//        longPress.minimumPressDuration = 2;
        UITapGestureRecognizer *tapPress = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPressSave)];
        
        [self.qrcodeImg addGestureRecognizer:tapPress];
        
    }
    
    self.phoneBuyLab.hidden = self.isHideLab;
    
    return self;
}

-(instancetype)initWithIsHideLab:(BOOL)isHideLab{
    
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"ShowQrcodeView" owner:self options:nil].lastObject;
        
    }
    
    self.phoneBuyLab.hidden = isHideLab;
    return self;
}

//隐藏界面
-(void)hideControl{
    [UIView animateWithDuration:.3 animations:^{
        
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

#pragma mark - 点击事件

- (IBAction)saveImgBtnClickAction:(UIButton *)sender {
    NSLog(@"1234674567898");
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.imgUrlStr]];
    UIImage *image = [UIImage imageWithData:data]; // 取得图片
    [self saveImageToPhotos:image];
}
-(void)tapPressSave{
    NSLog(@"长安点击下载图片");
    
    dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
    dispatch_async(globalQueue, ^{
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.imgUrlStr]];
        UIImage *image = [UIImage imageWithData:data]; // 取得图片
        [self saveImageToPhotos:image];
        //        [s];
    });
    
    
}

//将图片保存到相册
- (void)saveImageToPhotos:(UIImage*)savedImage{
    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo{
    
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存图片结果提示"
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
    
    [self hideControl];
}

- (IBAction)buttonClickAction:(UIButton *)sender {
    [self hideControl];
}

//点击屏幕空白处去掉键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if ([event touchesForView:self]) {
        [self hideControl];
    }
    
}


/**
 *  生成二维码
 */
- (void)creatCIQRCodeImageWithStr:(NSString *)str
{
    // 1.创建过滤器，这里的@"CIQRCodeGenerator"是固定的
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 2.恢复默认设置
    [filter setDefaults];
    
    // 3. 给过滤器添加数据
//    NSString *dataString = @"{group:217}";
    NSString *dataString = str;
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    // 注意，这里的value必须是NSData类型
    [filter setValue:data forKeyPath:@"inputMessage"];
    
    // 4. 生成二维码
    CIImage *outputImage = [filter outputImage];
    UIImage *img = [self creatNonInterpolatedUIImageFormCIImage:outputImage withSize:300];
    
    // 5. 显示二维码
    //生成的二维码会模糊
//    self.qrcodeImg.image = [UIImage imageWithCIImage:outputImage];
    //生成高清的w二维码
    self.qrcodeImg.image = img;
}


/**
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param image CIImage
 *  @param size  图片宽度
 *
 *  @return 生成高清的UIImage
 */
- (UIImage *)creatNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1. 创建bitmap
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

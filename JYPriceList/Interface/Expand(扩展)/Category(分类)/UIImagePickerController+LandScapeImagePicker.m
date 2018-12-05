//
//  UIImagePickerController+LandScapeImagePicker.m
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/10/26.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "UIImagePickerController+LandScapeImagePicker.h"


@implementation UIImagePickerController (LandScapeImagePicker)

-(BOOL)shouldAutorotate{
    
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations{
    
    return UIInterfaceOrientationMaskAll;
}



@end

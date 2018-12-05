//
//  UIImagePickerController+LandScapeImagePicker.h
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/10/26.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImagePickerController (LandScapeImagePicker)

- (BOOL)shouldAutorotate;

- (NSUInteger)supportedInterfaceOrientations;


@end

NS_ASSUME_NONNULL_END

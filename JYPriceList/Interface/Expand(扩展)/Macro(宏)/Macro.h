
//
//  Macro.h
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/8/28.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#ifndef Macro_h
#define Macro_h


#define Screen_Bounds    [UIScreen mainScreen].bounds
/** 屏幕高度 */
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
/** 屏幕宽度 */
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

//弱引用
#define weakSelf(weakSelf) __weak typeof(self) weakSelf = self

#pragma mark - ------------------- String -------------------
#define SF(...) [NSString stringWithFormat:__VA_ARGS__]




#endif /* Macro_h */

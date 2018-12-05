//
//  AppDelegate.m
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/8/28.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "AppDelegate.h"

#import <IQKeyboardManager/IQKeyboardManager.h>

#import "JYBaseNavigationController.h"
//#import "GlassShopViewController.h"
#import "GlassHomeViewController.h"

#import "JYLoginViewController.h"


@interface AppDelegate ()


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window.backgroundColor = [UIColor whiteColor];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.isHorisenView = YES;
//    GlassShopViewController *glassShopVC = [[GlassShopViewController alloc] initWithNibName:@"GlassShopViewController" bundle:nil];
    [self configIQKeyboard];
    
    [self request];
    
    JYLoginViewController *loginVC = [[JYLoginViewController alloc] initWithNibName:@"JYLoginViewController" bundle:nil];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    
    [nav setNavigationBarHidden:YES];
    self.window.rootViewController = nav;
    
    [self.window makeKeyAndVisible];
    
    //1.打开加密传输
    [UMConfigure setEncryptEnabled:YES];
    
    //2.设置打开日志
    [UMConfigure setLogEnabled:YES];
    //开发者需要显式的调用此函数，日志系统才能工作
    [UMCommonLogManager setUpUMCommonLogManager];
    
    //4.初始化
    [UMConfigure initWithAppkey:@"5c00e2a0b465f53453000180" channel:@"App Store"];
    
    //3.获取集成测试需要的device_id
    NSString* deviceID =  [UMConfigure deviceIDForIntegration];
    if ([deviceID isKindOfClass:[NSString class]]) {
        NSLog(@"服务器端成功返回deviceID");
    }
    else{
        NSLog(@"服务器端还没有返回deviceID");
    }
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)configIQKeyboard{
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    
    keyboardManager.enable = YES; // 控制整个功能是否启用
    
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    
    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
    
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    
    keyboardManager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
    
//    keyboardManager.shouldShowTextFieldPlaceholder = YES;
    keyboardManager.shouldShowToolbarPlaceholder = YES;// 是否显示占位文字
    
    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:17]; // 设置占位文字的字体
    
    keyboardManager.keyboardDistanceFromTextField = 10.0f; // 输入框距离键盘的距离
    
}

-(UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
//        return UIInterfaceOrientationMaskAll;
//    }else{
//        //ipad
////        return UIInterfaceOrientationMaskAllButUpsideDown;
//        return UIInterfaceOrientationMaskLandscape;
//    }
    
    BOOL isHorisen = [GlobalVariable sharedGlobalVariable].isHorisen;
    NSLog(@"%d",isHorisen);
//    [GlobalVariable sharedGlobalVariable].strTest=@"第一次修改";

    if (self.isHorisenView == YES) {
        return UIInterfaceOrientationMaskLandscape;
    } else {
        //全局变量，定义是否打开相册
        return UIInterfaceOrientationMaskAll;
    }
    
//    if (isHorisen == YES) {
//        return UIInterfaceOrientationMaskLandscape;
//    } else {
//        //全局变量，定义是否打开相册
//        return UIInterfaceOrientationMaskAll;
//    }
    
}

-(void)request{
    [[HRRequestManager manager] POST_PATH:Post_CheckInfo WithToken:nil para:nil success:^(id responseObject) {
        [GlobalVariable sharedGlobalVariable].isCheck = responseObject[@"data"];
        self.isCheck = responseObject[@"data"];
        
    } failure:^(NSError *error) {
        
        
    }];
    
}


@end

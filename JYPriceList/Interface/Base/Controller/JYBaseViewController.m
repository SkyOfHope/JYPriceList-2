
//
//  JYBaseViewController.m
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/8/28.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import "JYBaseViewController.h"

@interface JYBaseViewController ()

@end

@implementation JYBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    //UIImage *img = [self createImageWithColor:[UIColor whiteColor]];
    
    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark NavigationTitle
/**
 *  NavigationTitle
 *
 *  @param title
 *  @param titleColor
 *  @param size(system)
 */
//设置标题
- (void)navigationTitle:(NSString *)title color:(UIColor *)color fontSize:(CGFloat)size {
    UILabel *titleText = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, 150, 44)];
    titleText.backgroundColor = [UIColor clearColor];
    titleText.textColor=color;
    titleText.textAlignment = NSTextAlignmentCenter;
    [titleText setFont:[UIFont systemFontOfSize:size]];
    [titleText setText:title];
    self.navigationItem.titleView = titleText;
}

/**
 *  NavigationTitleView
 *
 *  @param view  CustomView
 *  @param block tap event block
 */
- (void)navigationTitleView:(UIView *)view click:(void(^)(void))block {
    view.userInteractionEnabled = YES;
    self.navigationItem.titleView = view;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(navigationTitleViewTap:)];
    [view addGestureRecognizer:tap];
    self.navigationTitleViewClickBlock = block;
}


#pragma mark NavigationBarButton
/**
 *  LeftBarButtonItems(imageView)
 *
 *  @param imageNames   imageName array
 *  @param block        button click (left->right tag=1,2,3...)
 */
//设置左按钮图片
- (void)navigationLeftBarButtonImageNames:(NSArray <NSString *> *)imageNames click:(void(^)(NSInteger buttonTag))block {
    NSArray *barButtonItems = [self handleBarButtonImageNames:imageNames isLeft:YES];
    if (!barButtonItems.count) {
        return;
    }
    if (barButtonItems.count == 1)
    {
        self.navigationItem.leftBarButtonItem = [barButtonItems lastObject];
    } else {
        self.navigationItem.leftBarButtonItems = barButtonItems;
    }
    self.navigationLeftBarButtonClickBlock = block;
}

/**
 *  LeftBarButtonItems(title)
 *
 *  @param titles  title
 *  @param block   button click (left->right tag=1,2,3...)
 */
- (void)navigationLeftBarButtonTitles:(NSArray <NSString *> *)titles color:(UIColor *)color click:(void(^)(NSInteger buttonTag))block {
    NSArray *barButtonItems = [self handleBarButtonTitles: titles color:color isLeft:YES];
    if (!barButtonItems.count) {
        return;
    }
    if (barButtonItems.count == 1) {
        self.navigationItem.leftBarButtonItem = [barButtonItems lastObject];
    } else {
        self.navigationItem.leftBarButtonItems = barButtonItems;
    }
    
    self.navigationLeftBarButtonClickBlock = block;
}

/**
 *  RightBarButtonItems(imageView)
 *
 *  @param imageNames imageNames array
 *  @param block      button click (right->left tag=1,2,3...)
 */
//设置右按钮图片
- (void)navigationRightBarButtonImageNames:(NSArray <NSString *> *)imageNames click:(void(^)(NSInteger buttonTag))block {
    NSArray *barButtonItems = [self handleBarButtonImageNames:imageNames isLeft:NO];
    if (!barButtonItems.count) {
        return;
    }
    if (barButtonItems.count == 1) {
        self.navigationItem.rightBarButtonItem = [barButtonItems lastObject];
    } else {
        self.navigationItem.rightBarButtonItems = barButtonItems;
    }
    
    self.navigationRightBarButtonClickBlock = block;
}

#pragma mark Others

/**
 *  custom navigation titleView tap event
 *
 *  @param recognizer recognizer
 */
- (void)navigationTitleViewTap:(UITapGestureRecognizer *)recognizer {
    self.navigationTitleViewClickBlock();
}

/**
 *  RightBarButtonItems(title)
 *
 *  @param titles title array
 *  @param block  button click (right->left tag=1,2,3...)
 */
- (void)navigationRightBarButtonTitles:(NSArray <NSString *> *)titles color:(UIColor *)color click:(void(^)(NSInteger buttonTag))block {
    NSArray *barButtonItems = [self handleBarButtonTitles:titles color:color isLeft:NO];
    if (!barButtonItems.count) {
        return;
    }
    if (barButtonItems.count == 1) {
        self.navigationItem.rightBarButtonItem = [barButtonItems lastObject];
    } else {
        self.navigationItem.rightBarButtonItems = barButtonItems;
    }
    
    self.navigationRightBarButtonClickBlock = block;
}

// titles transform buttons
- (NSMutableArray *)handleBarButtonTitles:(NSArray *)titles color:(UIColor *)color isLeft:(BOOL)flag {
    NSMutableArray *barButtonItems = [NSMutableArray array];
    for (int i = 0; i < titles.count; i++) {
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        bt.frame = CGRectMake(0, 0, 44, 44);
        bt.titleLabel.font = [UIFont systemFontOfSize:16];
        [bt setTitle:titles[i] forState:UIControlStateNormal];
        [bt setTitleColor:color forState:UIControlStateNormal];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:bt];
        
        if (flag) {
            [bt addTarget:self action:@selector(navigationLeftBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        } else {
            [bt addTarget:self action:@selector(navigationRightBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        bt.tag = i + 1;
        [barButtonItems addObject:item];
    }
    return barButtonItems;
}

// images transform buttons
- (NSMutableArray *)handleBarButtonImageNames:(NSArray *)imageNames isLeft:(BOOL)flag{
    NSMutableArray *barButtonItems = [NSMutableArray array];
    for (int i = 0; i < imageNames.count; i++) {
        UIImage *img = [UIImage imageNamed:imageNames[i]];
        if (img) {
            UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
            bt.frame = CGRectMake(0, 0, 30, 30);
            [bt setImage:img forState:UIControlStateNormal];
            bt.imageView.contentMode = UIViewContentModeScaleAspectFit;
            UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:bt];
            if (flag) {
                [bt addTarget:self action:@selector(navigationLeftBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            } else {
                [bt addTarget:self action:@selector(navigationRightBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            bt.tag = i + 1;
            [barButtonItems addObject:item];
        }
    }
    return barButtonItems;
}




// LeftBarButtonClick
- (void)navigationLeftBarButtonClick:(UIButton *)sender
{
    if (self.navigationLeftBarButtonClickBlock) {
        self.navigationLeftBarButtonClickBlock(sender.tag);
    }
    
}
// RightBarButtonClick
- (void)navigationRightBarButtonClick:(UIButton *)sender
{
    if (self.navigationRightBarButtonClickBlock) {
        self.navigationRightBarButtonClickBlock(sender.tag);
    }
    
}



//UIColor 转UIImage（UIImage+YYAdd.m也是这种实现）
- (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

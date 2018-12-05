//
//  JYBaseViewController.h
//  JYPriceList
//
//  Created by jiangkuiquan on 2018/8/28.
//  Copyright © 2018年 jiangkuiquan. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^LMBlock)(void);
/**
 *  NavigationClickBlockType
 *
 *  @param buttonTag
 */
typedef void(^NavigationClickBlockType)(NSInteger buttonTag);

@interface JYBaseViewController : UIViewController


/**
 *  TitleViewClickBlock
 */
@property (nonatomic, copy)LMBlock navigationTitleViewClickBlock;

/**
 *  LeftBarButtonClickBlock
 */
@property (nonatomic, copy)NavigationClickBlockType navigationLeftBarButtonClickBlock;

/**
 *  RightBarButtonClickBlock
 */
@property (nonatomic, copy)NavigationClickBlockType navigationRightBarButtonClickBlock;


/**
 *  NavigationTitleView
 *
 *  @param view  CustomView
 *  @param block tap event block
 */
- (void)navigationTitleView:(UIView *)view click:(void(^)(void))block;

/**
 *  NavigationTitle
 *
 *  @param title
 *  @param titleColor
 *  @param size(system)
 */
- (void)navigationTitle:(NSString *)title color:(UIColor *)color fontSize:(CGFloat)size;

#pragma mark - NavigationBarButton
/**
 *  LeftBarButtonItems(imageView)
 *
 *  @param imageNames   imageName array
 *  @param block        button click (left->right tag=1,2,3...)
 */
- (void)navigationLeftBarButtonImageNames:(NSArray <NSString *> *)imageNames click:(void(^)(NSInteger buttonTag))block;

/**
 *  LeftBarButtonItems(title)
 *
 *  @param titles  title
 *  @param block   button click (left->right tag=1,2,3...)
 */
//- (void)navigationLeftBarButtonTitles:(NSArray <NSString *> *)titles click:(void(^)(NSInteger buttonTag))block;
- (void)navigationLeftBarButtonTitles:(NSArray <NSString *> *)titles color:(UIColor *)color click:(void(^)(NSInteger buttonTag))block;

/**
 *  RightBarButtonItems(imageView)
 *
 *  @param imageNames imageNames array
 *  @param block      button click (right->left tag=1,2,3...)
 */
- (void)navigationRightBarButtonImageNames:(NSArray <NSString *> *)imageNames click:(void(^)(NSInteger buttonTag))block;

/**
 *  RightBarButtonItems(title)
 *
 *  @param titles title array
 *  @param block  button click (right->left tag=1,2,3...)
 */
//- (void)navigationRightBarButtonTitles:(NSArray <NSString *> *)titles click:(void(^)(NSInteger buttonTag))block;
- (void)navigationRightBarButtonTitles:(NSArray <NSString *> *)titles color:(UIColor *)color click:(void(^)(NSInteger buttonTag))block;





@end

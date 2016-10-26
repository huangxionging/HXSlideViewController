//
//  HXSlideViewController.h
//  HXSlideViewController
//
//  Created by huangxiong on 15/10/11.
//  Copyright © 2015年 huangxiong. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  侧滑方向, 表示控制器从哪个方向添加到该控制器上
 */
typedef NS_ENUM(NSUInteger, HXSlideFromDirection) {
    
    /**
     *  从左边
     */
    kHXSlideFromDirectionLeft = 0,
    
    /**
     *  从右边
     */
    kHXSlideFromDirectionRight,
    
    /**
     *  从上边
     */
    kHXSlideFromDirectionTop,
    
    /**
     *  从下边
     */
    kHXSlideFromDirectionBottom,
    
    /**
     *  正面
     */
    kHXSlideFromDirectionFront,
    
    /**
     *  不添加, 只使用在判断方向上
     */
    kHXSlideFromDirectionNone,
};

@protocol  HXSlideViewControllerDelegate <NSObject>

@required
//- (void) viewController: ()

@end

@interface HXSlideViewController : UIViewController

/**
 *  @brief  添加控制器, 从相应的方向
 *  @param  viewController 是相应的控制器, direction 是相应的方向
 *  @return 空
 */
- (void) addViewController: (UIViewController *)viewController fromHXSlideDirection: (HXSlideFromDirection) direction;

/**
 *  @brief  设置指定方向的控制器的视图之间的间隔
 *  @param  gesture 是点击事件
 *  @return 空
 */
- (void) setSpaceForViewControllerWithSpace: (CGFloat) space andWithSlideDirection: (HXSlideFromDirection) direction;

/**
 *  @brief  点击事件, 如
 *  @param  gesture 是点击事件
 *  @return 空
 */
- (void) tapViewcontroller: (UITapGestureRecognizer *) gesture;

/**
 *  @brief  展示指定的控制器
 *  @param  viewController 是点击事件
 *  @return 空
 */
- (void) showViewController:(UIViewController *)viewController;

/**
 *  @brief  隐藏指定的控制器
 *  @param  viewController 是点击事件
 *  @return 空
 */
- (void) hideViewController:(UIViewController *)viewController;
/**
 *  @brief  展示指定方向所有的控制器
 *  @param  direction 是方向
 *  @return 空
 */
- (void) showViewControllersWithSlideDirection: (HXSlideFromDirection) direction;

/**
 *  @brief 隐藏指定方向所有的控制器
 *  @param direction 是方向
 *  @return 空
 */
- (void) hideViewControllersWithSlideDirection: (HXSlideFromDirection) direction;

/**
 *  @brief 查找指定视图对应的控制器
 *  @param view 是控制器的视图, 应当是返回控制器的 view
 *  @return view 对应的控制器
 */
- (UIViewController *) viewControllerForUnknowView: (UIView *) view;

/** 
 *  @brief  为制定控制器添加阴影
 *  @param  viewController 是控制器
 *  @return 空
 */
- (void) addShadowForViewController: (UIViewController *)viewController;

/** 删除制定控制器的阴影
 *  @param: viewController 是控制器
 *  @return: 空
 */
- (void) removeShadowForViewController: (UIViewController *)viewController;

@end

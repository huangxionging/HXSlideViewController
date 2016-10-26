//
//  HXRevealViewController.h
//  HXSlideViewController
//
//  Created by huangxiong on 15/10/30.
//  Copyright © 2015年 huangxiong. All rights reserved.
//

#import "HXSlideViewController.h"

// 控制器类型
typedef NS_ENUM(NSUInteger, RevealViewControllerlType) {
    kReveaViewControllerlType = 0
};

@interface HXRevealViewController : HXSlideViewController

/**
 * 重写点击方法
 */
- (void)tapViewcontroller:(UITapGestureRecognizer *)gesture;

@end

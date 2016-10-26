//
//  HXSlideViewController.m
//  HXSlideViewController
//
//  Created by huangxiong on 15/10/11.
//  Copyright © 2015年 huangxiong. All rights reserved.
//

#import "HXSlideViewController.h"

@interface HXSlideViewController ()

/**
 *  左边滑动控制器数组
 */
@property (nonatomic, strong) NSMutableArray *leftSlideControllers;

/**
 *  左边滑动控制器间隔
 */
@property (nonatomic, assign) CGFloat leftSpace;

/**
 *  右边滑动控制器数组
 */
@property (nonatomic, strong) NSMutableArray *rightSlideControllers;

/**
 *  右边滑动控制器间隔
 */
@property (nonatomic, assign) CGFloat rightSpace;

/**
 *  顶部滑动控制器数组
 */
@property (nonatomic, strong) NSMutableArray *topSlideControllers;

/**
 *  顶部滑动控制器间隔
 */
@property (nonatomic, assign) CGFloat topSpace;

/**
 *  底部滑动控制器数组
 */
@property (nonatomic, strong) NSMutableArray *bottomSlideControllers;

/**
 *  底部滑动控制器间隔
 */
@property (nonatomic, assign) CGFloat bottomSpace;


/**
 *  正面滑动控制器数组
 */
@property (nonatomic, strong) NSMutableArray *frontSlideControllers;

/**
 *  正面滑动控制器间隔
 */
@property (nonatomic, assign) CGFloat frontSpace;

/**
 *  tag 标记控制器使用;
 */
@property (nonatomic, assign) NSInteger tag;

@end

@implementation HXSlideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _tag = 100010;
}

#pragma mark---添加控制器
- (void) addViewController: (UIViewController *)viewController fromHXSlideDirection: (HXSlideFromDirection) direction {
    
    if (direction == kHXSlideFromDirectionNone) {
        NSLog(@"kHXSlideFromDirectionNone 不能在外部使用");
        return;
    }
    
    // 添加子视图
    [self.view addSubview: viewController.view];
    [self addShadowForViewController: viewController];
    
    // 为子视图添加手势
    [viewController.view addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(tapViewcontroller:)]];
    

    
    // 根据不同的方向保持控制器
    switch (direction) {
        case kHXSlideFromDirectionLeft: {
            
            // 初始化控制器
            if (_leftSlideControllers == nil) {
                _leftSlideControllers = [NSMutableArray arrayWithCapacity: 1];
            }
            
            // 添加控制器
            [_leftSlideControllers addObject: viewController];
            viewController.view.right = 0;
            viewController.view.tag = (direction + 1) * _tag + _leftSlideControllers.count;
            break;
        }
            
        case kHXSlideFromDirectionRight: {
            // 初始化控制器
            if (_rightSlideControllers == nil) {
                _rightSlideControllers = [NSMutableArray arrayWithCapacity: 1];
            }
            
            // 添加控制器
            [_rightSlideControllers addObject: viewController];
            viewController.view.left = self.view.right;
            viewController.view.tag = (direction + 1) * _tag + _rightSlideControllers.count;
            break;
        }
            
        case kHXSlideFromDirectionTop: {
            // 初始化控制器
            if (_topSlideControllers == nil) {
                _topSlideControllers = [NSMutableArray arrayWithCapacity: 1];
            }
            
            // 添加控制器
            [_topSlideControllers addObject: viewController];
            viewController.view.bottom = 0;
            viewController.view.tag = (direction + 1) * _tag + _topSlideControllers.count;
            break;
        }
        
        case kHXSlideFromDirectionBottom: {
            // 初始化控制器
            if (_bottomSlideControllers == nil) {
                _bottomSlideControllers = [NSMutableArray arrayWithCapacity: 1];
            }
            
            // 添加控制器
            [_bottomSlideControllers addObject: viewController];
            viewController.view.top = self.view.bottom;
            viewController.view.tag = (direction + 1) * _tag + _bottomSlideControllers.count;
            break;
        }
        
        case kHXSlideFromDirectionFront: {
            // 初始化控制器
            if (_frontSlideControllers == nil) {
                _frontSlideControllers = [NSMutableArray arrayWithCapacity: 1];
            }
            
            // 添加控制器
            [_frontSlideControllers addObject: viewController];
            viewController.view.left = (self.view.width - viewController.view.width) / 2;
            viewController.view.top = (self.view.height - viewController.view.height) / 2;
            viewController.view.tag = (direction + 1) * _tag + _frontSlideControllers.count;
            break;
        }
            
        default:
            break;
    }
}

#pragma mark--- 视图被点击点击事件
- (void) tapViewcontroller: (UITapGestureRecognizer *) gesture {
    
    if (_tag == 0) {
        return;
    }
    
    // 查找控制器
    UIViewController *viewController = [self viewControllerForUnknowView: gesture.view];
    
    if (viewController == nil) {
        return;
    }
    
    // 展示控制器
    [self showViewController: viewController];
}

#pragma mark--- 查找对应视图给定的控制器
- (UIViewController *) viewControllerForUnknowView: (UIView *) view {
    if (_tag == 0) {
        return nil;
    }
    
    // 查找方向
    HXSlideFromDirection direction =  view.tag / _tag - 1;
    
    // 查找索引值
    NSInteger index = view.tag % _tag;
    
    // 查找控制器
    UIViewController *viewController = nil;
    
    switch (direction) {
        case kHXSlideFromDirectionLeft: {
            viewController = _leftSlideControllers[index - 1];
            break;
        }
            
        case kHXSlideFromDirectionRight: {
            viewController = _rightSlideControllers[index -1];
            break;
        }
            
        case kHXSlideFromDirectionTop: {
            viewController = _topSlideControllers[index -1];
            break;
        }
            
        case kHXSlideFromDirectionBottom: {
            viewController = _bottomSlideControllers[index -1];
            break;
        }
            
        case kHXSlideFromDirectionFront: {
            viewController = _frontSlideControllers[index -1];
            break;
        }
            
        default:
            break;
    }
    
    return viewController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark---设置控制器间隔
- (void) setSpaceForViewControllerWithSpace:(CGFloat)space andWithSlideDirection:(HXSlideFromDirection)direction {
    
    // 根据方向设置间隔
    switch (direction) {
        case kHXSlideFromDirectionLeft: {
            _leftSpace = space;
            break;
        }
            
        case kHXSlideFromDirectionRight: {
            _rightSpace = space;
            break;
        }
            
        case kHXSlideFromDirectionTop: {
            _topSpace = space;
            break;
        }
            
        case kHXSlideFromDirectionBottom: {
            _bottomSpace = space;
            break;
        }
            
        case kHXSlideFromDirectionFront: {
            _frontSpace = space;
            break;
        }

            
        default:
            break;
    }
}

#pragma mark---展示指定的控制器
- (void)showViewController:(UIViewController *)viewController {
    
    [UIView animateWithDuration: 0.3 animations:^{
        // 计算坐标
        viewController.view.left = (self.view.width - viewController.view.width) / 2;
        viewController.view.top = (self.view.top - viewController.view.top) / 2;
    }];
    
    // 将指定控制器的 View 带到顶层
    [self.view bringSubviewToFront: viewController.view];
}

#pragma mark---展示指定方向所有的控制器
- (void)showViewControllersWithSlideDirection:(HXSlideFromDirection)direction {
    // 根据不同的方向保持控制器
    switch (direction) {
        case kHXSlideFromDirectionLeft: {
            // 对所有的
            NSInteger index = _leftSlideControllers.count;
            for (UIViewController *viewController in _leftSlideControllers) {
                NSLog(@"%@", NSStringFromCGRect(viewController.view.frame));
                [self.view bringSubviewToFront: viewController.view];
                [UIView animateWithDuration: 0.3 animations:^{
                   viewController.view.right = _leftSpace * index;
                }];
                --index;
            }
            break;
        }
            
        case kHXSlideFromDirectionRight: {
            NSInteger index = _rightSlideControllers.count;
            
            for (UIViewController *viewController in _rightSlideControllers) {
                NSLog(@"%@", NSStringFromCGRect(viewController.view.frame));
                [self.view bringSubviewToFront: viewController.view];
                [UIView animateWithDuration: 0.3 animations:^{
                   viewController.view.left = self.view.right - _rightSpace * index;
                }];
                --index;
            }
            break;
        }
            
        case kHXSlideFromDirectionTop: {
            NSInteger index = _topSlideControllers.count;
            for (UIViewController *viewController in _topSlideControllers) {
                [self.view bringSubviewToFront: viewController.view];
                [UIView animateWithDuration: 0.3 animations:^{
                    viewController.view.bottom = _topSpace * index;
                }];
                
                --index;
            }
            break;
        }
            
        case kHXSlideFromDirectionBottom: {
            NSInteger index = _bottomSlideControllers.count;
            for (UIViewController *viewController in _bottomSlideControllers) {
                [self.view bringSubviewToFront: viewController.view];
                [UIView animateWithDuration: 0.3 animations:^{
                    viewController.view.top = self.view.bottom - _bottomSpace * index;
                }];
                
                --index;
            }
            break;
        }
            
        default:
            break;
    }
}

#pragma mark---获取指定控制器所在的方向
- (HXSlideFromDirection) directionForViewController: (UIViewController *)viewController {
    
    if (_tag == 0 || viewController.view.tag == 0) {
        return kHXSlideFromDirectionNone;
    }
    return viewController.view.tag / _tag - 1;
}

#pragma mark---隐藏控制器
- (void)hideViewController:(UIViewController *)viewController {
    
    HXSlideFromDirection direction = [self directionForViewController: viewController];
    
    NSInteger index = viewController.view.tag % _tag;
    
    // 将指定控制器的 View 带到顶层
    [self.view bringSubviewToFront: viewController.view];
    switch (direction) {
        case kHXSlideFromDirectionLeft: {
            
            [UIView animateWithDuration: 0.3 animations:^{
                viewController.view.right = _leftSlideControllers.count * _leftSpace;
            }];
            break;
        }
            
        case kHXSlideFromDirectionRight: {
            [UIView animateWithDuration: 0.3 animations:^{
                viewController.view.left += _rightSlideControllers.count * _rightSpace;
            }];
            break;
        }
            
        case kHXSlideFromDirectionTop: {
            [UIView animateWithDuration: 0.3 animations:^{
                viewController.view.bottom -= _topSlideControllers.count - _topSpace;
            }];
            break;
        }
            
        case kHXSlideFromDirectionBottom: {
            [UIView animateWithDuration: 0.3 animations:^{
                viewController.view.top += _topSlideControllers.count * _bottomSpace;
            }];
            break;
        }
            
        default:
            break;
    }
}

#pragma mark---隐藏指定方向上所有的控制器
- (void)hideViewControllersWithSlideDirection:(HXSlideFromDirection)direction {
    // 根据不同的方向保持控制器
    switch (direction) {
        case kHXSlideFromDirectionLeft: {
            
            // 对所有的
            NSInteger index = _leftSlideControllers.count - 1;
            
            for (UIViewController *viewController in [_leftSlideControllers reverseObjectEnumerator]) {
                [self.view sendSubviewToBack: viewController.view];
                NSLog(@"%@", NSStringFromCGRect(viewController.view.frame));
                [UIView animateWithDuration: 0.3 animations:^{
                    // 计算新的位置
                    viewController.view.right = _leftSpace * index - _leftSlideControllers.count * _leftSpace;
                }];
                --index;
            }
            break;
        }
            
        case kHXSlideFromDirectionRight: {
            NSInteger index = _rightSlideControllers.count;
            for (UIViewController *viewController in [_rightSlideControllers reverseObjectEnumerator]) {
                NSLog(@"%@", NSStringFromCGRect(viewController.view.frame));
                [self.view sendSubviewToBack: viewController.view];
                [UIView animateWithDuration: 0.3 animations:^{
                    viewController.view.left = self.view.right + _rightSpace * index;
                }];
                
                --index;
            }
            break;
        }
            
        case kHXSlideFromDirectionTop: {
            NSInteger index = _topSlideControllers.count - 1;
            for (UIViewController *viewController in [_topSlideControllers reverseObjectEnumerator]) {
                [self.view sendSubviewToBack: viewController.view];
                [UIView animateWithDuration: 0.3 animations:^{
                    viewController.view.bottom = _topSpace * index - _topSlideControllers.count * _topSpace;
                }];
                
                --index;
            }
            break;
        }
            
        case kHXSlideFromDirectionBottom: {
            NSInteger index = _bottomSlideControllers.count;
            for (UIViewController *viewController in [_bottomSlideControllers reverseObjectEnumerator]) {
                [self.view sendSubviewToBack: viewController.view];
                [UIView animateWithDuration: 0.3 animations:^{
                    viewController.view.top = self.view.bottom + _bottomSpace * index;
                }];
                
                --index;
            }
            break;
        }
            
        default:
            break;
    }
}

#pragma mark---添加阴影
- (void) addShadowForViewController: (UIViewController *)viewController {
    viewController.view.layer.shadowOffset = CGSizeZero;
    viewController.view.layer.shadowOpacity = 0.75f;
    viewController.view.layer.shadowRadius = 10.0f;
    viewController.view.layer.shadowColor = [UIColor blackColor].CGColor;
    viewController.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.view.layer.bounds].CGPath;
    viewController.view.clipsToBounds = NO;
}

#pragma mark---删除阴影
- (void) removeShadowForViewController: (UIViewController *)viewController {
    viewController.view.layer.shadowPath = nil;
    viewController.view.layer.shadowOpacity = 0.0f;
    viewController.view.layer.shadowRadius = 0.0;
    viewController.view.layer.shadowColor = nil;
}

@end

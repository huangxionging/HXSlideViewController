//
//  HXRootViewController.m
//  HXSlideViewController
//
//  Created by huangxiong on 15/10/18.
//  Copyright © 2015年 huangxiong. All rights reserved.
//

#import "HXRootViewController.h"
#import "HXSlideViewController.h"
#import "ARightViewController.h"
#import "ALeftViewController.h"
#import "BRightViewController.h"
#import "BLeftViewController.h"

@interface HXRootViewController () {
    HXSlideViewController *_sliderVC;
}

@end

@implementation HXRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    [self performSelector: @selector(slideViewController) withObject: nil afterDelay: 0.0];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) slideViewController {
    _sliderVC = [[HXSlideViewController alloc] init];
    
    _sliderVC.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target: self action: @selector(leftClick:)];
    
    _sliderVC.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemAction target: self action: @selector(rightClick:)];
    
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController: _sliderVC];
    
    [self presentViewController: navVC animated: YES completion:^{
        
    }];
    
    ALeftViewController *aLeftVC = [[ALeftViewController alloc] init];
    
    BLeftViewController *bLeftVC = [[BLeftViewController alloc] init];
    
    ARightViewController *aRightVC = [[ARightViewController alloc] init];
    
    BRightViewController *bRightVC = [[BRightViewController alloc] init];
    
    [_sliderVC addViewController: aLeftVC  fromHXSlideDirection:kHXSlideFromDirectionLeft];
    
    [_sliderVC addViewController: bLeftVC  fromHXSlideDirection:kHXSlideFromDirectionLeft];
    
    [_sliderVC addViewController: aRightVC  fromHXSlideDirection:kHXSlideFromDirectionLeft];
    
    [_sliderVC addViewController: bRightVC  fromHXSlideDirection:kHXSlideFromDirectionLeft];
    
    
    [_sliderVC setSpaceForViewControllerWithSpace: 50 andWithSlideDirection: kHXSlideFromDirectionLeft];
    [_sliderVC setSpaceForViewControllerWithSpace: 50 andWithSlideDirection: kHXSlideFromDirectionTop];
}

- (void) leftClick: (UIBarButtonItem *)sender {
    
    static NSInteger countLeft = 0;
    
    if (countLeft == 0) {
        [_sliderVC showViewControllersWithSlideDirection: kHXSlideFromDirectionLeft];
        countLeft = 1;
    }
    else if (countLeft == 1){
        [_sliderVC hideViewControllersWithSlideDirection: kHXSlideFromDirectionLeft];
        countLeft = 0;
    }
    
}

- (void) rightClick: (UIBarButtonItem *)sender {
    static NSInteger countRight = 0;
    
    if (countRight == 0) {
        [_sliderVC showViewControllersWithSlideDirection: kHXSlideFromDirectionRight];
        countRight = 1;
    }
    else if (countRight == 1){
        [_sliderVC hideViewControllersWithSlideDirection: kHXSlideFromDirectionRight];
        countRight = 0;
    }

}

@end

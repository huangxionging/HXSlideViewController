//
//  ViewController.m
//  HXSlideViewController
//
//  Created by huangxiong on 15/8/4.
//  Copyright (c) 2015年 huangxiong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    UIViewController *leftViewController;
    UIViewController *rightViewController;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    unsigned int O[2];
    ((unsigned int *)O)[0] = 1;
        NSLog(@"%d", ((int *)O)[0]);
    // Do any additional setup after loading the view, typically from a nib.
    
    leftViewController = [[UIViewController alloc] init];
    
    leftViewController.view.backgroundColor = [UIColor yellowColor];
    leftViewController.title = @"左";
    
    [leftViewController.view addGestureRecognizer: [[UIPanGestureRecognizer alloc] initWithTarget: self action: @selector(handlePan:)]];
    
    rightViewController = [[UIViewController alloc] init];
    
    [rightViewController.view addGestureRecognizer: [[UIPanGestureRecognizer alloc] initWithTarget: self action: @selector(handlePan:)]];
    
    rightViewController.view.backgroundColor = [UIColor redColor];
    rightViewController.title = @"右";
    
    [self.view addSubview: leftViewController.view];
    [self.view addSubview: rightViewController.view];
    
    
    
}

- (void) handlePan: (UIPanGestureRecognizer *)gesture {
    
    CGPoint point = [gesture locationInView: self.view];
    
    if ([gesture.view isEqual: leftViewController.view]) {
        gesture.view.center = CGPointMake(point.x, gesture.view.center.y);
    }
    else if ([gesture.view isEqual: rightViewController.view]) {
        gesture.view.center = CGPointMake(point.x, gesture.view.center.y);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)leftClick:(UIBarButtonItem *)sender {
    [self.view bringSubviewToFront: leftViewController.view];
}

- (IBAction)rightClick:(UIBarButtonItem *)sender {
    
    [self.view bringSubviewToFront: rightViewController.view];
}
@end

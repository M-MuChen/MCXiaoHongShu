//
//  MyNavigationController.m
//  ZhiZhu
//
//  Created by 周陆洲 on 16/5/18.
//  Copyright © 2016年 wt-vrs. All rights reserved.
//

#import "MyNavigationController.h"

@interface MyNavigationController ()<UINavigationControllerDelegate>

@property (nonatomic, weak) id PopDelegate;

@end

@implementation MyNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.PopDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController == self.viewControllers[0]) {
        self.interactivePopGestureRecognizer.delegate = self.PopDelegate;
    }else{
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}

-(UIViewController *)childViewControllerForStatusBarStyle
{
    return self.topViewController;
}

@end

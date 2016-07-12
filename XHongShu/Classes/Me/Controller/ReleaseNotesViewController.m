//
//  ReleaseNotesViewController.m
//  XHongShu
//
//  Created by 宋江 on 16/6/13.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "ReleaseNotesViewController.h"

@interface ReleaseNotesViewController ()<UIScrollViewDelegate>
{
    UIScrollView *_releaseScrollView;
}
@end

@implementation ReleaseNotesViewController
- (BOOL)prefersStatusBarHidden{
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self barbtnItem];
    [self createUI];

}
- (void)barbtnItem{
    UIBarButtonItem *setItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = setItem;
}
- (void)createUI{
    self.navigationItem.title = @"发布笔记";
    _releaseScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 44, VIEW_WEDTH, VIEW_HEIGHT -88)];
    [self.view addSubview:_releaseScrollView];
}

#pragma mark 取消
- (void)cancel{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

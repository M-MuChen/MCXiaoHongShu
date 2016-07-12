//
//  NavTransitioningBack.m
//  XHongShu
//
//  Created by 周陆洲 on 16/6/12.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "NavTransitioningBack.h"
#import "HomeViewController.h"
#import "NotesDetailViewController.h"
#import "NotesCollectionCell.h"

@implementation NavTransitioningBack

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.6f;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    NotesDetailViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    HomeViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    
    UIView *snapShotView = [fromVC.imageScrollView snapshotViewAfterScreenUpdates:NO];
    snapShotView.frame = [containerView convertRect:fromVC.imageScrollView.frame fromView:fromVC.imageScrollView.superview];
    fromVC.imageScrollView.hidden = YES;
    
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha = 0;
    
    NotesCollectionCell *cell = (NotesCollectionCell *)[toVC.collectionView cellForItemAtIndexPath:toVC.currentIndexPath];
    cell.itemImage.hidden = YES;
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:snapShotView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toVC.view.alpha = 1.0;
        snapShotView.frame = toVC.finalCellRect;
        
    }completion:^(BOOL finished) {
        [snapShotView removeFromSuperview];
        fromVC.imageScrollView.hidden = NO;
        cell.itemImage.hidden = NO;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}
@end
